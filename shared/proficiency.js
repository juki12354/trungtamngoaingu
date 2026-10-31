const cefr = ["A1", "A2", "B1", "B2", "C1", "C2"];
export const skillLabels = {
  vocabulary: "Từ vựng",
  grammar: "Ngữ pháp",
  reading: "Đọc hiểu",
};
export const levelDescriptions = [
  "Làm quen chữ viết, phát âm và tình huống rất quen thuộc.",
  "Trao đổi thông tin trong sinh hoạt và hiểu các mẫu câu thông dụng.",
  "Xử lý tình huống quen thuộc, trình bày trải nghiệm và ý kiến.",
  "Đọc nội dung dài hơn và giải thích quan điểm với lập luận.",
  "Phân tích nội dung phức tạp, diễn đạt linh hoạt theo ngữ cảnh.",
  "Phân biệt sắc thái, tổng hợp và phản biện nội dung trừu tượng.",
];
export function proficiencyFor(language) {
  const codes =
    language === "zh"
      ? ["HSK1", "HSK2", "HSK3", "HSK4", "HSK5", "HSK6", "HSK7-9"]
      : language === "ko"
        ? ["TOPIK1", "TOPIK2", "TOPIK3", "TOPIK4", "TOPIK5", "TOPIK6"]
        : language === "ja"
          ? ["N5", "N4", "N3", "N2", "N1"]
          : cefr;
  const standard =
    language === "zh"
      ? "HSK"
      : language === "ko"
        ? "TOPIK"
        : language === "ja"
          ? "JLPT"
          : "A1–C2";
  return {
    standard,
    levels: codes.map((code, index) => ({
      code,
      label: code.replace(/^HSK/, "HSK ").replace(/^TOPIK/, "TOPIK "),
      rank: index + 1,
      description: levelDescriptions[Math.min(index, 5)],
    })),
  };
}
export function evaluateCompetency(language, questions, answers) {
  const { standard, levels } = proficiencyFor(language);
  const breakdown = levels.map((level) => {
    const items = questions.filter((q) => q.levelCode === level.code);
    const correct = items.filter((q) => q.answer === answers[q.id]).length;
    return {
      ...level,
      correct,
      total: items.length,
      passed: items.length >= 3 && correct / items.length >= 2 / 3,
    };
  });
  let mastered = 0;
  for (const band of breakdown) {
    if (!band.passed) break;
    mastered++;
  }
  const target = levels[Math.min(mastered, levels.length - 1)];
  return {
    version: "competency-v1",
    standard,
    recommendedLevel: target.code,
    foundationLevel: mastered
      ? levels[mastered - 1].label
      : "Cần học từ nền tảng",
    level: target.label,
    breakdown,
    skills: Object.entries(skillLabels).map(([skill, label]) => {
      const items = questions.filter((q) => q.skill === skill);
      return {
        skill,
        label,
        correct: items.filter((q) => q.answer === answers[q.id]).length,
        total: items.length,
      };
    }),
    reason:
      mastered === 0
        ? "Nền tảng ở mức đầu chưa vững; nên bắt đầu từ khóa cơ bản."
        : mastered === levels.length
          ? "Hoàn thành tốt các nhóm câu hỏi; nên trao đổi với giáo viên trước khi vào lớp cao nhất."
          : "Gợi ý mức tiếp theo sau các nhóm nền tảng làm tốt liên tiếp; câu khó đúng rời rạc không làm bỏ qua nền tảng.",
  };
}
