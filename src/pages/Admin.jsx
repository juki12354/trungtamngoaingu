import { useEffect, useRef, useState } from "react";
import { Navigate } from "react-router-dom";
import {
  LayoutDashboard,
  BookOpen,
  Users,
  GraduationCap,
  CalendarDays,
  ClipboardList,
  FileQuestion,
  Newspaper,
  Plus,
  Search,
  Pencil,
  Trash2,
  X,
  Check,
  ArrowRight,
  Mail,
} from "lucide-react";
import {
  useApp,
  useLoad,
  api,
  Loading,
  ErrorMessage,
  Empty,
  Field,
  money,
  date,
  statusText,
} from "../lib";
const resources = [
  ["overview", "Tổng quan", LayoutDashboard],
  ["courses", "Khóa học", BookOpen],
  ["students", "Học viên", Users],
  ["teachers", "Giáo viên", GraduationCap],
  ["classes", "Lớp & lịch học", CalendarDays],
  ["enrollments", "Đăng ký & điểm", ClipboardList],
  ["questions", "Bài kiểm tra", FileQuestion],
  ["news", "Tin tức", Newspaper],
];
const fields = {
  courses: [
    ["name", "Tên khóa học"],
    ["category", "Nhóm chương trình"],
    ["level", "Trình độ"],
    ["audience", "Đối tượng"],
    ["duration", "Thời lượng (tuần)", "number"],
    ["lessons", "Số buổi", "number"],
    ["tuition", "Học phí (VNĐ)", "number"],
    ["image", "Ảnh (đường dẫn /images/ hoặc HTTPS)"],
    ["description", "Giới thiệu", "textarea"],
    ["material", "Tài liệu học tập", "textarea"],
  ],
  teachers: [
    ["name", "Họ và tên"],
    ["degree", "Bằng cấp / Chứng chỉ"],
    ["experience", "Kinh nghiệm (năm)", "number"],
    ["specialty", "Chuyên môn"],
    ["image", "Ảnh"],
    ["description", "Giới thiệu", "textarea"],
  ],
  students: [
    ["name", "Họ và tên"],
    ["email", "Email", "email"],
    ["phone", "Số điện thoại", "tel"],
    ["birthday", "Ngày sinh", "date"],
    ["password", "Mật khẩu (ít nhất 10 ký tự)", "password"],
  ],
  classes: [
    ["name", "Mã lớp"],
    ["courseId", "Khóa học", "courses"],
    ["teacherId", "Giáo viên", "teachers"],
    ["startDate", "Ngày khai giảng", "date"],
    ["endDate", "Ngày kết thúc", "date"],
    ["schedule", "Lịch học (thứ, giờ)"],
    ["campus", "Cơ sở"],
    ["capacity", "Sĩ số tối đa", "number"],
  ],
  news: [
    ["title", "Tiêu đề"],
    ["category", "Chuyên mục"],
    ["date", "Ngày đăng", "date"],
    ["image", "Ảnh"],
    ["excerpt", "Mô tả ngắn", "textarea"],
    ["content", "Nội dung bài viết", "textarea"],
  ],
  questions: [
    ["prompt", "Câu hỏi"],
    ["option0", "Đáp án A"],
    ["option1", "Đáp án B"],
    ["option2", "Đáp án C"],
    ["option3", "Đáp án D"],
    ["answer", "Đáp án đúng", "answer"],
  ],
  enrollments: [
    ["status", "Trạng thái", "status"],
    ["userId", "Liên kết tài khoản học viên", "students"],
    ["listening", "Listening (0–10)", "grade"],
    ["reading", "Reading (0–10)", "grade"],
    ["writing", "Writing (0–10)", "grade"],
    ["speaking", "Speaking (0–10)", "grade"],
  ],
};
const defaults = {
  courses: {
    category: "Giao tiếp",
    level: "A2",
    audience: "Từ 16 tuổi",
    duration: 12,
    lessons: 24,
    tuition: 3000000,
    image: "/images/adults.jpg",
  },
  teachers: { experience: 1, image: "/images/teacher1.jpg" },
  classes: {
    capacity: 18,
    campus: "Cơ sở Lê Lợi",
    schedule: "Thứ 2, Thứ 4 · 18:30 – 20:30",
  },
  news: {
    date: new Date().toISOString().slice(0, 10),
    category: "Góc học tập",
    image: "/images/ielts.jpg",
  },
  questions: { answer: 0 },
};
export default function Admin() {
  const { user } = useApp();
  if (!user) return <Navigate to="/dang-nhap?next=/admin" replace />;
  if (user.role !== "admin")
    return (
      <div className="section container">
        <h1>Bạn không có quyền quản trị.</h1>
        <p>Vui lòng đăng nhập bằng tài khoản Admin.</p>
      </div>
    );
  return <AdminContent />;
}
function AdminContent() {
  const [resource, setResource] = useState("overview"),
    [version, setVersion] = useState(0),
    [notice, setNotice] = useState("");
  const title = resources.find((r) => r[0] === resource)[1];
  return (
    <div className="admin-layout">
      <aside className="admin-sidebar">
        <span className="eyebrow">VINH ENGLISH</span>
        <h2>Không gian quản trị</h2>
        <nav aria-label="Quản trị">
          {resources.map(([key, label, Icon]) => (
            <button
              key={key}
              className={resource === key ? "active" : ""}
              onClick={() => {
                setResource(key);
                setNotice("");
              }}
            >
              <Icon size={19} />
              {label}
            </button>
          ))}
        </nav>
        <div className="admin-sidebar-note">
          <GraduationCap size={28} />
          <p>
            Mỗi dữ liệu được chăm chút.
            <br />
            Mỗi hành trình được quan tâm.
          </p>
        </div>
      </aside>
      <div className="admin-main">
        <div className="admin-heading">
          <div>
            <span className="eyebrow">QUẢN LÝ TRUNG TÂM</span>
            <h1>{title}</h1>
          </div>
          <span className="badge">Quản trị viên</span>
        </div>
        {notice && (
          <div className="notice" role="status">
            <Check size={17} />
            {notice}
          </div>
        )}
        {resource === "overview" ? (
          <Overview onNavigate={setResource} key={version} />
        ) : (
          <ResourceTable
            key={resource}
            resource={resource}
            title={title}
            onSaved={(message) => {
              setNotice(message);
              setVersion((v) => v + 1);
            }}
          />
        )}
      </div>
    </div>
  );
}
function Overview({ onNavigate }) {
  const { data, error, reload } = useLoad("/admin/overview");
  if (error)
    return (
      <>
        <ErrorMessage>{error}</ErrorMessage>
        <button onClick={reload}>Thử lại</button>
      </>
    );
  if (!data) return <Loading />;
  return (
    <>
      <div className="admin-stats">
        {[
          ["students", "Học viên", Users],
          ["courses", "Khóa học", BookOpen],
          ["classes", "Lớp học", CalendarDays],
          ["pending", "Đăng ký mới", ClipboardList],
        ].map(([key, title, Icon]) => (
          <button
            className="stat-card"
            key={key}
            onClick={() => onNavigate(key === "pending" ? "enrollments" : key)}
          >
            <span>
              <Icon size={21} />
              {title}
            </span>
            <strong>{data[key]}</strong>
            <small>
              Xem chi tiết <ArrowRight size={14} />
            </small>
          </button>
        ))}
      </div>
      <div className="admin-panel">
        <div className="panel-heading">
          <h2>Đăng ký gần đây</h2>
          <button
            className="text-button"
            onClick={() => onNavigate("enrollments")}
          >
            Xem tất cả →
          </button>
        </div>
        {data.enrollments.length ? (
          <div className="table-wrap">
            <table>
              <thead>
                <tr>
                  <th>Học viên</th>
                  <th>Liên hệ</th>
                  <th>Ngày đăng ký</th>
                  <th>Trạng thái</th>
                </tr>
              </thead>
              <tbody>
                {data.enrollments.map((e) => (
                  <tr key={e.id}>
                    <td>
                      <strong>{e.name}</strong>
                      <small>Đăng ký #{e.id}</small>
                    </td>
                    <td>
                      {e.email}
                      <small>{e.phone}</small>
                    </td>
                    <td>{e.createdAt}</td>
                    <td>
                      <span className={`badge ${e.status}`}>
                        {statusText[e.status]}
                      </span>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        ) : (
          <Empty>Chưa có đăng ký nào.</Empty>
        )}
      </div>
      <div className="admin-panel">
        <h2>
          <Mail size={21} />
          Lời nhắn tư vấn ({data.contacts.length})
        </h2>
        {data.contacts.length ? (
          data.contacts.map((c) => (
            <article className="contact-message" key={c.id}>
              <strong>{c.name}</strong>
              <span>
                {c.email} · {c.phone}
              </span>
              <p>{c.message}</p>
              <small>{c.createdAt}</small>
            </article>
          ))
        ) : (
          <Empty>Chưa có lời nhắn mới từ trang liên hệ.</Empty>
        )}
      </div>
    </>
  );
}
function ResourceTable({ resource, title, onSaved }) {
  const { data, error, reload } = useLoad(`/admin/${resource}`);
  const { catalog, refreshCatalog } = useApp();
  const [query, setQuery] = useState(""),
    [page, setPage] = useState(1),
    [editing, setEditing] = useState(null),
    [actionError, setActionError] = useState(""),
    [deleting, setDeleting] = useState(null);
  const filtered = (data || []).filter((row) =>
    Object.values(row).some(
      (v) =>
        typeof v !== "object" &&
        String(v)
          .toLocaleLowerCase("vi")
          .includes(query.toLocaleLowerCase("vi")),
    ),
  );
  const totalPages = Math.max(1, Math.ceil(filtered.length / 8));
  const current = Math.min(page, totalPages);
  async function removed(row) {
    if (
      !window.confirm(
        `Xóa ${row.name || row.title || `bản ghi #${row.id}`}? Thao tác này sẽ xóa dữ liệu khỏi cơ sở dữ liệu.`,
      )
    )
      return;
    setDeleting(row.id);
    setActionError("");
    try {
      await api(`/admin/${resource}/${row.id}`, { method: "DELETE" });
      onSaved("Đã xóa bản ghi.");
      reload();
      await refreshCatalog();
    } catch (e) {
      setActionError(e.message);
    } finally {
      setDeleting(null);
    }
  }
  function description(row) {
    if (resource === "courses")
      return (
        <>
          {row.category} · {row.level}
          <small>
            {money(row.tuition)} · {row.lessons} buổi
          </small>
        </>
      );
    if (resource === "teachers")
      return (
        <>
          {row.degree}
          <small>
            {row.experience} năm · {row.specialty}
          </small>
        </>
      );
    if (resource === "students")
      return (
        <>
          {row.email}
          <small>{row.phone}</small>
        </>
      );
    if (resource === "classes")
      return (
        <>
          {catalog.courses.find((c) => c.id === row.courseId)?.name}
          <small>
            {row.schedule} · {row.campus}
          </small>
        </>
      );
    if (resource === "enrollments")
      return (
        <>
          {row.email}
          <small>
            {row.phone} ·{" "}
            {catalog.classes.find((c) => c.id === row.classId)?.name}
          </small>
        </>
      );
    if (resource === "questions")
      return (
        <>
          {row.options
            .map((v, i) => `${String.fromCharCode(65 + i)}. ${v}`)
            .join(" / ")}
          <small>Đáp án đúng: {String.fromCharCode(65 + row.answer)}</small>
        </>
      );
    return (
      <>
        {row.category}
        <small>{date(row.date)}</small>
      </>
    );
  }
  return (
    <div className="admin-panel">
      <div className="admin-toolbar">
        <label className="search-box">
          <Search size={18} />
          <input
            value={query}
            onChange={(e) => {
              setQuery(e.target.value);
              setPage(1);
            }}
            aria-label={`Tìm ${title.toLowerCase()}`}
            placeholder={`Tìm ${title.toLowerCase()}…`}
          />
        </label>
        {resource !== "enrollments" && (
          <button
            className="button small"
            onClick={() => setEditing({ ...defaults[resource] })}
          >
            <Plus size={18} />
            Thêm mới
          </button>
        )}
      </div>
      <ErrorMessage>{error || actionError}</ErrorMessage>
      {!data ? (
        <Loading />
      ) : !filtered.length ? (
        <Empty>Không có bản ghi phù hợp.</Empty>
      ) : (
        <>
          <div className="table-wrap">
            <table className="admin-table">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>
                    {resource === "questions"
                      ? "Câu hỏi"
                      : resource === "news"
                        ? "Tiêu đề"
                        : "Tên"}
                  </th>
                  <th>Thông tin</th>
                  {["classes", "enrollments"].includes(resource) && (
                    <th>{resource === "classes" ? "Sĩ số" : "Trạng thái"}</th>
                  )}
                  <th>Thao tác</th>
                </tr>
              </thead>
              <tbody>
                {filtered.slice((current - 1) * 8, current * 8).map((row) => (
                  <tr key={row.id}>
                    <td>#{row.id}</td>
                    <td>
                      <strong>{row.name || row.title || row.prompt}</strong>
                      {resource === "enrollments" && row.note && (
                        <small>{row.note}</small>
                      )}
                    </td>
                    <td>{description(row)}</td>
                    {resource === "classes" && (
                      <td>
                        {row.enrolled}/{row.capacity}
                        <small>{date(row.startDate)}</small>
                      </td>
                    )}
                    {resource === "enrollments" && (
                      <td>
                        <span className={`badge ${row.status}`}>
                          {statusText[row.status]}
                        </span>
                      </td>
                    )}
                    <td>
                      <div className="row-actions">
                        <button
                          aria-label={`Sửa bản ghi ${row.id}`}
                          title="Sửa"
                          onClick={() => setEditing(row)}
                        >
                          <Pencil size={17} />
                        </button>
                        <button
                          className="danger"
                          aria-label={`Xóa bản ghi ${row.id}`}
                          title="Xóa"
                          disabled={deleting === row.id}
                          onClick={() => removed(row)}
                        >
                          <Trash2 size={17} />
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
          <div className="pagination">
            <span>
              {filtered.length} bản ghi · Trang {current}/{totalPages}
            </span>
            <div>
              <button
                disabled={current <= 1}
                onClick={() => setPage(current - 1)}
              >
                Trước
              </button>
              <button
                disabled={current >= totalPages}
                onClick={() => setPage(current + 1)}
              >
                Sau
              </button>
            </div>
          </div>
        </>
      )}
      {editing && (
        <EditDialog
          resource={resource}
          item={editing}
          onClose={() => setEditing(null)}
          onSaved={async () => {
            setEditing(null);
            reload();
            onSaved("Đã lưu thay đổi.");
            await refreshCatalog();
          }}
        />
      )}
    </div>
  );
}
function EditDialog({ resource, item, onClose, onSaved }) {
  const dialog = useRef(null);
  const { catalog } = useApp();
  const [students, setStudents] = useState([]);
  const [studentId, setStudentId] = useState(
    item.userId == null ? "" : String(item.userId),
  );
  const [error, setError] = useState(""),
    [busy, setBusy] = useState(false);
  useEffect(() => {
    dialog.current.showModal();
    if (resource === "enrollments")
      api("/admin/students")
        .then(setStudents)
        .catch((e) => setError(e.message));
  }, [resource]);
  async function submit(e) {
    e.preventDefault();
    setBusy(true);
    setError("");
    const data = Object.fromEntries(new FormData(e.currentTarget));
    for (const [key, , type] of fields[resource]) {
      if (["number", "courses", "teachers", "answer"].includes(type))
        data[key] = Number(data[key]);
    }
    if (resource === "students" && item.id && !data.password)
      delete data.password;
    if (resource === "questions") {
      data.options = [data.option0, data.option1, data.option2, data.option3];
      ["option0", "option1", "option2", "option3"].forEach(
        (k) => delete data[k],
      );
    }
    if (resource === "enrollments") {
      data.userId = studentId ? Number(studentId) : null;
      data.grades = {};
      for (const key of ["listening", "reading", "writing", "speaking"]) {
        if (data[key] !== "") data.grades[key] = Number(data[key]);
        delete data[key];
      }
    }
    try {
      await api(`/admin/${resource}${item.id ? `/${item.id}` : ""}`, {
        method: item.id ? "PATCH" : "POST",
        body: data,
      });
      await onSaved();
    } catch (e) {
      setError(e.message);
    } finally {
      setBusy(false);
    }
  }
  return (
    <dialog
      ref={dialog}
      className="edit-dialog"
      onCancel={(e) => {
        if (busy) e.preventDefault();
        else onClose();
      }}
      aria-labelledby="edit-title"
    >
      <div className="dialog-header">
        <h2 id="edit-title">
          {item.id ? "Cập nhật thông tin" : "Thêm bản ghi mới"}
        </h2>
        <button
          className="icon-button"
          aria-label="Đóng"
          disabled={busy}
          onClick={onClose}
        >
          <X />
        </button>
      </div>
      <form onSubmit={submit}>
        {resource === "enrollments" && (
          <p className="form-hint">
            {item.name} · {item.email}
            <br />
            Gắn đúng tài khoản để học viên xem lịch, điểm và tài liệu. Điểm kỹ
            năng theo thang 10.
          </p>
        )}
        <div className="form-grid">
          {fields[resource].map(([key, label, type = "text"]) => {
            const value = key.startsWith("option")
              ? item.options?.[Number(key.slice(-1))]
              : type === "grade"
                ? item.grades?.[key]
                : item[key];
            const required =
              !["material", "birthday"].includes(key) &&
              type !== "grade" &&
              type !== "students" &&
              !(key === "password" && item.id);
            let options =
              type === "courses"
                ? catalog.courses
                : type === "teachers"
                  ? catalog.teachers
                  : type === "students"
                    ? students
                    : type === "status"
                      ? Object.entries(statusText).map(([id, name]) => ({
                          id,
                          name,
                        }))
                      : type === "answer"
                        ? ["A", "B", "C", "D"].map((name, id) => ({ id, name }))
                        : null;
            return (
              <div className={type === "textarea" ? "span-two" : ""} key={key}>
                <Field label={label + (required ? " *" : "")}>
                  {options ? (
                    <select
                      name={key}
                      defaultValue={
                        type === "students" ? undefined : (value ?? "")
                      }
                      value={type === "students" ? studentId : undefined}
                      onChange={
                        type === "students"
                          ? (e) => setStudentId(e.target.value)
                          : undefined
                      }
                      required={required}
                    >
                      {!["status", "answer"].includes(type) && (
                        <option value="">
                          {type === "students"
                            ? "Chưa liên kết tài khoản"
                            : "Chọn…"}
                        </option>
                      )}
                      {options.map((v) => (
                        <option key={v.id} value={v.id}>
                          {v.name}
                          {type === "students" ? ` (${v.email})` : ""}
                        </option>
                      ))}
                    </select>
                  ) : type === "textarea" ? (
                    <textarea
                      name={key}
                      defaultValue={value || ""}
                      required={required}
                      rows={key === "content" || key === "material" ? 6 : 3}
                      maxLength={20000}
                    />
                  ) : (
                    <input
                      name={key}
                      type={type === "grade" ? "number" : type}
                      defaultValue={value ?? ""}
                      required={required}
                      min={
                        type === "number" || type === "grade" ? 0 : undefined
                      }
                      max={type === "grade" ? 10 : undefined}
                      step={
                        type === "grade"
                          ? "0.1"
                          : type === "number"
                            ? "1"
                            : undefined
                      }
                      minLength={key === "password" ? 10 : undefined}
                      maxLength={key === "password" ? 128 : 1000}
                      autoComplete={
                        key === "password" ? "new-password" : undefined
                      }
                    />
                  )}
                </Field>
              </div>
            );
          })}
        </div>
        <ErrorMessage>{error}</ErrorMessage>
        <div className="dialog-actions">
          <button
            type="button"
            className="button outline"
            disabled={busy}
            onClick={onClose}
          >
            Hủy
          </button>
          <button className="button" disabled={busy}>
            <Check size={18} />
            {busy ? "Đang lưu…" : "Lưu thông tin"}
          </button>
        </div>
      </form>
    </dialog>
  );
}
