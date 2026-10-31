import { useState } from "react";
import { Link } from "react-router-dom";
import { FileText, ArrowRight, CheckCircle2 } from "lucide-react";
import {
  api,
  useApp,
  useLoad,
  PageHeading,
  Field,
  LanguageSelect,
  ErrorMessage,
  Loading,
  languageName,
} from "../lib";
import { proficiencyFor } from "../../shared/proficiency.js";
import {
  applicationStatuses,
  recruitmentRubric,
} from "../../shared/recruitment.js";
import { downloadFile } from "../download.js";
import TeacherExam from "./TeacherExam.jsx";

export default function Recruitment() {
  const { user } = useApp();
  return (
    <>
      <PageHeading
        eyebrow="GIA NHẬP ĐỘI NGŨ"
        title="Cùng dạy tốt. Cùng tiến xa."
      >
        Gửi CV, thể hiện chuyên môn và cùng xây dựng những lớp học có ý nghĩa.
      </PageHeading>
      <section className="container section recruitment-page">
        <ol className="recruitment-steps" aria-label="Quy trình ứng tuyển">
          <li>
            <span>01</span>
            <strong>Gửi hồ sơ</strong>
            <p>CV, ngôn ngữ và cấp độ bạn muốn giảng dạy.</p>
          </li>
          <li>
            <span>02</span>
            <strong>Kiểm tra chuyên môn</strong>
            <p>QTV đối chiếu CV và giao đề đúng cấp độ.</p>
          </li>
          <li>
            <span>03</span>
            <strong>Nhận đánh giá</strong>
            <p>QTV chấm bài, xem hồ sơ và thông báo quyết định.</p>
          </li>
        </ol>
        {user ? (
          <CandidatePortal key={user.id} />
        ) : (
          <div className="form-panel recruitment-intro">
            <FileText size={32} />
            <h2>Bắt đầu từ câu chuyện giảng dạy của bạn</h2>
            <p>
              Đăng nhập hoặc tạo tài khoản để gửi CV PDF/DOCX tối đa 5 MB và
              theo dõi hồ sơ. CV chỉ được chia sẻ với QTV tuyển dụng.
            </p>
            <Link className="button" to="/dang-nhap?next=/ung-tuyen">
              Đăng nhập / tạo tài khoản <ArrowRight size={18} />
            </Link>
          </div>
        )}
      </section>
    </>
  );
}
function CandidatePortal() {
  const { data, error, reload } = useLoad("/recruitment/applications");
  const [selected, setSelected] = useState(null),
    [newForm, setNewForm] = useState(false);
  if (!data) return error ? <ErrorMessage>{error}</ErrorMessage> : <Loading />;
  const current = selected || data[0]?.id;
  return (
    <div className="recruitment-workspace">
      <aside className="recruitment-list form-panel">
        <h2>Hồ sơ của bạn</h2>
        <ErrorMessage>{error}</ErrorMessage>
        {data.length === 0 && <p>Bạn chưa gửi hồ sơ ứng tuyển.</p>}
        {data.map((a) => (
          <button
            key={a.id}
            className={`application-link ${!newForm && current === a.id ? "active" : ""}`}
            onClick={() => {
              setSelected(a.id);
              setNewForm(false);
            }}
          >
            <strong>
              {languageName(a.language)} · {a.levelCode}
            </strong>
            <span>{applicationStatuses[a.status]}</span>
          </button>
        ))}
        <button className="button outline" onClick={() => setNewForm(true)}>
          Gửi CV mới
        </button>
        <p className="muted">
          Mỗi ngôn ngữ có một hồ sơ đang xử lý. Bạn có thể gửi hồ sơ khác sau
          khi nhận quyết định không duyệt.
        </p>
      </aside>
      {newForm || !current ? (
        <ApplicationForm
          onSaved={(id) => {
            setSelected(id);
            setNewForm(false);
            reload();
          }}
        />
      ) : (
        <CandidateApplication key={current} id={current} onChange={reload} />
      )}
    </div>
  );
}
function ApplicationForm({ onSaved }) {
  const { user } = useApp();
  const [language, setLanguage] = useState("en"),
    [error, setError] = useState(""),
    [busy, setBusy] = useState(false);
  async function submit(e) {
    e.preventDefault();
    const values = Object.fromEntries(new FormData(e.currentTarget));
    const file = values.cv;
    if (file.size > 5 * 1024 * 1024) return setError("CV tối đa 5 MB.");
    setBusy(true);
    setError("");
    try {
      const content = await new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.onload = () => resolve(reader.result.split(",")[1]);
        reader.onerror = () => reject(new Error("Không đọc được CV."));
        reader.readAsDataURL(file);
      });
      const { cv: _cv, ...body } = values;
      const result = await api("/recruitment/applications", {
        method: "POST",
        body: {
          ...body,
          language,
          experience: Number(body.experience),
          filename: file.name,
          content,
        },
      });
      onSaved(result.id);
    } catch (e) {
      setError(e.message);
    } finally {
      setBusy(false);
    }
  }
  return (
    <form className="form-panel" onSubmit={submit}>
      <span className="eyebrow">HỒ SƠ ỨNG TUYỂN</span>
      <h2>Chuyên môn của bạn</h2>
      <p>
        Điền đúng thông tin trong CV. QTV sẽ đọc CV và xác nhận cấp độ trước khi
        giao đề. Email nhận hồ sơ: <strong>{user.email}</strong>.
      </p>
      <div className="form-grid">
        <Field
          label="Họ và tên"
          name="name"
          defaultValue={user.name}
          required
          minLength={2}
          maxLength={150}
        />
        <Field
          label="Số điện thoại"
          name="phone"
          type="tel"
          defaultValue={user.phone}
          required
          maxLength={20}
        />
        <LanguageSelect
          label="Ngôn ngữ ứng tuyển"
          all={false}
          value={language}
          onChange={setLanguage}
        />
        <LevelField language={language} label="Cấp độ trong CV" />
        <Field
          label="Kinh nghiệm giảng dạy (năm)"
          name="experience"
          type="number"
          min={0}
          max={60}
          step={1}
          required
        />
        <Field label="CV (PDF hoặc DOCX, tối đa 5 MB)">
          <input name="cv" type="file" accept=".pdf,.docx" required />
        </Field>
      </div>
      <Field label="Bằng cấp, chứng chỉ và thành tích liên quan">
        <textarea
          name="qualifications"
          rows={4}
          required
          minLength={10}
          maxLength={3000}
          placeholder="Tên chứng chỉ, cấp độ/điểm, đơn vị cấp; kinh nghiệm và thành tích giảng dạy trong CV…"
        />
      </Field>
      <Field label="Giới thiệu và mục tiêu giảng dạy">
        <textarea name="coverLetter" rows={3} maxLength={3000} />
      </Field>
      <ErrorMessage>{error}</ErrorMessage>
      <button className="button" disabled={busy}>
        {busy ? "Đang gửi CV…" : "Gửi hồ sơ ứng tuyển"}
        <ArrowRight size={18} />
      </button>
    </form>
  );
}
export function LevelField({ language, label, defaultValue }) {
  return (
    <Field label={label}>
      <select
        name="levelCode"
        key={language}
        defaultValue={defaultValue || proficiencyFor(language).levels[0].code}
        required
      >
        {proficiencyFor(language).levels.map((l) => (
          <option key={l.code} value={l.code}>
            {l.label}
          </option>
        ))}
      </select>
    </Field>
  );
}
export function CvSummary({ data }) {
  const [error, setError] = useState("");
  return (
    <div className="cv-summary">
      <dl>
        <div>
          <dt>Ngôn ngữ / cấp độ khai báo</dt>
          <dd>
            {languageName(data.language)} · {data.levelCode}
          </dd>
        </div>
        <div>
          <dt>Kinh nghiệm giảng dạy</dt>
          <dd>{data.experience} năm</dd>
        </div>
        <div>
          <dt>Bằng cấp, chứng chỉ, thành tích</dt>
          <dd className="preserve-lines">{data.qualifications}</dd>
        </div>
        {data.coverLetter && (
          <div>
            <dt>Giới thiệu</dt>
            <dd className="preserve-lines">{data.coverLetter}</dd>
          </div>
        )}
      </dl>
      <button
        className="button outline"
        onClick={async () => {
          try {
            setError("");
            await downloadFile(
              `/recruitment/applications/${data.id}/cv`,
              data.filename,
            );
          } catch (e) {
            setError(e.message);
          }
        }}
      >
        <FileText size={18} />
        Tải CV · {data.filename}
      </button>
      <ErrorMessage>{error}</ErrorMessage>
    </div>
  );
}
function CandidateApplication({ id, onChange }) {
  const { data, error, reload } = useLoad(`/recruitment/applications/${id}`);
  const [actionError, setError] = useState(""),
    [busy, setBusy] = useState(false);
  if (!data) return error ? <ErrorMessage>{error}</ErrorMessage> : <Loading />;
  const exam = data.assessment;
  if (exam?.questions)
    return (
      <TeacherExam
        key={exam.id}
        applicationId={id}
        exam={exam}
        onSubmitted={() => {
          reload();
          onChange();
        }}
      />
    );
  async function start() {
    setBusy(true);
    setError("");
    try {
      await api(`/recruitment/applications/${id}/start`, {
        method: "POST",
        body: {},
      });
      reload();
    } catch (e) {
      setError(e.message);
    } finally {
      setBusy(false);
    }
  }
  return (
    <article className="form-panel">
      <span className="badge">{applicationStatuses[data.status]}</span>
      <h2>{data.name}</h2>
      <ErrorMessage>{error || actionError}</ErrorMessage>
      <CvSummary data={data} />
      {data.status === "submitted" && (
        <p className="notice">
          Đã nhận hồ sơ. QTV sẽ đọc CV, xác nhận ngôn ngữ/cấp độ và giao bài
          kiểm tra tại đây.
        </p>
      )}
      {exam && (
        <div className="assessment-summary">
          <h3>
            Bài kiểm tra · {languageName(exam.language)} {exam.levelCode}
          </h3>
          <p>
            Trắc nghiệm kiến thức ngôn ngữ và 2 bài tự luận về giảng dạy. Thời
            gian: 60 phút từ khi bắt đầu. Bài được lưu nháp tự động khi có kết
            nối.
          </p>
          {exam.status === "assigned" && (
            <button className="button" disabled={busy} onClick={start}>
              {busy ? "Đang mở đề…" : "Bắt đầu bài kiểm tra"}
            </button>
          )}
          {exam.status === "started" && (
            <ErrorMessage>
              Bài kiểm tra đã hết giờ. Vui lòng liên hệ trung tâm để được giao
              lại đề.
            </ErrorMessage>
          )}
          {exam.submittedAt && (
            <p>
              <CheckCircle2 size={18} /> Đã nộp · Trắc nghiệm: {exam.score}/
              {exam.total}.{" "}
              {data.evaluation.total !== undefined
                ? "Đã hoàn tất đánh giá."
                : "QTV sẽ chấm bài tự luận."}
            </p>
          )}
        </div>
      )}
      {data.feedback && (
        <div className="assessment-summary">
          <h3>Phản hồi từ trung tâm</h3>
          <p className="preserve-lines">{data.feedback}</p>
          {data.evaluation.total !== undefined && (
            <>
              <strong>Tổng điểm: {data.evaluation.total}/100</strong>
              <p>Trắc nghiệm: {data.evaluation.automatic}/30</p>
              {recruitmentRubric.map(([key, label, max]) => (
                <p key={key}>
                  {label}: {data.evaluation[key]}/{max}
                </p>
              ))}
            </>
          )}
        </div>
      )}
    </article>
  );
}
