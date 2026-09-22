import { useEffect, useRef, useState } from "react";
import {
  api,
  useApp,
  useLoad,
  Field,
  ErrorMessage,
  Loading,
  Empty,
} from "../lib";
import { downloadFile } from "../download";
export const classStatuses = {
  enrolling: "Đang tuyển sinh",
  ongoing: "Đang học",
  completed: "Đã kết thúc",
  cancelled: "Đã hủy",
};
export const contactStatuses = {
  new: "Mới",
  contacted: "Đã liên hệ",
  done: "Hoàn tất",
};
export function PasswordForm() {
  const [error, setError] = useState(""),
    [busy, setBusy] = useState(false);
  async function submit(event) {
    event.preventDefault();
    setError("");
    const body = Object.fromEntries(new FormData(event.currentTarget));
    if (body.newPassword !== body.confirm)
      return setError("Mật khẩu nhập lại chưa khớp.");
    setBusy(true);
    try {
      await api("/auth/password", { method: "POST", body });
      window.location.replace("/dang-nhap?changed=1");
    } catch (e) {
      setError(e.message);
    } finally {
      setBusy(false);
    }
  }
  return (
    <form className="form-panel profile-form" onSubmit={submit}>
      <h2>Đổi mật khẩu</h2>
      <p>
        Đổi thành công sẽ đăng xuất mọi thiết bị. Bạn đăng nhập lại bằng mật
        khẩu mới.
      </p>
      <Field
        label="Mật khẩu hiện tại"
        name="currentPassword"
        type="password"
        required
        maxLength={128}
        autoComplete="current-password"
      />
      <Field
        label="Mật khẩu mới"
        name="newPassword"
        type="password"
        required
        minLength={10}
        maxLength={128}
        autoComplete="new-password"
      />
      <Field
        label="Nhập lại mật khẩu mới"
        name="confirm"
        type="password"
        required
        minLength={10}
        maxLength={128}
        autoComplete="new-password"
      />
      <ErrorMessage>{error}</ErrorMessage>
      <button className="button" disabled={busy}>
        {busy ? "Đang đổi…" : "Đổi mật khẩu"}
      </button>
    </form>
  );
}
export function IntakeDialog({ item, onClose, onSaved }) {
  const ref = useRef(null),
    { data: students, error: loadError } = useLoad("/admin/students");
  const [mode, setMode] = useState("create"),
    [error, setError] = useState(""),
    [busy, setBusy] = useState(false);
  useEffect(() => {
    ref.current.showModal();
  }, []);
  async function submit(event) {
    event.preventDefault();
    setBusy(true);
    setError("");
    const values = Object.fromEntries(new FormData(event.currentTarget));
    try {
      await api(`/admin/enrollments/${item.id}/intake`, {
        method: "POST",
        body: {
          mode,
          verified: values.verified === "on",
          ...(mode === "create"
            ? { password: values.password }
            : { userId: Number(values.userId) }),
        },
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
      className="edit-dialog"
      ref={ref}
      aria-labelledby="intake-title"
      onCancel={(e) => (busy ? e.preventDefault() : onClose())}
    >
      <h2 id="intake-title">Tiếp nhận học viên</h2>
      <p>
        {item.name} · {item.email} · {item.phone}
      </p>
      <form onSubmit={submit}>
        <Field label="Cách liên kết">
          <select value={mode} onChange={(e) => setMode(e.target.value)}>
            <option value="create">Tạo tài khoản mới từ đăng ký</option>
            <option value="existing">Liên kết tài khoản đã có</option>
          </select>
        </Field>
        {mode === "create" ? (
          <Field
            label="Mật khẩu ban đầu"
            name="password"
            type="password"
            required
            minLength={10}
            maxLength={128}
            autoComplete="new-password"
          />
        ) : (
          <Field label="Tài khoản học viên">
            <select name="userId" required defaultValue="">
              <option value="">Chọn học viên</option>
              {students?.map((s) => (
                <option key={s.id} value={s.id}>
                  {s.name} ({s.email})
                </option>
              ))}
            </select>
          </Field>
        )}
        <label className="check-field">
          <input name="verified" type="checkbox" required />
          Tôi đã liên hệ và xác minh người đăng ký là chủ tài khoản được chọn.
        </label>
        <p className="muted">
          Giao mật khẩu ban đầu qua kênh đã xác minh và hướng dẫn học viên đổi
          mật khẩu. Sau tiếp nhận, duyệt trạng thái để xác nhận vào lớp.
        </p>
        <ErrorMessage>{error || loadError}</ErrorMessage>
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
            Xác nhận tiếp nhận
          </button>
        </div>
      </form>
    </dialog>
  );
}
export function MaterialsPanel() {
  const { catalog } = useApp(),
    { data, error: loadError, reload } = useLoad("/admin/materials");
  const [error, setError] = useState(""),
    [notice, setNotice] = useState(""),
    [busy, setBusy] = useState(false),
    [filter, setFilter] = useState("");
  async function upload(event) {
    event.preventDefault();
    const form = event.currentTarget,
      values = new FormData(form),
      file = values.get("file");
    setError("");
    setNotice("");
    if (file.size > 5 * 1024 * 1024) return setError("Tệp tối đa 5 MB.");
    setBusy(true);
    try {
      const content = await new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.onload = () => resolve(reader.result.split(",")[1]);
        reader.onerror = () => reject(new Error("Không đọc được tệp."));
        reader.readAsDataURL(file);
      });
      await api("/admin/materials", {
        method: "POST",
        body: {
          classId: Number(values.get("classId")),
          title: values.get("title"),
          lesson: values.get("lesson"),
          filename: file.name,
          content,
        },
      });
      form.reset();
      reload();
      setNotice("Đã tải lên tài liệu.");
    } catch (e) {
      setError(e.message);
    } finally {
      setBusy(false);
    }
  }
  async function remove(file) {
    if (!window.confirm(`Xóa tài liệu ${file.title}?`)) return;
    setBusy(true);
    setError("");
    try {
      await api(`/admin/materials/${file.id}`, { method: "DELETE" });
      reload();
      setNotice("Đã xóa tài liệu.");
    } catch (e) {
      setError(e.message);
    } finally {
      setBusy(false);
    }
  }
  return (
    <div className="admin-panel">
      <form onSubmit={upload}>
        <h2>Thêm tài liệu cho lớp</h2>
        <div className="form-grid">
          <Field label="Lớp học">
            <select name="classId" required defaultValue="">
              <option value="">Chọn lớp</option>
              {catalog.classes.map((c) => (
                <option key={c.id} value={c.id}>
                  {c.name}
                </option>
              ))}
            </select>
          </Field>
          <Field label="Tên tài liệu" name="title" required maxLength={200} />
          <Field label="Buổi học / chủ đề" name="lesson" maxLength={100} />
          <Field
            label="Tệp PDF hoặc DOCX (tối đa 5 MB)"
            type="file"
            name="file"
            required
            accept=".pdf,.docx"
          />
        </div>
        <button className="button" disabled={busy}>
          Tải lên tài liệu
        </button>
      </form>
      {notice && (
        <p className="notice" role="status">
          {notice}
        </p>
      )}
      <ErrorMessage>{error || loadError}</ErrorMessage>
      <hr />
      <Field label="Lọc tài liệu theo lớp">
        <select value={filter} onChange={(e) => setFilter(e.target.value)}>
          <option value="">Tất cả lớp</option>
          {catalog.classes.map((c) => (
            <option key={c.id} value={c.id}>
              {c.name}
            </option>
          ))}
        </select>
      </Field>
      {!data ? (
        <Loading />
      ) : !data.length ? (
        <Empty />
      ) : (
        <div className="table-wrap">
          <table>
            <thead>
              <tr>
                <th>Tài liệu</th>
                <th>Lớp</th>
                <th>Tệp</th>
                <th>Thao tác</th>
              </tr>
            </thead>
            <tbody>
              {data
                .filter((f) => !filter || String(f.classId) === filter)
                .map((f) => (
                  <tr key={f.id}>
                    <td>
                      {f.title}
                      <small>{f.lesson}</small>
                    </td>
                    <td>
                      {catalog.classes.find((c) => c.id === f.classId)?.name}
                    </td>
                    <td>
                      {f.filename}
                      <small>{Math.ceil(f.size / 1024)} KB</small>
                    </td>
                    <td>
                      <button
                        className="text-button"
                        onClick={() =>
                          downloadFile(
                            `/materials/${f.id}/download`,
                            f.filename,
                          ).catch((e) => setError(e.message))
                        }
                      >
                        Tải xuống
                      </button>{" "}
                      <button
                        className="text-button danger"
                        disabled={busy}
                        onClick={() => remove(f)}
                      >
                        Xóa tài liệu
                      </button>
                    </td>
                  </tr>
                ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}
export function ReportsPanel() {
  const year = new Date().getFullYear(),
    [range, setRange] = useState({
      from: `${year}-01-01`,
      to: `${year}-12-31`,
    });
  const query = new URLSearchParams(range),
    { data, error: loadError, reload } = useLoad(`/admin/reports?${query}`),
    [error, setError] = useState("");
  return (
    <div className="admin-panel">
      <h2>Đăng ký theo tháng</h2>
      <form
        className="report-filters"
        onSubmit={(e) => {
          e.preventDefault();
          setRange(Object.fromEntries(new FormData(e.currentTarget)));
          reload();
          setError("");
        }}
      >
        <Field
          label="Từ ngày"
          type="date"
          name="from"
          required
          defaultValue={range.from}
        />
        <Field
          label="Đến ngày"
          type="date"
          name="to"
          required
          defaultValue={range.to}
        />
        <button className="button">Xem báo cáo</button>
        <button
          className="button outline"
          type="button"
          onClick={() =>
            downloadFile(
              `/admin/reports/export.xlsx?${query}`,
              "bao-cao-vinh-english.xlsx",
            ).catch((e) => setError(e.message))
          }
        >
          Xuất Excel
        </button>
      </form>
      <ErrorMessage>{error || loadError}</ErrorMessage>
      {!data ? (
        <Loading />
      ) : (
        <>
          <p>
            Số đăng ký trong khoảng {data.from} đến {data.to}. Tháng được tính
            theo múi giờ Việt Nam.
          </p>
          <div className="table-wrap">
            <table>
              <thead>
                <tr>
                  <th>Tháng</th>
                  <th>Tổng</th>
                  <th>Chờ xác nhận</th>
                  <th>Đã xác nhận</th>
                  <th>Đã hủy</th>
                </tr>
              </thead>
              <tbody>
                {data.monthly.map((m) => (
                  <tr key={m.month}>
                    <td>{m.month}</td>
                    <td>{m.total}</td>
                    <td>{m.pending}</td>
                    <td>{m.confirmed}</td>
                    <td>{m.cancelled}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
          <h2>Sĩ số lớp hiện tại</h2>
          <p>
            Sĩ số tính toàn bộ đăng ký đã xác nhận, không phụ thuộc khoảng ngày
            báo cáo.
          </p>
          <div className="table-wrap">
            <table>
              <thead>
                <tr>
                  <th>Lớp</th>
                  <th>Lịch / phòng</th>
                  <th>Trạng thái</th>
                  <th>Sĩ số</th>
                </tr>
              </thead>
              <tbody>
                {data.classes.map((c) => (
                  <tr key={c.id}>
                    <td>
                      {c.name}
                      <small>{c.courseName}</small>
                    </td>
                    <td>
                      {c.schedule}
                      <small>
                        {c.campus} · {c.room || "Chưa xếp phòng"}
                      </small>
                    </td>
                    <td>{classStatuses[c.effectiveStatus]}</td>
                    <td>
                      {c.enrolled}/{c.capacity}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </>
      )}
    </div>
  );
}
export function WeeklySchedule({ enrollments, catalog }) {
  const classes = catalog.classes.filter(
    (c) =>
      !["completed", "cancelled"].includes(c.effectiveStatus) &&
      enrollments.some((e) => e.classId === c.id && e.status === "confirmed"),
  );
  return (
    <details className="weekly-schedule">
      <summary>Lịch học hàng tuần</summary>
      <p>Lịch định kỳ áp dụng trong khoảng ngày học của từng lớp.</p>
      <div className="week-grid">
        {[1, 2, 3, 4, 5, 6, 7].map((day) => (
          <div key={day}>
            <h3>{day === 7 ? "Chủ nhật" : `Thứ ${day + 1}`}</h3>
            {classes
              .filter((c) => c.weekdays.includes(day))
              .map((c) => (
                <p key={c.id}>
                  <strong>{c.name}</strong>
                  <br />
                  {c.startTime} – {c.endTime}
                  <br />
                  {c.campus} · {c.room || "Chưa xếp phòng"}
                </p>
              ))}
          </div>
        ))}
      </div>
    </details>
  );
}
