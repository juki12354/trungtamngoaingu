import { useState } from "react";
import { Link } from "react-router-dom";
import {
  ArrowRight,
  ArrowLeft,
  Check,
  ClipboardCheck,
  GraduationCap,
} from "lucide-react";
import {
  useApp,
  useLoad,
  api,
  PageHeading,
  ErrorMessage,
  Loading,
} from "../lib";
export function Placement() {
  const { data: preview, error: loadError, reload } = useLoad("/questions");
  const [attempt, setAttempt] = useState(null);
  const questions = attempt?.questions || preview;
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
      setResult(
        await api("/placement", {
          method: "POST",
          body: { answers, token: attempt.token },
        }),
      );
    } catch (e) {
      setError(e.message);
    } finally {
      setBusy(false);
    }
  }
  async function start() {
    setBusy(true);
    setError("");
    try {
      const value = await api("/placement/attempts", {
        method: "POST",
        body: {},
      });
      setAttempt(value);
      setAnswers({});
      setIndex(0);
      setStarted(true);
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
            <QuizReview review={result.review} />
            <button
              className="text-button"
              onClick={() => {
                setStarted(false);
                setAttempt(null);
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
            <ErrorMessage>{error}</ErrorMessage>
            <button className="button" disabled={busy} onClick={start}>
              Bắt đầu kiểm tra
              <ArrowRight size={18} />
            </button>
          </div>
        ) : (
          <div className="form-panel quiz">
            <p className="muted">
              Nộp trước{" "}
              {new Date(attempt.expiresAt).toLocaleTimeString("vi-VN")}.{" "}
              <button className="text-button" disabled={busy} onClick={start}>
                Bắt đầu bài mới
              </button>
            </p>
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
export function QuizReview({ review = [] }) {
  return review.length ? (
    <details className="quiz-review">
      <summary>Xem lại câu trả lời ({review.length} câu)</summary>
      <ol>
        {review.map((q) => (
          <li key={q.id}>
            <strong>{q.prompt}</strong>
            <p>
              Bạn chọn: {q.options[q.selected]}{" "}
              {q.selected === q.answer ? "✓ Đúng" : "✗ Chưa đúng"}
            </p>
            {q.selected !== q.answer && (
              <p>Đáp án đúng: {q.options[q.answer]}</p>
            )}
          </li>
        ))}
      </ol>
    </details>
  ) : null;
}
