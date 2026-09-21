import { createContext, useContext, useEffect, useState } from "react";
import { Link } from "react-router-dom";
import {
  ArrowUpRight,
  Clock3,
  BookOpen,
  ArrowRight,
  CheckCircle2,
} from "lucide-react";
export const AppContext = createContext(null);
export const useApp = () => useContext(AppContext);
export async function api(path, options = {}) {
  let response;
  try {
    response = await fetch(`/api${path}`, {
      ...options,
      headers: { "Content-Type": "application/json", ...options.headers },
      ...(options.body ? { body: JSON.stringify(options.body) } : {}),
    });
  } catch {
    throw new Error(
      "Không kết nối được máy chủ. Vui lòng kiểm tra kết nối và thử lại.",
    );
  }
  const data = await response.json().catch(() => null);
  if (!response.ok || !data)
    throw new Error(
      data?.error?.message || "Không thể tải dữ liệu. Vui lòng thử lại.",
    );
  return data;
}
export const money = (value) =>
  new Intl.NumberFormat("vi-VN", { style: "currency", currency: "VND" }).format(
    value,
  );
export const date = (value) =>
  new Date(`${value}T00:00:00`).toLocaleDateString("vi-VN");
export const statusText = {
  pending: "Chờ xác nhận",
  confirmed: "Đã xác nhận",
  cancelled: "Đã hủy",
};
export function useLoad(path) {
  const [data, setData] = useState(null),
    [error, setError] = useState("");
  const [version, setVersion] = useState(0);
  useEffect(() => {
    let active = true;
    setError("");
    api(path)
      .then((v) => {
        if (active) setData(v);
      })
      .catch((e) => {
        if (active) setError(e.message);
      });
    return () => {
      active = false;
    };
  }, [path, version]);
  return { data, error, reload: () => setVersion((v) => v + 1) };
}
export function ErrorMessage({ children }) {
  return children ? (
    <div className="error" role="alert">
      {children}
    </div>
  ) : null;
}
export function Loading() {
  return (
    <div className="container loading" role="status">
      <span className="spinner" />
      Đang tải dữ liệu…
    </div>
  );
}
export function Empty({ children = "Chưa có dữ liệu để hiển thị." }) {
  return (
    <div className="empty">
      <BookOpen size={32} />
      <p>{children}</p>
    </div>
  );
}
export function PageHeading({ eyebrow, title, children }) {
  return (
    <div className="page-heading">
      <div className="container">
        <div className="breadcrumb">
          <Link to="/">Trang chủ</Link>
          <span>/</span>
          <span>{eyebrow || title}</span>
        </div>
        <span className="eyebrow">{eyebrow}</span>
        <h1>{title}</h1>
        {children && <p>{children}</p>}
      </div>
    </div>
  );
}
export function SectionHeading({ eyebrow, title, text, link, to }) {
  return (
    <div className="section-heading">
      <div>
        <span className="eyebrow">{eyebrow}</span>
        <h2>{title}</h2>
        {text && <p>{text}</p>}
      </div>
      {link && (
        <Link className="text-link" to={to}>
          {link}
          <ArrowUpRight size={18} />
        </Link>
      )}
    </div>
  );
}
export function CourseCard({ course }) {
  return (
    <article className="course-card">
      <Link to={`/khoa-hoc/${course.id}`} className="course-image">
        <img src={course.image} alt={course.name} loading="lazy" />
        <span className="image-tag">{course.category}</span>
        <span className="image-arrow">
          <ArrowUpRight size={22} />
        </span>
      </Link>
      <div className="course-body">
        <div className="course-meta">
          {course.audience}
          <span>•</span>
          {course.level}
        </div>
        <h3>
          <Link to={`/khoa-hoc/${course.id}`}>{course.name}</Link>
        </h3>
        <p>{course.description}</p>
        <div className="course-facts">
          <span>
            <Clock3 size={15} />
            {course.duration} tuần
          </span>
          <span>
            <BookOpen size={15} />
            {course.lessons} buổi học
          </span>
        </div>
        <div className="course-bottom">
          <strong>
            {money(course.tuition)}
            <small> / khóa</small>
          </strong>
          <Link to={`/khoa-hoc/${course.id}`} aria-label={`Xem ${course.name}`}>
            <ArrowRight size={21} />
          </Link>
        </div>
      </div>
    </article>
  );
}
export function Success({ title, children, to = "/", link = "Về trang chủ" }) {
  return (
    <div className="success-panel">
      <CheckCircle2 size={52} />
      <h2>{title}</h2>
      <p>{children}</p>
      <Link className="button" to={to}>
        {link}
        <ArrowRight size={18} />
      </Link>
    </div>
  );
}
export function Field({ label, children, ...props }) {
  return (
    <label className="field">
      <span>{label}</span>
      {children || <input {...props} />}
    </label>
  );
}
