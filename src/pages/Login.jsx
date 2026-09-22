import { useState } from "react";
import { Navigate, useNavigate, useSearchParams } from "react-router-dom";
import { ArrowRight } from "lucide-react";
import { useApp, api, Field, ErrorMessage } from "../lib";
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
          {params.get("changed") === "1" && (
            <p className="notice" role="status">
              Đã đổi mật khẩu. Hãy đăng nhập lại bằng mật khẩu mới.
            </p>
          )}
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
