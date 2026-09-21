import { useEffect, useState } from "react";
import { Link, NavLink, Route, Routes, useLocation } from "react-router-dom";
import {
  ArrowRight,
  Phone,
  MapPin,
  Mail,
  Menu,
  X,
  GraduationCap,
  ArrowUpRight,
} from "lucide-react";
import { AppContext, api, Loading, ErrorMessage } from "./lib";
import Home from "./pages/Home";
import {
  About,
  Courses,
  CourseDetail,
  Teachers,
  TeacherDetail,
  Schedule,
  News,
  NewsDetail,
  Contact,
} from "./pages/PublicPages";
import { Enrollment, Placement, Login, Student } from "./pages/AccountPages";
import Admin from "./pages/Admin";
const links = [
  ["/", "Trang chủ"],
  ["/gioi-thieu", "Về Vinh English"],
  ["/khoa-hoc", "Khóa học"],
  ["/giao-vien", "Giáo viên"],
  ["/lich-khai-giang", "Lịch khai giảng"],
  ["/tin-tuc", "Tin tức"],
];
function Logo() {
  return (
    <Link to="/" className="logo" aria-label="Vinh English Center — Trang chủ">
      <span className="logo-mark">
        v<span>•</span>
      </span>
      <span>
        vinh<span className="logo-english">english</span>
        <small>LEARN. CONNECT. GROW.</small>
      </span>
    </Link>
  );
}
function Layout({ user, logout, children }) {
  const [open, setOpen] = useState(false);
  const location = useLocation();
  useEffect(() => {
    setOpen(false);
    window.scrollTo(0, 0);
  }, [location.pathname]);
  return (
    <>
      <a className="skip-link" href="#main">
        Đến nội dung chính
      </a>
      <div className="topbar">
        <div className="container">
          <span>Một ngôn ngữ mới. Ngàn cơ hội mới.</span>
          <div>
            <a href="tel:02383888899">
              <Phone size={12} />
              0238 3 888 899
            </a>
            <Link to="/lien-he">
              <MapPin size={12} />
              Hệ thống cơ sở
            </Link>
          </div>
        </div>
      </div>
      <header className="header">
        <div className="container header-inner">
          <Logo />
          <nav
            className={open ? "nav open" : "nav"}
            aria-label="Điều hướng chính"
          >
            {links.map(([to, label]) => (
              <NavLink key={to} to={to} end={to === "/"}>
                {label}
              </NavLink>
            ))}
            <Link
              className="mobile-login"
              to={
                user
                  ? user.role === "admin"
                    ? "/admin"
                    : "/hoc-vien"
                  : "/dang-nhap"
              }
            >
              {user ? "Tài khoản" : "Đăng nhập"}
            </Link>
            {user && (
              <button
                className="mobile-logout"
                onClick={async () => {
                  await logout();
                  setOpen(false);
                }}
              >
                Đăng xuất
              </button>
            )}
          </nav>
          <div className="header-actions">
            {user ? (
              <>
                <Link
                  className="login-link"
                  to={user.role === "admin" ? "/admin" : "/hoc-vien"}
                >
                  {user.role === "admin" ? "Quản trị" : "Học viên"}
                </Link>
                <button className="logout-link" onClick={logout}>
                  Đăng xuất
                </button>
              </>
            ) : (
              <Link className="login-link" to="/dang-nhap">
                Đăng nhập
              </Link>
            )}
            <Link className="button small" to="/dang-ky">
              Đăng ký tư vấn
              <ArrowUpRight size={16} />
            </Link>
            <button
              className="menu-button"
              aria-label={open ? "Đóng menu" : "Mở menu"}
              aria-expanded={open}
              onClick={() => setOpen(!open)}
            >
              {open ? <X /> : <Menu />}
            </button>
          </div>
        </div>
      </header>
      <main id="main">{children}</main>
      <footer>
        <div className="container footer-grid">
          <div>
            <Logo />
            <p>
              Cùng bạn mở lời tự tin,
              <br />
              mở lối đến một tương lai rộng lớn.
            </p>
            <span className="footer-note">
              Website đồ án · Trung tâm minh họa
            </span>
          </div>
          <div>
            <h3>Khám phá</h3>
            <Link to="/gioi-thieu">Về Vinh English</Link>
            <Link to="/khoa-hoc">Chương trình học</Link>
            <Link to="/giao-vien">Đội ngũ giáo viên</Link>
            <Link to="/tin-tuc">Góc học tập</Link>
          </div>
          <div>
            <h3>Đồng hành cùng bạn</h3>
            <Link to="/kiem-tra">Kiểm tra trình độ</Link>
            <Link to="/lich-khai-giang">Lịch khai giảng</Link>
            <Link to="/hoc-vien">Cổng học viên</Link>
            <Link to="/lien-he">Liên hệ & tư vấn</Link>
          </div>
          <div>
            <h3>Ghé thăm Vinh English</h3>
            <p>
              <MapPin size={16} /> 28 Lê Lợi, TP. Vinh, Nghệ An
            </p>
            <a href="tel:02383888899">
              <Phone size={16} />
              0238 3 888 899
            </a>
            <a href="mailto:hello@vinhenglish.example">
              <Mail size={16} />
              hello@vinhenglish.example
            </a>
            <p>Thứ 2 – Chủ nhật: 08:00 – 21:00</p>
          </div>
        </div>
        <div className="container footer-bottom">
          <span>© 2026 Vinh English Center. Made for learning.</span>
          <span>
            <GraduationCap size={16} />
            Học hôm nay. Vững ngày mai.
          </span>
        </div>
      </footer>
    </>
  );
}
export default function App() {
  const [catalog, setCatalog] = useState(null),
    [user, setUser] = useState(null),
    [demo, setDemo] = useState(false),
    [error, setError] = useState(""),
    [ready, setReady] = useState(false);
  async function refreshCatalog() {
    const value = await api("/catalog");
    setCatalog(value);
  }
  async function load() {
    setError("");
    try {
      const [c, auth] = await Promise.all([api("/catalog"), api("/auth/me")]);
      setCatalog(c);
      setUser(auth.user);
      setDemo(auth.demo);
      setReady(true);
    } catch (e) {
      setError(e.message);
    }
  }
  useEffect(() => {
    load();
  }, []);
  async function logout() {
    try {
      await api("/auth/logout", { method: "POST", body: {} });
      setUser(null);
    } catch (e) {
      setError(e.message);
    }
  }
  const context = { catalog, user, setUser, demo, refreshCatalog };
  return (
    <AppContext.Provider value={context}>
      <Layout user={user} logout={logout}>
        {error ? (
          <div className="container section">
            <ErrorMessage>{error}</ErrorMessage>
            <button className="button" onClick={load}>
              Thử lại
            </button>
          </div>
        ) : !ready ? (
          <Loading />
        ) : (
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/gioi-thieu" element={<About />} />
            <Route path="/khoa-hoc" element={<Courses />} />
            <Route path="/khoa-hoc/:id" element={<CourseDetail />} />
            <Route path="/giao-vien" element={<Teachers />} />
            <Route path="/giao-vien/:id" element={<TeacherDetail />} />
            <Route path="/lich-khai-giang" element={<Schedule />} />
            <Route path="/tin-tuc" element={<News />} />
            <Route path="/tin-tuc/:id" element={<NewsDetail />} />
            <Route path="/lien-he" element={<Contact />} />
            <Route path="/dang-ky" element={<Enrollment />} />
            <Route path="/kiem-tra" element={<Placement />} />
            <Route path="/dang-nhap" element={<Login />} />
            <Route path="/hoc-vien" element={<Student />} />
            <Route path="/admin" element={<Admin />} />
            <Route
              path="*"
              element={
                <div className="container section empty">
                  <h1>Không tìm thấy trang</h1>
                  <Link className="button" to="/">
                    Về trang chủ <ArrowRight size={18} />
                  </Link>
                </div>
              }
            />
          </Routes>
        )}
      </Layout>
    </AppContext.Provider>
  );
}
