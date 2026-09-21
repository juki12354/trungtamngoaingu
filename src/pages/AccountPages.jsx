import { useState } from "react";
import {
  Link,
  Navigate,
  useLocation,
  useNavigate,
  useSearchParams,
} from "react-router-dom";
import {
  ArrowRight,
  ArrowLeft,
  Check,
  CalendarDays,
  BookOpen,
  UserRound,
  ClipboardCheck,
  Download,
  GraduationCap,
  CheckCircle2,
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
  Success,
  money,
  date,
  statusText,
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
    (c) =>
      c.courseId === Number(courseId) &&
      c.endDate >= new Date().toISOString().slice(0, 10),
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
export function Placement() {
  const { data: questions, error: loadError, reload } = useLoad("/questions");
  const { catalog } = useApp();
  const [started, setStarted] = useState(false),
    [index, setIndex] = useState(0),
    [answers, setAnswers] = useState({}),
    [result, setResult] = useState(null),
    [error, setError] = useState(""),
    [busy, setBusy] = useState(false);
  if (loadError)
    return (
      <div className="section container">
        <ErrorMessage>{loadError}</ErrorMessage>
        <button className="button" onClick={reload}>
          Thử lại
        </button>
      </div>
    );
  if (!questions) return <Loading />;
  if (!questions.length)
    return (
      <PageHeading title="Bài kiểm tra đang được cập nhật">
        Vui lòng quay lại sau hoặc liên hệ trung tâm.
      </PageHeading>
    );
  async function submit() {
    if (Object.keys(answers).length !== questions.length) {
      setError("Bạn cần trả lời tất cả câu hỏi trước khi nộp bài.");
      return;
    }
    setBusy(true);
    setError("");
    try {
      setResult(await api("/placement", { method: "POST", body: { answers } }));
    } catch (e) {
      setError(e.message);
    } finally {
      setBusy(false);
    }
  }
  const q = questions[index],
    suggested = catalog.courses.find((c) => c.id === result?.courseId);
  return (
    <>
      <PageHeading
        eyebrow="KIỂM TRA TRÌNH ĐỘ"
        title="Hiểu mình hơn. Bắt đầu đúng hơn."
      >
        Một bài kiểm tra ngắn để tìm điểm xuất phát phù hợp với bạn.
      </PageHeading>
      <section className="section container test-container">
        {result ? (
          <div className="form-panel test-result">
            <span className="result-icon">
              <GraduationCap size={36} />
            </span>
            <span className="eyebrow">BẠN ĐÃ HOÀN THÀNH BÀI KIỂM TRA</span>
            <h2>Thêm một bước hiểu chính mình!</h2>
            <div className="score">
              {result.score}
              <span>/{result.total}</span>
            </div>
            <span className="badge">Mức tham khảo: {result.level}</span>
            <p>
              Đây là bài sàng lọc ngữ pháp và từ vựng, không phải kết quả CEFR
              chính thức. Cần đánh giá thêm nghe, nói và viết để xếp lớp chính
              xác.
            </p>
            {suggested && (
              <div className="recommendation">
                <span className="eyebrow">GỢI Ý CHO BẠN</span>
                <h3>{suggested.name}</h3>
                <p>{suggested.description}</p>
                <Link className="button" to={`/khoa-hoc/${suggested.id}`}>
                  Xem khóa học phù hợp
                  <ArrowRight size={18} />
                </Link>
              </div>
            )}
            <button
              className="text-button"
              onClick={() => {
                setStarted(false);
                setResult(null);
                setAnswers({});
                setIndex(0);
                setError("");
                reload();
              }}
            >
              Làm lại bài kiểm tra
            </button>
          </div>
        ) : !started ? (
          <div className="form-panel test-intro">
            <ClipboardCheck size={52} />
            <h2>Sẵn sàng khám phá trình độ của bạn?</h2>
            <p>Không áp lực điểm số. Hãy chọn đáp án bạn thấy phù hợp nhất.</p>
            <div className="test-facts">
              <span>
                <strong>{questions.length}</strong>Câu hỏi trắc nghiệm
              </span>
              <span>
                <strong>10–15</strong>Phút dự kiến
              </span>
              <span>
                <strong>Miễn phí</strong>Không cần đăng nhập
              </span>
            </div>
            <p className="muted">
              Bài kiểm tra ngữ pháp và từ vựng chỉ mang tính tham khảo để gợi ý
              khóa học.
            </p>
            <button className="button" onClick={() => setStarted(true)}>
              Bắt đầu kiểm tra
              <ArrowRight size={18} />
            </button>
          </div>
        ) : (
          <div className="form-panel quiz">
            <div className="quiz-top">
              <span>
                Câu {index + 1} / {questions.length}
              </span>
              <span>{Object.keys(answers).length} câu đã trả lời</span>
            </div>
            <progress
              value={Object.keys(answers).length}
              max={questions.length}
              aria-label="Tiến độ làm bài"
            />
            <fieldset>
              <legend>{q.prompt}</legend>
              <div className="answers">
                {q.options.map((option, i) => (
                  <label
                    className={
                      answers[q.id] === i ? "answer selected" : "answer"
                    }
                    key={`${q.id}-${i}`}
                  >
                    <input
                      type="radio"
                      name={`question-${q.id}`}
                      checked={answers[q.id] === i}
                      onChange={() => {
                        setAnswers({ ...answers, [q.id]: i });
                        setError("");
                      }}
                    />
                    <span>{String.fromCharCode(65 + i)}</span>
                    {option}
                    {answers[q.id] === i && <Check size={19} />}
                  </label>
                ))}
              </div>
            </fieldset>
            <div className="question-nav" aria-label="Chọn câu hỏi">
              {questions.map((v, i) => (
                <button
                  key={v.id}
                  className={`${i === index ? "current" : ""} ${answers[v.id] !== undefined ? "answered" : ""}`}
                  aria-label={`Câu ${i + 1}${answers[v.id] !== undefined ? ", đã trả lời" : ""}`}
                  aria-current={i === index ? "step" : undefined}
                  onClick={() => setIndex(i)}
                >
                  {i + 1}
                </button>
              ))}
            </div>
            <ErrorMessage>{error}</ErrorMessage>
            <div className="quiz-actions">
              <button
                className="button outline"
                disabled={index === 0}
                onClick={() => setIndex(index - 1)}
              >
                <ArrowLeft size={18} />
                Câu trước
              </button>
              {index < questions.length - 1 ? (
                <button className="button" onClick={() => setIndex(index + 1)}>
                  Câu tiếp theo
                  <ArrowRight size={18} />
                </button>
              ) : (
                <button className="button" onClick={submit} disabled={busy}>
                  {busy ? "Đang chấm bài…" : "Nộp bài & xem kết quả"}
                  <Check size={18} />
                </button>
              )}
            </div>
          </div>
        )}
      </section>
    </>
  );
}
export function Login() {
  const { user, setUser, demo } = useApp();
  const navigate = useNavigate(),
    [params] = useSearchParams();
  const [register, setRegister] = useState(false),
    [error, setError] = useState(""),
    [busy, setBusy] = useState(false);
  if (user)
    return (
      <Navigate replace to={user.role === "admin" ? "/admin" : "/hoc-vien"} />
    );
  async function submit(e) {
    e.preventDefault();
    setBusy(true);
    setError("");
    const body = Object.fromEntries(new FormData(e.currentTarget));
    try {
      const { user } = await api(`/auth/${register ? "register" : "login"}`, {
        method: "POST",
        body,
      });
      setUser(user);
      const next = params.get("next");
      navigate(
        next?.startsWith("/") && !next.startsWith("//")
          ? next
          : user.role === "admin"
            ? "/admin"
            : "/hoc-vien",
        { replace: true },
      );
    } catch (e) {
      setError(e.message);
    } finally {
      setBusy(false);
    }
  }
  return (
    <section className="auth-section">
      <div className="container auth-grid">
        <div className="auth-copy">
          <span className="eyebrow">VINH ENGLISH · CỔNG HỌC VIÊN</span>
          <h1>
            Rất vui được
            <br />
            gặp lại <em>bạn.</em>
          </h1>
          <p>
            Lớp học, lịch học và những bước tiến của bạn.
            <br />
            Tất cả ở đây, sẵn sàng cho hành trình tiếp theo.
          </p>
          <img src="/images/hero.jpg" alt="Những người bạn cùng học tập" />
        </div>
        <div className="form-panel auth-form">
          <h2>{register ? "Tạo tài khoản học viên" : "Chào mừng trở lại!"}</h2>
          <p>
            {register
              ? "Bắt đầu quản lý hành trình học của bạn."
              : "Đăng nhập để tiếp tục hành trình học tập."}
          </p>
          <form onSubmit={submit} key={register ? "register" : "login"}>
            {register && (
              <>
                <Field
                  label="Họ và tên"
                  name="name"
                  autoComplete="name"
                  required
                  maxLength={100}
                />
                <Field
                  label="Số điện thoại"
                  name="phone"
                  type="tel"
                  pattern="(0|\+84)[0-9]{9,10}"
                  required
                />
                <Field
                  label="Ngày sinh"
                  name="birthday"
                  type="date"
                  max={new Date().toISOString().slice(0, 10)}
                />
              </>
            )}
            <Field
              label="Email"
              name="email"
              type="email"
              autoComplete="username"
              required
            />
            <Field
              label="Mật khẩu"
              name="password"
              type="password"
              autoComplete={register ? "new-password" : "current-password"}
              minLength={register ? 10 : 1}
              maxLength={128}
              required
            />
            {register && (
              <p className="muted small-text">
                Sử dụng ít nhất 10 ký tự cho mật khẩu.
              </p>
            )}
            <ErrorMessage>{error}</ErrorMessage>
            <button className="button full" disabled={busy}>
              {busy ? "Đang xử lý…" : register ? "Tạo tài khoản" : "Đăng nhập"}
              <ArrowRight size={18} />
            </button>
          </form>
          <p className="auth-switch">
            {register ? "Đã có tài khoản?" : "Chưa có tài khoản?"}{" "}
            <button
              className="text-button"
              onClick={() => {
                setRegister(!register);
                setError("");
              }}
            >
              {register ? "Đăng nhập" : "Đăng ký ngay"}
            </button>
          </p>
          {demo && (
            <details className="demo-accounts">
              <summary>Tài khoản dùng thử cho đồ án</summary>
              <p>
                Học viên: <code>hocvien@example.com</code>
                <br />
                Mật khẩu: <code>Student@123456</code>
              </p>
              <p>
                Admin: <code>admin@vinhenglish.vn</code>
                <br />
                Mật khẩu: <code>Admin@123456</code>
              </p>
            </details>
          )}
        </div>
      </div>
    </section>
  );
}
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
                        <td>{r.level}</td>
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
      </section>
    </>
  );
}
