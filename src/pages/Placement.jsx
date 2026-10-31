import { useState } from "react";
import { Link, useSearchParams } from "react-router-dom";
import { proficiencyFor, skillLabels } from "../../shared/proficiency.js";
import { languageCodes } from "../../shared/languages.js";
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
  LanguageSelect,
  languageName,
} from "../lib";
export function Placement() {
  const [params] = useSearchParams();
  const [language, setLanguage] = useState(
    languageCodes.includes(params.get("language"))
      ? params.get("language")
      : "en",
  );
  const {
    data: preview,
    error: loadError,
    reload,
  } = useLoad(`/questions?language=${language}&assessment=competency`);
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
        body: { language, assessment: "competency" },
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
            <p>{languageName(result.language)}</p>
            <h2>Thêm một bước hiểu chính mình!</h2>
            <div className="score">
              {result.score}
              <span>/{result.total}</span>
            </div>
            <span className="badge">Gợi ý học: {result.level}</span>
            <p>
              Kết quả sàng lọc từ vựng, ngữ pháp và đọc hiểu để gợi ý lớp học,
              không thay thế chứng chỉ hoặc đánh giá nghe, nói, viết của giáo
              viên.
            </p>
            <CompetencySummary analysis={result.analysis} />
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
            {result.recommendations && (
              <section
                className="recommended-classes"
                aria-label="Lớp học được gợi ý"
              >
                <h3>Lớp phù hợp đang mở</h3>
                <p>{result.recommendations.message}</p>
                {result.recommendations.classes.map((cls) => (
                  <article key={cls.id} className="recommended-class">
                    <div>
                      <strong>
                        {cls.name} · {result.level}
                      </strong>
                      <p>{cls.schedule}</p>
                      <p>
                        {cls.campus} · {cls.teacherName} · Còn {cls.available}{" "}
                        chỗ
                      </p>
                      <p>
                        Khai giảng{" "}
                        {new Date(
                          `${cls.startDate}T00:00:00`,
                        ).toLocaleDateString("vi-VN")}
                      </p>
                    </div>
                    <Link
                      className="button small"
                      to={`/dang-ky?class=${cls.id}`}
                    >
                      Đăng ký lớp này <ArrowRight size={16} />
                    </Link>
                  </article>
                ))}
                {!result.recommendations.classes.length && (
                  <Link
                    className="button outline"
                    to={
                      result.courseId
                        ? `/tu-van?course=${result.courseId}`
                        : "/tu-van"
                    }
                  >
                    Nhận tư vấn xếp lớp
                  </Link>
                )}
              </section>
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
            <LanguageSelect
              label="Ngôn ngữ kiểm tra"
              all={false}
              value={language}
              onChange={(v) => {
                setLanguage(v);
                setError("");
              }}
            />
            <ClipboardCheck size={52} />
            <div className="level-guide">
              <h3>
                Lộ trình {languageName(language)} ·{" "}
                {proficiencyFor(language).standard}
              </h3>
              <div className="level-chips">
                {proficiencyFor(language).levels.map((l) => (
                  <span className="badge" key={l.code} title={l.description}>
                    {l.label}
                  </span>
                ))}
              </div>
              <p>
                Mỗi mức có câu hỏi từ vựng, ngữ pháp và đọc hiểu. Kết quả dùng
                để chọn điểm bắt đầu trong lộ trình của trung tâm.
              </p>
            </div>
            <h2>Sẵn sàng khám phá trình độ của bạn?</h2>
            <p>Không áp lực điểm số. Hãy chọn đáp án bạn thấy phù hợp nhất.</p>
            <div className="test-facts">
              <span>
                <strong>{questions.length}</strong>Câu hỏi trắc nghiệm
              </span>
              <span>
                <strong>15–25</strong>Phút dự kiến
              </span>
              <span>
                <strong>Miễn phí</strong>Không cần đăng nhập
              </span>
            </div>
            <p className="muted">
              Làm các câu từ nền tảng đến nâng cao. Hệ thống gợi ý đúng ngôn
              ngữ, cấp độ và lớp còn chỗ dựa trên từng nhóm câu hỏi.
            </p>
            <ErrorMessage>{error}</ErrorMessage>
            <button className="button" disabled={busy} onClick={start}>
              Bắt đầu kiểm tra
              <ArrowRight size={18} />
            </button>
          </div>
        ) : (
          <div className="form-panel quiz">
            <p className="badge">
              {languageName(attempt.language)} · {q.levelCode} ·{" "}
              {skillLabels[q.skill]}
            </p>
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
export function CompetencySummary({ analysis }) {
  if (!analysis?.breakdown) return null;
  return (
    <section className="competency-summary" aria-label="Phân tích năng lực">
      <h3>Nền tảng và hướng học tiếp</h3>
      <p>
        Nền tảng làm tốt: <strong>{analysis.foundationLevel}</strong>
      </p>
      <p>{analysis.reason}</p>
      <div className="skill-results">
        {analysis.skills.map((s) => (
          <div key={s.skill}>
            <span>
              {s.label}:{" "}
              <strong>
                {s.correct}/{s.total}
              </strong>
            </span>
            <progress aria-label={s.label} max={s.total} value={s.correct} />
          </div>
        ))}
      </div>
      <h4>Kết quả theo nhóm cấp độ</h4>
      <div className="band-results">
        {analysis.breakdown.map((b) => (
          <div key={b.code}>
            <strong>{b.label}</strong>
            <span>
              {b.correct}/{b.total} câu
            </span>
            <span>{b.passed ? "Làm tốt nhóm câu" : "Cần củng cố"}</span>
          </div>
        ))}
      </div>
    </section>
  );
}
