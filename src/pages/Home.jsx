import { useState } from "react";
import { Link } from "react-router-dom";
import {
  ArrowUpRight,
  Check,
  Sparkles,
  Star,
  BookOpen,
  Users,
  Compass,
  Quote,
  Play,
  Globe2,
} from "lucide-react";
import { useApp, CourseCard, SectionHeading } from "../lib";
import { DiscoveryLinks, ConsultationForm } from "./DiscoveryPages";
import { ClassTable } from "./PublicPages";
export default function Home() {
  const { catalog } = useApp();
  const [category, setCategory] = useState("Tất cả");
  const courses =
    category === "Tất cả"
      ? catalog.courses.slice(0, 3)
      : catalog.courses.filter((c) => c.category === category);
  return (
    <>
      <section className="hero">
        <div className="container hero-grid">
          <div className="hero-copy">
            <span className="hero-label">
              <span />
              CÙNG BẠN VƯƠN XA HƠN MỖI NGÀY
            </span>
            <h1>
              Mở lời <em>tự tin.</em>
              <br />
              Mở lối{" "}
              <span className="underline">
                tương lai.
                <svg viewBox="0 0 380 15" aria-hidden="true">
                  <path d="M3 11 Q175 -4 377 8" />
                </svg>
              </span>
            </h1>
            <p>
              Tiếng Anh không chỉ là một ngôn ngữ.
              <br className="desktop-break" /> Đó là sự tự tin để kết nối, khám
              phá và trở thành
              <br className="desktop-break" /> phiên bản tốt hơn của chính bạn.
            </p>
            <div className="hero-buttons">
              <Link className="button" to="/hoc-thu">
                Đăng ký học thử
                <ArrowUpRight size={19} />
              </Link>
              <Link className="button outline" to="/kiem-tra">
                <span className="play-icon">
                  <Play size={12} fill="currentColor" />
                </span>
                Kiểm tra trình độ
              </Link>
            </div>
            <div className="hero-social">
              <div className="avatar-stack">
                <img src="/images/teacher1.jpg" alt="" />
                <img src="/images/teacher2.jpg" alt="" />
                <img src="/images/teacher3.jpg" alt="" />
                <span>
                  <Users size={17} />
                </span>
              </div>
              <div>
                <div className="stars">
                  {Array.from({ length: 5 }, (_, i) => (
                    <Star key={i} size={12} fill="currentColor" />
                  ))}
                </div>
                <span>Mỗi hành trình đều bắt đầu bằng một lời chào.</span>
              </div>
            </div>
          </div>
          <div className="hero-visual">
            <div className="hero-photo">
              <img
                src="/images/hero.jpg"
                alt="Nhóm sinh viên cùng trao đổi và học tập trong khuôn viên trường"
                fetchPriority="high"
              />
              <div className="photo-caption">
                <span className="live-dot" />
                LEARNING TOGETHER, GROWING TOGETHER
              </div>
            </div>
            <div className="hello-bubble">
              Hello, future!
              <Sparkles size={21} />
            </div>
            <div className="hero-orbit">
              <Globe2 size={40} />
            </div>
            <div className="achievement">
              <span className="achievement-icon">
                <GraduationIcon />
              </span>
              <div>
                <strong>Tự tin từng bước nhỏ</strong>
                <span>Vững vàng mỗi chặng đường</span>
              </div>
              <span className="achievement-check">
                <Check size={15} />
              </span>
            </div>
            <div className="handwritten">
              Your next chapter
              <br />
              starts here. <span>↗</span>
            </div>
          </div>
        </div>
        <div className="container hero-bottom">
          <span>
            <Check size={16} />
            Lộ trình phù hợp với bạn
          </span>
          <span>
            <Check size={16} />
            Giáo viên tận tâm
          </span>
          <span>
            <Check size={16} />
            Học để sử dụng thực tế
          </span>
          <a href="#chuong-trinh">
            KHÁM PHÁ THÊM <span>↓</span>
          </a>
        </div>
      </section>
      <section className="trust-strip">
        <div className="container">
          <p>
            Nền tảng vững chắc.
            <br />
            <strong>Tương lai rộng mở.</strong>
          </p>
          <div>
            <strong>{String(catalog.courses.length).padStart(2, "0")}</strong>
            <span>Chương trình học</span>
          </div>
          <div>
            <strong>{String(catalog.teachers.length).padStart(2, "0")}</strong>
            <span>Giáo viên đồng hành</span>
          </div>
          <div>
            <strong>18</strong>
            <span>Học viên tối đa / lớp mẫu</span>
          </div>
          <div>
            <strong>01</strong>
            <span>Lộ trình dành riêng cho bạn</span>
          </div>
        </div>
      </section>
      <section className="section container" id="chuong-trinh">
        <SectionHeading
          eyebrow="CHƯƠNG TRÌNH HỌC"
          title="Một khởi đầu phù hợp với bạn"
          text="Dù ở đâu trên hành trình, luôn có một lớp học dành cho bạn."
          link="Tất cả khóa học"
          to="/khoa-hoc"
        />
        <div className="filter-tabs" aria-label="Lọc chương trình">
          {["Tất cả", ...new Set(catalog.courses.map((c) => c.category))].map(
            (t) => (
              <button
                key={t}
                className={category === t ? "active" : ""}
                aria-pressed={category === t}
                onClick={() => setCategory(t)}
              >
                {t}
              </button>
            ),
          )}
        </div>
        <div className="course-grid">
          {courses.map((c) => (
            <CourseCard key={c.id} course={c} />
          ))}
        </div>
      </section>
      <DiscoveryLinks />
      <section className="why-section">
        <div className="container why-grid">
          <div className="why-photo">
            <img
              src="/images/adults.jpg"
              alt="Các bạn học viên cùng làm việc nhóm"
              loading="lazy"
            />
            <div className="photo-note">
              <span>Không ngại sai.</span>
              <strong>Chỉ ngại chưa bắt đầu.</strong>
              <Sparkles size={27} />
            </div>
          </div>
          <div>
            <span className="eyebrow">HỌC KHÁC BIỆT. TIẾN BỘ THẬT.</span>
            <h2>
              Không chỉ dạy tiếng Anh.
              <br />
              Chúng tôi khơi mở
              <br />
              <em>tiềm năng của bạn.</em>
            </h2>
            <p>
              Một môi trường đủ gần gũi để bạn thoải mái là chính mình, và đủ
              truyền cảm hứng để bạn tiến xa hơn.
            </p>
            <div className="benefit">
              <span>
                <Users size={21} />
              </span>
              <div>
                <h3>Giáo viên hiểu bạn, đồng hành cùng bạn</h3>
                <p>Phản hồi cụ thể, quan tâm đến từng bước tiến.</p>
              </div>
            </div>
            <div className="benefit">
              <span>
                <Compass size={21} />
              </span>
              <div>
                <h3>Lộ trình rõ ràng, mục tiêu vừa sức</h3>
                <p>Bắt đầu đúng trình độ, tiến bộ theo từng cột mốc.</p>
              </div>
            </div>
            <div className="benefit">
              <span>
                <BookOpen size={21} />
              </span>
              <div>
                <h3>Học trong lớp, dùng trong cuộc sống</h3>
                <p>Kiến thức trở thành kỹ năng qua thực hành mỗi ngày.</p>
              </div>
            </div>
            <Link className="text-link" to="/gioi-thieu">
              Tìm hiểu về Vinh English
              <ArrowUpRight size={18} />
            </Link>
          </div>
        </div>
      </section>
      <section className="section container">
        <SectionHeading
          eyebrow="NHỮNG NGƯỜI ĐỒNG HÀNH"
          title="Gặp người truyền cảm hứng cho bạn"
          link="Đội ngũ giáo viên"
          to="/giao-vien"
        />
        <div className="teacher-grid">
          {catalog.teachers.slice(0, 3).map((t) => (
            <Link to={`/giao-vien/${t.id}`} className="teacher-card" key={t.id}>
              <div className="teacher-photo">
                <img src={t.image} alt={t.name} loading="lazy" />
                <span>
                  <ArrowUpRight size={20} />
                </span>
              </div>
              <span className="eyebrow">{t.specialty}</span>
              <h3>{t.name}</h3>
              <p>{t.degree}</p>
            </Link>
          ))}
        </div>
      </section>
      <section className="student-stories">
        <div className="container">
          <SectionHeading
            eyebrow="GÓC NHÌN HỌC VIÊN"
            title="Những lời chia sẻ, những bước tiến"
            text="Nội dung phản hồi minh họa cho giao diện đồ án."
          />
          <div className="stories-grid">
            {[
              [
                "Hoàng An",
                "IELTS Foundation",
                "Mình biết rõ cần cải thiện điều gì sau mỗi buổi học. Mục tiêu lớn trở nên dễ bắt đầu hơn từ những bài tập nhỏ.",
              ],
              [
                "Mai Phương",
                "Tiếng Anh giao tiếp",
                "Điều mình thích nhất là được thực hành nhiều. Mình dần thoải mái hơn khi nói, kể cả khi chưa tìm được từ thật hoàn hảo.",
              ],
              [
                "Minh Khang",
                "English for Work",
                "Những tình huống viết email và thuyết trình giúp mình kết nối bài học với công việc hằng ngày.",
              ],
            ].map(([name, course, content]) => (
              <figure key={name}>
                <Quote size={25} aria-hidden="true" />
                <blockquote>{content}</blockquote>
                <figcaption>
                  <strong>{name}</strong>
                  <span>{course} · Hồ sơ minh họa</span>
                </figcaption>
              </figure>
            ))}
          </div>
        </div>
      </section>
      <section className="test-banner container">
        <div className="test-illustration">
          <Globe2 size={94} strokeWidth={1} />
          <span>Aa</span>
          <Sparkles size={28} />
        </div>
        <div>
          <span className="eyebrow">BƯỚC ĐẦU TIÊN, HOÀN TOÀN MIỄN PHÍ</span>
          <h2>Bạn đang ở đâu trên hành trình tiếng Anh?</h2>
          <p>
            Dành vài phút khám phá trình độ và tìm khóa học phù hợp với bạn.
          </p>
        </div>
        <Link className="button lime" to="/kiem-tra">
          Kiểm tra ngay
          <ArrowUpRight size={20} />
        </Link>
      </section>
      <section className="section container">
        <SectionHeading
          eyebrow="GÓC HỌC TẬP & CẢM HỨNG"
          title="Thêm một chút kiến thức mỗi ngày"
          link="Khám phá bài viết"
          to="/tin-tuc"
        />
        <div className="news-grid">
          {catalog.news.map((n) => (
            <Link className="news-card" key={n.id} to={`/tin-tuc/${n.id}`}>
              <img src={n.image} alt="" loading="lazy" />
              <div>
                <span className="eyebrow">{n.category}</span>
                <h3>{n.title}</h3>
                <span className="text-link">
                  Đọc tiếp
                  <ArrowUpRight size={17} />
                </span>
              </div>
            </Link>
          ))}
        </div>
      </section>
      <section className="section container">
        <SectionHeading
          eyebrow="LỊCH KHAI GIẢNG"
          title="Các lớp đang nhận đăng ký"
          link="Xem toàn bộ lịch"
          to="/lich-khai-giang"
        />
        <ClassTable
          classes={catalog.classes
            .filter(
              (c) =>
                c.effectiveStatus === "enrolling" && c.enrolled < c.capacity,
            )
            .sort((a, b) => a.startDate.localeCompare(b.startDate))
            .slice(0, 3)}
        />
      </section>
      <section className="section container home-consultation">
        <div className="form-panel">
          <ConsultationForm />
        </div>
      </section>
      <section className="closing">
        <div className="container">
          <div>
            <span className="eyebrow">HẸN GẶP BẠN TẠI VINH ENGLISH</span>
            <h2>
              Hành trình mới bắt đầu
              <br />
              từ một lời <em>“Hello”.</em>
            </h2>
          </div>
          <Link className="button" to="/dang-ky">
            Tìm lớp học của bạn
            <ArrowUpRight size={19} />
          </Link>
        </div>
      </section>
    </>
  );
}
function GraduationIcon() {
  return <BookOpen size={24} />;
}
