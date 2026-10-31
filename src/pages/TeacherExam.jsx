import { useEffect, useState } from "react";
import { api, ErrorMessage, Field, languageName } from "../lib";

export default function TeacherExam({ applicationId, exam, onSubmitted }) {
  const [answers, setAnswers] = useState(exam.answers || {}),
    [written, setWritten] = useState(
      exam.written?.length === 2 ? exam.written : ["", ""],
    );
  const [remaining, setRemaining] = useState(
      Math.max(0, exam.expires - Date.now()),
    ),
    [error, setError] = useState(""),
    [busy, setBusy] = useState(false),
    [saved, setSaved] = useState("");
  useEffect(() => {
    const id = setInterval(
      () => setRemaining(Math.max(0, exam.expires - Date.now())),
      1000,
    );
    return () => clearInterval(id);
  }, [exam.expires]);
  useEffect(() => {
    let active = true;
    const timer = setTimeout(() => {
      if (Date.now() >= exam.expires || busy) return;
      setSaved("Đang lưu nháp…");
      api(`/recruitment/applications/${applicationId}/draft`, {
        method: "PUT",
        body: { assessmentId: exam.id, answers, written },
      })
        .then(() => {
          if (active) setSaved("Đã lưu nháp");
        })
        .catch((e) => {
          if (active) setSaved(`Chưa lưu được: ${e.message}`);
        });
    }, 700);
    return () => {
      active = false;
      clearTimeout(timer);
    };
  }, [answers, written, applicationId, exam.id, exam.expires, busy]);
  async function submit(e) {
    e.preventDefault();
    setBusy(true);
    setError("");
    try {
      await api(`/recruitment/applications/${applicationId}/submit`, {
        method: "POST",
        body: { assessmentId: exam.id, answers, written },
      });
      onSubmitted();
    } catch (e) {
      setError(e.message);
    } finally {
      setBusy(false);
    }
  }
  const seconds = Math.floor(remaining / 1000);
  return (
    <form className="form-panel teacher-exam" onSubmit={submit}>
      <span className="eyebrow">BÀI KIỂM TRA GIÁO VIÊN</span>
      <h2>
        {languageName(exam.language)} · {exam.levelCode}
      </h2>
      <div className="exam-toolbar">
        <strong role="timer" aria-label="Thời gian còn lại">
          Còn {Math.floor(seconds / 60)}:{String(seconds % 60).padStart(2, "0")}
        </strong>
        <span role="status">{saved}</span>
      </div>
      <p>
        Đề sàng lọc nội bộ. Trắc nghiệm chiếm 30 điểm; hai bài tự luận do QTV
        chấm, tối đa 70 điểm. Viết tự luận bằng ngôn ngữ ứng tuyển.
      </p>
      {!remaining && (
        <ErrorMessage>
          Đã hết giờ. Liên hệ trung tâm để được giao lại đề.
        </ErrorMessage>
      )}
      <fieldset disabled={busy || !remaining} className="exam-body">
        <legend>Phần 1 · Kiến thức ngôn ngữ</legend>
        {exam.questions.map((q, i) => (
          <fieldset key={q.id} className="teacher-question">
            <legend>
              Câu {i + 1} · {q.levelCode}
            </legend>
            <p className="preserve-lines">{q.prompt}</p>
            {q.options.map((option, index) => (
              <label key={index} className="exam-option">
                <input
                  type="radio"
                  name={q.id}
                  checked={answers[q.id] === index}
                  onChange={() => setAnswers({ ...answers, [q.id]: index })}
                  required
                />
                {option}
              </label>
            ))}
          </fieldset>
        ))}
        <h3>Phần 2 · Thực hành giảng dạy</h3>
        {exam.tasks.map((task, i) => (
          <div key={i} className="teacher-question">
            <h4>Nhiệm vụ {i + 1}</h4>
            <p>{task}</p>
            <Field label={`Bài tự luận ${i + 1} (80–6.000 ký tự)`}>
              <textarea
                rows={8}
                value={written[i]}
                minLength={80}
                maxLength={6000}
                required
                onChange={(e) =>
                  setWritten(
                    written.map((v, n) => (n === i ? e.target.value : v)),
                  )
                }
              />
            </Field>
          </div>
        ))}
        <ErrorMessage>{error}</ErrorMessage>
        <p>Nộp bài sẽ khóa câu trả lời của đề này.</p>
        <button className="button" disabled={busy || !remaining}>
          {busy ? "Đang nộp…" : "Nộp bài kiểm tra giáo viên"}
        </button>
      </fieldset>
    </form>
  );
}
