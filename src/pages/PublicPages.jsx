import { useState } from "react";
import { Link, useParams, useSearchParams } from "react-router-dom";
import {
  ArrowRight,
  ArrowUpRight,
  Search,
  Clock3,
  BookOpen,
  Users,
  Check,
  MapPin,
  Phone,
  Mail,
  ShieldCheck,
  Heart,
  Compass,
} from "lucide-react";
import {
  useApp,
  PageHeading,
  SectionHeading,
  CourseCard,
  Empty,
  Field,
  ErrorMessage,
  Success,
  api,
  money,
  date,
} from "../lib";
export function Courses() {
  const { catalog } = useApp();
  const [params, setParams] = useSearchParams();
  const q = params.get("q") || "",
    category = params.get("category") || "Tất cả";
  const set = (key, value) => {
    const next = new URLSearchParams(params);
    value ? next.set(key, value) : next.delete(key);
    setParams(next, { replace: true });
  };
  const filtered = catalog.courses.filter(
    (c) =>
      (category === "Tất cả" || c.category === category) &&
      `${c.name} ${c.description}`
        .toLocaleLowerCase("vi")
        .includes(q.toLocaleLowerCase("vi")),
  );
  return (
    <>
      <PageHeading
        eyebrow="CHƯƠNG TRÌNH HỌC"
        title="Tìm lớp học, mở tương lai."
      >
        Một lộ trình phù hợp cho từng độ tuổi, từng mục tiêu và từng khởi đầu.
      </PageHeading>
      <section className="section container">
        <div className="catalog-toolbar">
          <label className="search-box">
            <Search size={20} />
            <input
              aria-label="Tìm khóa học"
              placeholder="Bạn muốn học gì hôm nay?"
              value={q}
              onChange={(e) => set("q", e.target.value)}
            />
          </label>
          <label className="select-filter">
            Chương trình
            <select
              value={category}
              onChange={(e) => set("category", e.target.value)}
            >
              {[
                "Tất cả",
                ...new Set(catalog.courses.map((c) => c.category)),
              ].map((v) => (
                <option key={v}>{v}</option>
              ))}
            </select>
          </label>
        </div>
        <p className="muted">Có {filtered.length} khóa học dành cho bạn</p>
        <div className="course-grid">
          {filtered.map((c) => (
            <CourseCard key={c.id} course={c} />
          ))}
        </div>
        {!filtered.length && (
          <Empty>
            Không tìm thấy khóa học. Hãy thử từ khóa hoặc chương trình khác.
          </Empty>
        )}
      </section>
      <div className="container help-strip">
        <div>
          <h2>Chưa biết bắt đầu từ đâu?</h2>
          <p>Bài kiểm tra ngắn sẽ giúp bạn tìm điểm xuất phát.</p>
        </div>
        <Link className="button" to="/kiem-tra">
          Kiểm tra trình độ
          <ArrowRight size={18} />
        </Link>
      </div>
    </>
  );
}
export function CourseDetail() {
  const { id } = useParams();
  const { catalog } = useApp();
  const c = catalog.courses.find((v) => v.id === Number(id));
  if (!c) return <PageHeading title="Không tìm thấy khóa học" />;
  const classes = catalog.classes.filter((v) => v.courseId === c.id);
  return (
    <>
      <PageHeading eyebrow={c.category} title={c.name}>
        {c.description}
      </PageHeading>
      <section className="section container detail-grid">
        <div>
          <img className="detail-photo" src={c.image} alt={c.name} />
          <h2>Từng bước tiến gần mục tiêu</h2>
          <p>{c.description}</p>
          <div className="learning-points">
            {[
              "Củng cố kiến thức nền tảng và phát âm.",
              "Thực hành nghe, nói, đọc, viết theo chủ đề.",
              "Nhận phản hồi trực tiếp từ giáo viên.",
              "Ôn tập và đánh giá tiến bộ trong suốt khóa học.",
            ].map((v) => (
              <p key={v}>
                <Check size={18} />
                {v}
              </p>
            ))}
          </div>
          <h2>Lớp học sắp khai giảng</h2>
          <ClassTable classes={classes} />
        </div>
        <aside className="enroll-aside">
          <span className="eyebrow">ĐẦU TƯ CHO CHÍNH BẠN</span>
          <h2>
            {money(c.tuition)}
            <small> / khóa học</small>
          </h2>
          <dl>
            <div>
              <dt>
                <Clock3 size={17} />
                Thời lượng
              </dt>
              <dd>{c.duration} tuần</dd>
            </div>
            <div>
              <dt>
                <BookOpen size={17} />
                Số buổi
              </dt>
              <dd>{c.lessons} buổi</dd>
            </div>
            <div>
              <dt>
                <Users size={17} />
                Đối tượng
              </dt>
              <dd>{c.audience}</dd>
            </div>
            <div>
              <dt>
                <Compass size={17} />
                Trình độ
              </dt>
              <dd>{c.level}</dd>
            </div>
          </dl>
          <Link className="button full" to={`/dang-ky?course=${c.id}`}>
            Đăng ký khóa học
            <ArrowRight size={18} />
          </Link>
          <Link className="button outline full" to="/kiem-tra">
            Kiểm tra trình độ miễn phí
          </Link>
          <p className="muted small-text">
            Học phí và chương trình là dữ liệu minh họa cho đồ án. Đăng ký chưa
            phát sinh thanh toán.
          </p>
        </aside>
      </section>
    </>
  );
}
export function ClassTable({ classes }) {
  const { catalog } = useApp();
  if (!classes.length)
    return (
      <Empty>Chưa có lớp học phù hợp. Vui lòng liên hệ để được tư vấn.</Empty>
    );
  return (
    <div className="table-wrap">
      <table>
        <thead>
          <tr>
            <th>Lớp học</th>
            <th>Lịch học</th>
            <th>Khai giảng</th>
            <th>Sĩ số</th>
            <th>
              <span className="sr-only">Đăng ký</span>
            </th>
          </tr>
        </thead>
        <tbody>
          {classes.map((cls) => {
            const c = catalog.courses.find((v) => v.id === cls.courseId),
              t = catalog.teachers.find((v) => v.id === cls.teacherId),
              closed =
                cls.enrolled >= cls.capacity ||
                cls.effectiveStatus !== "enrolling";
            return (
              <tr key={cls.id}>
                <td>
                  <strong>{c?.name}</strong>
                  <small>
                    {cls.name} · {t?.name}
                  </small>
                </td>
                <td>
                  {cls.schedule}
                  <small>
                    {cls.campus}
                    {cls.room ? ` · Phòng ${cls.room}` : ""}
                  </small>
                </td>
                <td>{date(cls.startDate)}</td>
                <td>
                  <span className="badge">
                    {cls.enrolled}/{cls.capacity}
                  </span>
                </td>
                <td>
                  {closed ? (
                    <span className="muted">Đã đóng</span>
                  ) : (
                    <Link className="text-link" to={`/dang-ky?class=${cls.id}`}>
                      Đăng ký
                      <ArrowUpRight size={16} />
                    </Link>
                  )}
                </td>
              </tr>
            );
          })}
        </tbody>
      </table>
    </div>
  );
}
export function Schedule() {
  const { catalog } = useApp();
  const [course, setCourse] = useState("");
  return (
    <>
      <PageHeading
        eyebrow="LỊCH KHAI GIẢNG"
        title="Sẵn sàng cho một khởi đầu mới?"
      >
        Chọn lớp phù hợp với thời gian của bạn. Chúng tôi sẽ đồng hành từ buổi
        học đầu tiên.
      </PageHeading>
      <section className="section container">
        <label className="field filter-field">
          <span>Lọc theo khóa học</span>
          <select value={course} onChange={(e) => setCourse(e.target.value)}>
            <option value="">Tất cả khóa học</option>
            {catalog.courses.map((c) => (
              <option value={c.id} key={c.id}>
                {c.name}
              </option>
            ))}
          </select>
        </label>
        <ClassTable
          classes={catalog.classes.filter(
            (c) => !course || c.courseId === Number(course),
          )}
        />
        <p className="muted small-text">
          Lịch và cơ sở là dữ liệu minh họa. Số chỗ được cập nhật theo đăng ký
          đã xác nhận.
        </p>
      </section>
    </>
  );
}
export function Teachers() {
  const { catalog } = useApp();
  return (
    <>
      <PageHeading
        eyebrow="ĐỘI NGŨ GIÁO VIÊN"
        title="Người thầy tận tâm. Người bạn đồng hành."
      >
        Lắng nghe, truyền cảm hứng và giúp bạn tìm thấy sự tự tin của chính
        mình.
      </PageHeading>
      <section className="section container">
        <div className="teacher-grid">
          {catalog.teachers.map((t) => (
            <article className="teacher-card" key={t.id}>
              <Link to={`/giao-vien/${t.id}`} className="teacher-photo">
                <img src={t.image} alt={t.name} />
                <span>
                  <ArrowUpRight />
                </span>
              </Link>
              <span className="eyebrow">{t.specialty}</span>
              <h2>
                <Link to={`/giao-vien/${t.id}`}>{t.name}</Link>
              </h2>
              <p>{t.degree}</p>
              <span className="badge">{t.experience} năm kinh nghiệm</span>
              <p>{t.description}</p>
            </article>
          ))}
        </div>
        <p className="muted small-text">
          Hồ sơ giáo viên và ảnh chân dung dùng để minh họa giao diện đồ án.
        </p>
      </section>
    </>
  );
}
export function TeacherDetail() {
  const { id } = useParams(),
    { catalog } = useApp();
  const t = catalog.teachers.find((v) => v.id === Number(id));
  if (!t) return <PageHeading title="Không tìm thấy giáo viên" />;
  return (
    <>
      <PageHeading eyebrow="NGƯỜI ĐỒNG HÀNH" title={t.name}>
        {t.specialty}
      </PageHeading>
      <section className="container section teacher-detail">
        <img src={t.image} alt={t.name} />
        <div>
          <span className="badge">{t.experience} năm kinh nghiệm</span>
          <h2>{t.degree}</h2>
          <p>{t.description}</p>
          <h3>Lớp học đang phụ trách</h3>
          <ClassTable
            classes={catalog.classes.filter((c) => c.teacherId === t.id)}
          />
        </div>
      </section>
    </>
  );
}
export function About() {
  return (
    <>
      <PageHeading
        eyebrow="CÂU CHUYỆN CỦA CHÚNG TÔI"
        title="Từ một lời chào, đến ngàn kết nối."
      >
        Vinh English được xây dựng từ một niềm tin giản dị: ai cũng xứng đáng có
        cơ hội tự tin bước ra thế giới.
      </PageHeading>
      <section className="section container about-grid">
        <img
          className="detail-photo"
          src="/images/hero.jpg"
          alt="Cộng đồng học tập cùng nhau phát triển"
        />
        <div>
          <span className="eyebrow">GẦN GŨI TRONG TỪNG BUỔI HỌC</span>
          <h2>
            Một lớp học nhỏ.
            <br />
            Những ước mơ lớn.
          </h2>
          <p>
            Chúng tôi hướng đến môi trường học tiếng Anh cởi mở, nơi bạn được
            thử, được sai và được tiến bộ theo nhịp của mình.
          </p>
          <p>
            Từ nền tảng đầu tiên đến mục tiêu học tập và công việc, mỗi chương
            trình đều kết nối kiến thức với cuộc sống. Giáo viên đồng hành, lộ
            trình rõ ràng và sự thực hành đều đặn là ba điều chúng tôi luôn coi
            trọng.
          </p>
          <Link className="button" to="/khoa-hoc">
            Tìm chương trình của bạn
            <ArrowUpRight size={18} />
          </Link>
        </div>
      </section>
      <section className="values-section">
        <div className="container values-grid">
          {[
            [
              Heart,
              "Tận tâm",
              "Lắng nghe nhu cầu và quan tâm đến tiến bộ của từng học viên.",
            ],
            [
              Compass,
              "Thiết thực",
              "Học điều hữu ích và có cơ hội áp dụng ngay trong đời sống.",
            ],
            [
              ShieldCheck,
              "Minh bạch",
              "Thông tin rõ ràng về chương trình, lịch học và học phí.",
            ],
          ].map(([Icon, title, text]) => (
            <div key={title}>
              <Icon size={30} />
              <h2>{title}</h2>
              <p>{text}</p>
            </div>
          ))}
        </div>
      </section>
      <section className="section container">
        <SectionHeading
          eyebrow="KHÔNG GIAN HỌC TẬP"
          title="Đủ thoải mái để bạn là chính mình"
          text="Phòng học nhóm, góc đọc sách và không gian trao đổi giúp việc học diễn ra tự nhiên."
        />
        <div className="about-gallery">
          <img src="/images/teens.jpg" alt="Không gian lớp học" />
          <img src="/images/basics.jpg" alt="Góc học tập và đọc sách" />
        </div>
        <p className="muted small-text">
          Vinh English Center là mô hình trung tâm phục vụ đồ án. Thông tin cơ
          sở và nhân sự là dữ liệu minh họa.
        </p>
      </section>
    </>
  );
}
export function News() {
  const { catalog } = useApp();
  return (
    <>
      <PageHeading
        eyebrow="GÓC HỌC TẬP"
        title="Học thêm một điều. Mở thêm một lối."
      >
        Kinh nghiệm, câu chuyện và những gợi ý nhỏ để bạn học tiếng Anh mỗi
        ngày.
      </PageHeading>
      <section className="section container news-grid">
        {catalog.news.map((n) => (
          <article className="news-card" key={n.id}>
            <Link to={`/tin-tuc/${n.id}`}>
              <img src={n.image} alt={n.title} />
            </Link>
            <div>
              <span className="eyebrow">
                {n.category} · {date(n.date)}
              </span>
              <h2>
                <Link to={`/tin-tuc/${n.id}`}>{n.title}</Link>
              </h2>
              <p>{n.excerpt}</p>
              <Link className="text-link" to={`/tin-tuc/${n.id}`}>
                Đọc bài viết
                <ArrowUpRight size={17} />
              </Link>
            </div>
          </article>
        ))}
      </section>
    </>
  );
}
export function NewsDetail() {
  const { id } = useParams(),
    { catalog } = useApp();
  const n = catalog.news.find((v) => v.id === Number(id));
  if (!n) return <PageHeading title="Không tìm thấy bài viết" />;
  return (
    <>
      <PageHeading eyebrow={`${n.category} · ${date(n.date)}`} title={n.title}>
        {n.excerpt}
      </PageHeading>
      <article className="section container article">
        <img className="detail-photo" src={n.image} alt={n.title} />
        <div className="article-content">
          {n.content
            .split("\n")
            .filter(Boolean)
            .map((p, i) => (
              <p key={i}>{p}</p>
            ))}
        </div>
        <Link className="text-link" to="/tin-tuc">
          Khám phá bài viết khác
          <ArrowRight size={18} />
        </Link>
      </article>
    </>
  );
}
export function Contact() {
  const [busy, setBusy] = useState(false),
    [error, setError] = useState(""),
    [done, setDone] = useState(false);
  async function submit(e) {
    e.preventDefault();
    setBusy(true);
    setError("");
    try {
      await api("/contact", {
        method: "POST",
        body: Object.fromEntries(new FormData(e.currentTarget)),
      });
      setDone(true);
    } catch (e) {
      setError(e.message);
    } finally {
      setBusy(false);
    }
  }
  return (
    <>
      <PageHeading eyebrow="LIÊN HỆ" title="Chúng tôi luôn sẵn sàng lắng nghe.">
        Để lại lời nhắn, chúng tôi sẽ giúp bạn tìm lộ trình phù hợp.
      </PageHeading>
      <section className="section container contact-grid">
        <div>
          <h2>Ghé thăm Vinh English</h2>
          <div className="contact-detail">
            <MapPin />
            <div>
              <h3>Cơ sở Lê Lợi</h3>
              <p>28 Lê Lợi, TP. Vinh, Nghệ An</p>
            </div>
          </div>
          <div className="contact-detail">
            <MapPin />
            <div>
              <h3>Cơ sở Nguyễn Văn Cừ</h3>
              <p>86 Nguyễn Văn Cừ, TP. Vinh, Nghệ An</p>
            </div>
          </div>
          <div className="contact-detail">
            <Phone />
            <a href="tel:02383888899">0238 3 888 899</a>
          </div>
          <div className="contact-detail">
            <Mail />
            <a href="mailto:hello@vinhenglish.example">
              hello@vinhenglish.example
            </a>
          </div>
          <p>Thứ 2 – Chủ nhật · 08:00 – 21:00</p>
          <a
            className="button outline"
            href="https://www.google.com/maps/search/?api=1&query=Le+Loi+Vinh+Nghe+An"
            target="_blank"
            rel="noreferrer"
          >
            Xem khu vực trên bản đồ
            <ArrowUpRight size={18} />
          </a>
          <p className="muted small-text">
            Địa chỉ và thông tin liên hệ minh họa cho đồ án.
          </p>
        </div>
        <div className="form-panel">
          {done ? (
            <Success title="Đã nhận lời nhắn của bạn!">
              Thông tin đã được lưu để quản trị viên tiếp nhận.
            </Success>
          ) : (
            <form onSubmit={submit}>
              <h2>Chia sẻ với chúng tôi</h2>
              <Field label="Họ và tên" name="name" required maxLength={100} />
              <div className="form-grid">
                <Field label="Email" name="email" type="email" required />
                <Field
                  label="Số điện thoại"
                  name="phone"
                  type="tel"
                  pattern="(0|\+84)[0-9]{9,10}"
                  required
                />
              </div>
              <Field label="Bạn cần tư vấn điều gì?">
                <textarea name="message" rows={5} required maxLength={3000} />
              </Field>
              <ErrorMessage>{error}</ErrorMessage>
              <button className="button" disabled={busy}>
                {busy ? "Đang gửi…" : "Gửi lời nhắn"}
                <ArrowUpRight size={18} />
              </button>
            </form>
          )}
        </div>
      </section>
    </>
  );
}
