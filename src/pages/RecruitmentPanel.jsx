import { useState } from "react";
import {
  api,
  useLoad,
  Field,
  LanguageSelect,
  ErrorMessage,
  Loading,
  Empty,
  languageName,
} from "../lib";
import {
  applicationStatuses,
  assessmentStatuses,
  recruitmentRubric,
} from "../../shared/recruitment.js";
import { CvSummary, LevelField } from "./Recruitment.jsx";

export default function RecruitmentPanel() {
  const [language, setLanguage] = useState(""),
    [status, setStatus] = useState(""),
    [page, setPage] = useState(1),
    [selected, setSelected] = useState(null);
  const query = new URLSearchParams({
    page,
    ...(language ? { language } : {}),
    ...(status ? { status } : {}),
  });
  const { data, error, reload } = useLoad(`/admin/recruitment?${query}`);
  return (
    <div className="recruitment-admin">
      <div className="recruitment-filters">
        <LanguageSelect
          value={language}
          onChange={(v) => {
            setLanguage(v);
            setPage(1);
          }}
          label="Ngôn ngữ hồ sơ"
        />
        <Field label="Trạng thái hồ sơ">
          <select
            value={status}
            onChange={(e) => {
              setStatus(e.target.value);
              setPage(1);
            }}
          >
            <option value="">Tất cả trạng thái</option>
            {Object.entries(applicationStatuses).map(([key, label]) => (
              <option key={key} value={key}>
                {label}
              </option>
            ))}
          </select>
        </Field>
        <button className="button outline" onClick={reload}>
          Làm mới hồ sơ
        </button>
      </div>
      <ErrorMessage>{error}</ErrorMessage>
      {!data ? (
        <Loading />
      ) : (
        <>
          <p>
            {data.total} hồ sơ · Trang {page}
          </p>
          {data.rows.length ? (
            <div className="table-wrap">
              <table>
                <thead>
                  <tr>
                    <th>Ứng viên</th>
                    <th>Chuyên môn trong CV</th>
                    <th>Kinh nghiệm</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                  </tr>
                </thead>
                <tbody>
                  {data.rows.map((a) => (
                    <tr key={a.id}>
                      <td>
                        <strong>{a.name}</strong>
                        <br />
                        {a.email}
                      </td>
                      <td>
                        {languageName(a.language)} · {a.levelCode}
                      </td>
                      <td>{a.experience} năm</td>
                      <td>{applicationStatuses[a.status]}</td>
                      <td>
                        <button
                          className="button outline small"
                          onClick={() => setSelected(a.id)}
                        >
                          Xem hồ sơ #{a.id}
                        </button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          ) : (
            <Empty>Chưa có hồ sơ phù hợp.</Empty>
          )}
          <div className="discovery-actions">
            <button
              className="button outline"
              disabled={page === 1}
              onClick={() => setPage(page - 1)}
            >
              Trang trước
            </button>
            <button
              className="button outline"
              disabled={page * 25 >= data.total}
              onClick={() => setPage(page + 1)}
            >
              Trang sau
            </button>
          </div>
        </>
      )}
      {selected && (
        <ApplicationReview key={selected} id={selected} onChange={reload} />
      )}
    </div>
  );
}
function ApplicationReview({ id, onChange }) {
  const { data, error, reload } = useLoad(`/admin/recruitment/${id}`);
  const [notice, setNotice] = useState("");
  if (!data) return error ? <ErrorMessage>{error}</ErrorMessage> : <Loading />;
  const latest = data.assessments[0],
    closed = ["approved", "rejected"].includes(data.status);
  const saved = (message) => {
    setNotice(message);
    reload();
    onChange();
  };
  return (
    <article className="form-panel recruitment-detail">
      <span className="eyebrow">
        HỒ SƠ #{data.id} · {applicationStatuses[data.status]}
      </span>
      <h2>{data.name}</h2>
      <p>
        {data.email} · {data.phone}
      </p>
      <button className="button outline" onClick={reload}>
        Cập nhật hồ sơ này
      </button>
      <ErrorMessage>{error}</ErrorMessage>
      {notice && (
        <p className="notice" role="status">
          {notice}
        </p>
      )}
      <CvSummary data={data} />
      {!closed && (
        <IssueAssessment
          key={`issue-${latest?.id || 0}`}
          application={data}
          latest={latest}
          onSaved={() =>
            saved(
              "Đã giao đề. Ứng viên có thể bắt đầu từ trang Ứng tuyển giáo viên.",
            )
          }
        />
      )}
      {data.assessments.map((exam, index) => (
        <details
          className="assessment-summary"
          key={exam.id}
          open={index === 0}
        >
          <summary>
            <strong>
              Đề #{exam.id} · {languageName(exam.language)} {exam.levelCode}
            </strong>{" "}
            · {assessmentStatuses[exam.status]}
          </summary>
          <p>
            <strong>Căn cứ từ CV:</strong> {exam.basis}
          </p>
          {exam.reason && (
            <p>
              <strong>Lý do giao lại:</strong> {exam.reason}
            </p>
          )}
          {exam.score !== null && (
            <p>
              <strong>
                Trắc nghiệm: {exam.score}/{exam.questions.length} ·{" "}
                {Math.round((exam.score / exam.questions.length) * 30)}/30 điểm
              </strong>
            </p>
          )}
          <details>
            <summary>Đề trắc nghiệm và bài làm</summary>
            {exam.questions.map((q, i) => (
              <div className="teacher-question" key={q.id}>
                <p className="preserve-lines">
                  <strong>
                    Câu {i + 1} · {q.levelCode}
                  </strong>
                  <br />
                  {q.prompt}
                </p>
                <p>Đáp án: {q.options[q.answer]}</p>
                <p>
                  Ứng viên chọn:{" "}
                  {q.options[exam.answers[q.id]] ?? "Chưa trả lời"}
                </p>
              </div>
            ))}
          </details>
          {exam.tasks.map((task, i) => (
            <div className="teacher-question" key={i}>
              <h3>Tự luận {i + 1}</h3>
              <p>{task}</p>
              <blockquote className="preserve-lines">
                {exam.written[i] || "Chưa có bài làm."}
              </blockquote>
            </div>
          ))}
        </details>
      ))}
      {!closed ? (
        <ReviewForm
          key={`review-${latest?.id || 0}`}
          application={data}
          exam={latest}
          onSaved={() => saved("Đã lưu đánh giá và trạng thái hồ sơ.")}
        />
      ) : (
        <div className="assessment-summary">
          <h3>Quyết định · {applicationStatuses[data.status]}</h3>
          <p className="preserve-lines">{data.feedback}</p>
          {data.evaluation.total !== undefined && (
            <p>
              <strong>Tổng điểm: {data.evaluation.total}/100</strong>
            </p>
          )}
          <p className="preserve-lines">
            Ghi chú nội bộ: {data.internalNote || "Không có"}
          </p>
          <p>
            QTV #{data.reviewedBy} · {data.reviewedAt}
          </p>
        </div>
      )}
    </article>
  );
}
function IssueAssessment({ application, latest, onSaved }) {
  const [language, setLanguage] = useState(
      latest?.language || application.language,
    ),
    [error, setError] = useState(""),
    [busy, setBusy] = useState(false);
  async function submit(e) {
    e.preventDefault();
    setBusy(true);
    setError("");
    const values = Object.fromEntries(new FormData(e.currentTarget));
    const { task1, task2, ...body } = values;
    try {
      await api(`/admin/recruitment/${application.id}/assessments`, {
        method: "POST",
        body: {
          ...body,
          language,
          cvVerified: body.cvVerified === "on",
          ...(task1 || task2 ? { tasks: [task1, task2] } : {}),
        },
      });
      onSaved();
    } catch (e) {
      setError(e.message);
    } finally {
      setBusy(false);
    }
  }
  return (
    <details className="assessment-summary" open={!latest}>
      <summary>
        <strong>
          {latest
            ? "Giao lại bài kiểm tra"
            : "Đối chiếu CV và giao bài kiểm tra"}
        </strong>
      </summary>
      <form onSubmit={submit}>
        <p>
          Đọc CV trước, chọn đúng ngôn ngữ/cấp độ có căn cứ. Có thể sửa nhiệm vụ
          tự luận theo chứng chỉ hoặc kinh nghiệm của ứng viên. Giao lại sẽ đóng
          đề cũ và yêu cầu ứng viên làm đề mới.
        </p>
        <div className="form-grid">
          <LanguageSelect
            all={false}
            label="Ngôn ngữ ra đề"
            value={language}
            onChange={setLanguage}
          />
          <LevelField
            label="Cấp độ ra đề"
            language={language}
            defaultValue={
              latest?.language === language
                ? latest.levelCode
                : application.language === language
                  ? application.levelCode
                  : undefined
            }
          />
        </div>
        <Field label="Căn cứ giao đề từ CV">
          <textarea
            name="basis"
            rows={3}
            minLength={15}
            maxLength={2000}
            required
            placeholder="Chứng chỉ/cấp độ, kinh nghiệm hoặc minh chứng cụ thể đã đối chiếu trong CV…"
          />
        </Field>
        {latest && (
          <Field label="Lý do giao lại đề">
            <textarea
              name="reason"
              rows={2}
              minLength={10}
              maxLength={1000}
              required
            />
          </Field>
        )}
        <details>
          <summary>Điều chỉnh nhiệm vụ tự luận theo CV (tùy chọn)</summary>
          <p>
            Để trống cả hai để dùng nhiệm vụ mặc định theo cấp độ. Nếu sửa, điền
            đủ cả hai nhiệm vụ; mỗi nhiệm vụ ít nhất 30 ký tự.
          </p>
          <Field label="Nhiệm vụ tự luận 1">
            <textarea name="task1" rows={4} minLength={30} maxLength={2000} />
          </Field>
          <Field label="Nhiệm vụ tự luận 2">
            <textarea name="task2" rows={4} minLength={30} maxLength={2000} />
          </Field>
        </details>
        <label className="recruitment-confirm">
          <input type="checkbox" name="cvVerified" required />
          Tôi đã đọc CV và đối chiếu căn cứ để chọn đề này.
        </label>
        <ErrorMessage>{error}</ErrorMessage>
        <button className="button" disabled={busy}>
          {busy
            ? "Đang giao đề…"
            : latest
              ? "Xác nhận giao lại đề"
              : "Giao bài kiểm tra"}
        </button>
      </form>
    </details>
  );
}
function ReviewForm({ application, exam, onSaved }) {
  const [error, setError] = useState(""),
    [busy, setBusy] = useState(false);
  const complete = exam?.status === "submitted";
  async function submit(e) {
    e.preventDefault();
    const decision = e.nativeEvent.submitter.value;
    const values = Object.fromEntries(new FormData(e.currentTarget));
    setBusy(true);
    setError("");
    try {
      await api(`/admin/recruitment/${application.id}/review`, {
        method: "POST",
        body: {
          ...values,
          decision,
          cvVerified: values.cvVerified === "on",
          ...(complete
            ? Object.fromEntries(
                recruitmentRubric.map(([key]) => [key, Number(values[key])]),
              )
            : {}),
        },
      });
      onSaved();
    } catch (e) {
      setError(e.message);
    } finally {
      setBusy(false);
    }
  }
  return (
    <form className="assessment-summary" onSubmit={submit}>
      <h3>Đánh giá và quyết định</h3>
      {complete ? (
        <>
          <p>
            Chấm hai bài tự luận theo tiêu chí dưới đây. Trắc nghiệm tự chấm:{" "}
            <strong>
              {Math.round((exam.score / exam.questions.length) * 30)}/30
            </strong>
            . QTV quyết định dựa trên cả CV và bài làm.
          </p>
          <div className="form-grid">
            {recruitmentRubric.map(([key, label, max]) => (
              <Field
                key={key}
                label={`${label} (0–${max})`}
                name={key}
                type="number"
                min={0}
                max={max}
                step={1}
                required
                defaultValue={application.evaluation[key] ?? ""}
              />
            ))}
          </div>
        </>
      ) : (
        <p className="notice">
          Chưa có bài kiểm tra mới nhất đã nộp. Chưa thể chấm hoặc duyệt hồ sơ;
          có thể từ chối với lý do rõ ràng sau khi xem CV.
        </p>
      )}
      <Field label="Phản hồi cho ứng viên">
        <textarea
          name="feedback"
          defaultValue={application.feedback}
          required
          minLength={10}
          maxLength={3000}
          rows={3}
        />
      </Field>
      <Field label="Ghi chú nội bộ (chỉ QTV)">
        <textarea
          name="internalNote"
          defaultValue={application.internalNote}
          maxLength={3000}
          rows={3}
        />
      </Field>
      <label className="recruitment-confirm">
        <input type="checkbox" name="cvVerified" required />
        Tôi đã đối chiếu CV, bằng cấp và bài làm hiện có để đưa ra đánh giá.
      </label>
      <ErrorMessage>{error}</ErrorMessage>
      <div className="discovery-actions">
        <button
          className="button outline"
          value="review"
          disabled={busy || !complete}
        >
          Lưu đánh giá
        </button>
        <button
          className="button"
          value="approved"
          disabled={busy || !complete}
        >
          Duyệt hồ sơ
        </button>
        <button className="button outline" value="rejected" disabled={busy}>
          Không duyệt hồ sơ
        </button>
      </div>
      <p className="muted">
        Quyết định duyệt/không duyệt sẽ đóng hồ sơ. CV và thông tin ứng viên
        không được đưa lên danh sách giáo viên công khai.
      </p>
    </form>
  );
}
