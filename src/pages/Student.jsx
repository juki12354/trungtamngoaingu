import { useState } from "react";
import { PasswordForm, WeeklySchedule } from "./ManagementPanels";
import { QuizReview } from "./Placement";
import { downloadFile } from "../download";
import { Link, Navigate } from "react-router-dom";
import {
  ArrowRight,
  Check,
  CalendarDays,
  BookOpen,
  UserRound,
  ClipboardCheck,
  Download,
} from "lucide-react";
import {
  useApp,
  useLoad,
  api,
  PageHeading,
  Field,
  ErrorMessage,
  Loading,
  Empty,
  date,
  statusText,
} from "../lib";
export function Student() {
  const { user } = useApp();
  if (!user) return <Navigate replace to="/dang-nhap?next=/hoc-vien" />;
  return <StudentContent />;
}
function StudentContent() {
  const { user, setUser, catalog } = useApp();
  const { data, error, reload } = useLoad("/student");
  const [tab, setTab] = useState("courses"),
    [notice, setNotice] = useState(""),
    [formError, setFormError] = useState(""),
    [busy, setBusy] = useState(false);
  if (error)
    return (
      <div className="container section">
        <ErrorMessage>{error}</ErrorMessage>
        <button className="button" onClick={reload}>
          Thử lại
        </button>
      </div>
    );
  if (!data) return <Loading />;
  async function save(e) {
    e.preventDefault();
    setBusy(true);
    setNotice("");
    setFormError("");
    try {
      const result = await api("/student", {
        method: "PATCH",
        body: Object.fromEntries(new FormData(e.currentTarget)),
      });
      setUser(result.user);
      setNotice("Đã cập nhật hồ sơ của bạn.");
      reload();
    } catch (e) {
      setFormError(e.message);
    } finally {
      setBusy(false);
    }
  }
  function download(material) {
    const blob = new Blob([material.name + "\n\n" + material.material], {
      type: "text/plain;charset=utf-8",
    });
    const url = URL.createObjectURL(blob);
    const anchor = document.createElement("a");
    anchor.href = url;
    anchor.download = `tai-lieu-${material.id}.txt`;
    anchor.click();
    setTimeout(() => URL.revokeObjectURL(url), 1000);
  }
  return (
    <>
      <PageHeading
        eyebrow="KHÔNG GIAN HỌC TẬP CỦA BẠN"
        title={`Xin chào, ${user.name}!`}
      >
        Mỗi ngày một chút tiến bộ. Cùng nhìn lại hành trình của bạn nhé.
      </PageHeading>
      <section className="section container">
        <div className="portal-tabs">
          {[
            ["courses", BookOpen, "Khóa học & lịch học"],
            ["grades", ClipboardCheck, "Kết quả học tập"],
            ["materials", Download, "Tài liệu"],
            ["profile", UserRound, "Hồ sơ cá nhân"],
            ["password", UserRound, "Đổi mật khẩu"],
          ].map(([key, Icon, title]) => (
            <button
              key={key}
              className={tab === key ? "active" : ""}
              onClick={() => setTab(key)}
            >
              <Icon size={18} />
              {title}
            </button>
          ))}
        </div>
        {tab === "courses" && (
          <>
            <WeeklySchedule enrollments={data.enrollments} catalog={catalog} />
            <div className="student-courses">
              {data.enrollments.map((e) => {
                const cls = catalog.classes.find((c) => c.id === e.classId),
                  course = catalog.courses.find((c) => c.id === cls?.courseId);
                return (
                  <article className="student-course" key={e.id}>
                    <img src={course?.image} alt="" />
                    <div>
                      <span className={`badge ${e.status}`}>
                        {statusText[e.status]}
                      </span>
                      <h2>{course?.name}</h2>
                      <p>
                        {cls?.name} · {cls?.campus}
                      </p>
                      <p>
                        <CalendarDays size={17} />
                        {cls?.schedule}
                      </p>
                      <p>
                        {date(cls?.startDate)} – {date(cls?.endDate)}
                      </p>
                      {e.status === "pending" && (
                        <p className="muted">
                          Trung tâm đang tiếp nhận đăng ký của bạn.
                        </p>
                      )}
                    </div>
                  </article>
                );
              })}
            </div>
            {!data.enrollments.length && (
              <Empty>
                Bạn chưa đăng ký lớp nào. Hãy tìm một khóa học phù hợp để bắt
                đầu.
              </Empty>
            )}
            <Link className="button" to="/khoa-hoc">
              Khám phá thêm khóa học
              <ArrowRight size={18} />
            </Link>
          </>
        )}
        {tab === "grades" && (
          <>
            <h2>Điểm kỹ năng</h2>
            <div className="table-wrap">
              <table>
                <thead>
                  <tr>
                    <th>Lớp học</th>
                    <th>Listening</th>
                    <th>Reading</th>
                    <th>Writing</th>
                    <th>Speaking</th>
                  </tr>
                </thead>
                <tbody>
                  {data.enrollments
                    .filter((e) => e.status === "confirmed")
                    .map((e) => (
                      <tr key={e.id}>
                        <td>
                          {
                            catalog.classes.find((c) => c.id === e.classId)
                              ?.name
                          }
                        </td>
                        {["listening", "reading", "writing", "speaking"].map(
                          (k) => (
                            <td key={k}>{e.grades[k] ?? "Chưa có điểm"}</td>
                          ),
                        )}
                      </tr>
                    ))}
                </tbody>
              </table>
            </div>
            <p className="muted small-text">
              Điểm theo thang 10 của trung tâm, không phải điểm thi IELTS chính
              thức.
            </p>
            <h2>Lịch sử kiểm tra trình độ</h2>
            {data.results.length ? (
              <div className="table-wrap">
                <table>
                  <thead>
                    <tr>
                      <th>Lần kiểm tra</th>
                      <th>Số câu đúng</th>
                      <th>Mức tham khảo</th>
                    </tr>
                  </thead>
                  <tbody>
                    {data.results.map((r) => (
                      <tr key={r.id}>
                        <td>
                          #{r.id} · {r.createdAt}
                        </td>
                        <td>
                          {r.score}/{r.total}
                        </td>
                        <td>
                          {r.level}
                          <QuizReview review={r.review} />
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            ) : (
              <Empty>
                Chưa có bài kiểm tra đã lưu. Hãy làm bài khi đang đăng nhập.
              </Empty>
            )}
          </>
        )}
        {tab === "materials" && (
          <>
            <h2>Tài liệu học tập</h2>
            <ErrorMessage>{formError}</ErrorMessage>
            {data.files.map((f) => (
              <div className="material-card" key={f.id}>
                <BookOpen size={27} />
                <div>
                  <h3>{f.title}</h3>
                  <p>
                    {f.lesson} · {f.filename}
                  </p>
                </div>
                <button
                  className="button outline"
                  onClick={() =>
                    downloadFile(
                      `/materials/${f.id}/download`,
                      f.filename,
                    ).catch((e) => setFormError(e.message))
                  }
                >
                  Tải tệp
                </button>
              </div>
            ))}
            {data.materials.length ? (
              data.materials.map((m) => (
                <div className="material-card" key={m.id}>
                  <BookOpen size={27} />
                  <div>
                    <h3>{m.name}</h3>
                    <p>Nội dung ôn tập và bài tập tự học</p>
                  </div>
                  <button
                    className="button outline"
                    onClick={() => download(m)}
                  >
                    <Download size={17} />
                    Tải tài liệu
                  </button>
                </div>
              ))
            ) : (
              <Empty>
                Tài liệu sẽ xuất hiện khi đăng ký lớp được xác nhận.
              </Empty>
            )}
          </>
        )}
        {tab === "profile" && (
          <form className="form-panel profile-form" onSubmit={save}>
            <h2>Hồ sơ cá nhân</h2>
            <Field
              label="Họ và tên"
              name="name"
              defaultValue={user.name}
              required
            />
            <Field label="Email" value={user.email} readOnly />
            <Field
              label="Số điện thoại"
              name="phone"
              defaultValue={user.phone}
              type="tel"
              required
              pattern="(0|\+84)[0-9]{9,10}"
            />
            <Field
              label="Ngày sinh"
              name="birthday"
              type="date"
              defaultValue={user.birthday}
              max={new Date().toISOString().slice(0, 10)}
            />
            <ErrorMessage>{formError}</ErrorMessage>
            {notice && (
              <p className="notice" role="status">
                {notice}
              </p>
            )}
            <button className="button" disabled={busy}>
              {busy ? "Đang lưu…" : "Lưu thay đổi"}
              <Check size={18} />
            </button>
          </form>
        )}
        {tab === "password" && <PasswordForm />}
      </section>
    </>
  );
}
