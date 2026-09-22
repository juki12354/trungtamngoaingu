import { useState } from "react";
import { Link, useSearchParams } from "react-router-dom";
import { ArrowRight } from "lucide-react";
import {
  useApp,
  api,
  PageHeading,
  Field,
  ErrorMessage,
  Success,
  money,
} from "../lib";
export function Enrollment() {
  const { catalog, user, refreshCatalog } = useApp();
  const [params] = useSearchParams();
  const initialClass = catalog.classes.find(
    (c) => c.id === Number(params.get("class")),
  );
  const [courseId, setCourseId] = useState(
    String(
      initialClass?.courseId ||
        params.get("course") ||
        catalog.courses[0]?.id ||
        "",
    ),
  );
  const [classId, setClassId] = useState(String(initialClass?.id || ""));
  const [busy, setBusy] = useState(false),
    [error, setError] = useState(""),
    [result, setResult] = useState(null);
  const classes = catalog.classes.filter(
    (c) => c.courseId === Number(courseId) && c.effectiveStatus === "enrolling",
  );
  const course = catalog.courses.find((c) => c.id === Number(courseId));
  async function submit(e) {
    e.preventDefault();
    setBusy(true);
    setError("");
    const body = Object.fromEntries(new FormData(e.currentTarget));
    body.classId = Number(classId);
    try {
      const data = await api("/enrollments", { method: "POST", body });
      setResult(data);
      refreshCatalog().catch(() => {});
    } catch (e) {
      setError(e.message);
    } finally {
      setBusy(false);
    }
  }
  return (
    <>
      <PageHeading
        eyebrow="ĐĂNG KÝ KHÓA HỌC"
        title="Bước đầu tiên cho hành trình mới."
      >
        Chọn lớp học và để lại thông tin. Vinh English sẽ đồng hành cùng bạn từ
        đây.
      </PageHeading>
      <section className="section container registration-grid">
        <div className="form-panel">
          {result ? (
            <Success
              title="Đăng ký thành công!"
              to={user ? "/hoc-vien" : "/khoa-hoc"}
              link={user ? "Xem đăng ký của tôi" : "Khám phá thêm khóa học"}
            >
              Mã đăng ký #{result.id}. Thông tin đã được lưu và đang chờ trung
              tâm xác nhận. Bạn chưa cần thanh toán.
            </Success>
          ) : (
            <form onSubmit={submit}>
              <h2>Thông tin của bạn</h2>
              {!user && (
                <p className="form-hint">
                  Đã có tài khoản?{" "}
                  <Link to="/dang-nhap?next=/dang-ky">Đăng nhập</Link> để theo
                  dõi lớp học sau khi đăng ký.
                </p>
              )}
              <div className="form-grid">
                <Field
                  label="Họ và tên *"
                  name="name"
                  autoComplete="name"
                  required
                  maxLength={100}
                  defaultValue={user?.name}
                />
                <Field
                  label="Ngày sinh"
                  name="birthday"
                  type="date"
                  max={new Date().toISOString().slice(0, 10)}
                  defaultValue={user?.birthday}
                />
                <Field
                  label="Số điện thoại *"
                  name="phone"
                  type="tel"
                  autoComplete="tel"
                  placeholder="09xx xxx xxx"
                  pattern="(0|\+84)[0-9]{9,10}"
                  required
                  defaultValue={user?.phone}
                />
                <Field
                  label="Email *"
                  name="email"
                  type="email"
                  autoComplete="email"
                  required
                  defaultValue={user?.email}
                  readOnly={Boolean(user)}
                />
              </div>
              <h3>Chọn lớp phù hợp</h3>
              <Field label="Khóa học *">
                <select
                  value={courseId}
                  onChange={(e) => {
                    setCourseId(e.target.value);
                    setClassId("");
                  }}
                  required
                >
                  <option value="">Chọn khóa học</option>
                  {catalog.courses.map((c) => (
                    <option key={c.id} value={c.id}>
                      {c.name}
                    </option>
                  ))}
                </select>
              </Field>
              <Field label="Lớp, ca học và cơ sở *">
                <select
                  value={classId}
                  onChange={(e) => setClassId(e.target.value)}
                  required
                >
                  <option value="">Chọn lớp học</option>
                  {classes.map((c) => (
                    <option
                      key={c.id}
                      value={c.id}
                      disabled={c.enrolled >= c.capacity}
                    >
                      {c.name} · {c.schedule} · {c.campus}
                      {c.enrolled >= c.capacity ? " (Đã đủ chỗ)" : ""}
                    </option>
                  ))}
                </select>
              </Field>
              {!classes.length && (
                <p className="muted">
                  Chưa có lớp mở cho khóa này.{" "}
                  <Link to="/lien-he">Liên hệ tư vấn</Link>
                </p>
              )}
              <Field label="Ghi chú">
                <textarea
                  name="note"
                  rows={3}
                  maxLength={2000}
                  placeholder="Mục tiêu học tập hoặc điều bạn muốn chúng tôi biết…"
                />
              </Field>
              <label className="check-field">
                <input type="checkbox" required />
                Tôi đồng ý để trung tâm sử dụng thông tin trên để liên hệ về
                đăng ký này.
              </label>
              <ErrorMessage>{error}</ErrorMessage>
              <button className="button full" disabled={busy}>
                {busy ? "Đang gửi đăng ký…" : "Gửi đăng ký khóa học"}
                <ArrowRight size={18} />
              </button>
            </form>
          )}
        </div>
        <aside className="registration-aside">
          <span className="eyebrow">HÀNH TRÌNH CỦA BẠN</span>
          <h2>
            Một khởi đầu.
            <br />
            Nhiều điều tốt đẹp.
          </h2>
          {course && (
            <div className="selected-course">
              <img src={course.image} alt={course.name} />
              <h3>{course.name}</h3>
              <p>
                {course.duration} tuần · {course.lessons} buổi
              </p>
              <strong>{money(course.tuition)}</strong>
            </div>
          )}
          <ol className="steps">
            <li>
              <span>01</span>
              <div>
                <strong>Chọn lớp, gửi đăng ký</strong>
                <p>Chỉ mất vài phút để bắt đầu.</p>
              </div>
            </li>
            <li>
              <span>02</span>
              <div>
                <strong>Trung tâm xác nhận</strong>
                <p>Tư vấn lộ trình và giải đáp thắc mắc.</p>
              </div>
            </li>
            <li>
              <span>03</span>
              <div>
                <strong>Sẵn sàng vào lớp</strong>
                <p>Gặp thầy cô và những người bạn mới.</p>
              </div>
            </li>
          </ol>
          <Link className="text-link" to="/kiem-tra">
            Chưa rõ trình độ? Làm bài test
            <ArrowRight size={16} />
          </Link>
        </aside>
      </section>
    </>
  );
}
