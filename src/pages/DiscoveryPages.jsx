import { useState } from "react";
import { Link, useSearchParams } from "react-router-dom";
import { ArrowUpRight, MapPin, Phone } from "lucide-react";
import {
  useApp,
  api,
  PageHeading,
  SectionHeading,
  Field,
  ErrorMessage,
  Success,
  Empty,
} from "../lib";

export function ConsultationForm({ trial = false }) {
  const { catalog } = useApp();
  const [params] = useSearchParams();
  const [busy, setBusy] = useState(false),
    [error, setError] = useState(""),
    [done, setDone] = useState(false);
  async function submit(event) {
    event.preventDefault();
    const data = Object.fromEntries(new FormData(event.currentTarget));
    setBusy(true);
    setError("");
    try {
      await api("/contact", {
        method: "POST",
        body: {
          ...data,
          age: data.age ? Number(data.age) : null,
          courseId: data.courseId ? Number(data.courseId) : null,
          kind: trial ? "trial" : "consultation",
        },
      });
      setDone(true);
    } catch (e) {
      setError(e.message);
    } finally {
      setBusy(false);
    }
  }
  if (done)
    return (
      <Success
        title={trial ? "Đã nhận yêu cầu học thử!" : "Đã nhận yêu cầu tư vấn!"}
      >
        Thông tin đã được lưu. Trung tâm sẽ liên hệ để xác nhận thời gian phù
        hợp; yêu cầu này chưa phải lịch hẹn đã xác nhận.
      </Success>
    );
  return (
    <form onSubmit={submit} className="consultation-form">
      <h2>{trial ? "Đăng ký học thử" : "Đăng ký tư vấn"}</h2>
      <p className="muted">
        Chia sẻ mục tiêu để chúng tôi chuẩn bị buổi trao đổi phù hợp.
      </p>
      <Field
        label="Họ và tên"
        name="name"
        required
        maxLength={100}
        autoComplete="name"
      />
      <div className="form-grid">
        <Field
          label="Số điện thoại"
          name="phone"
          type="tel"
          pattern="(0|\+84)[0-9]{9,10}"
          required
          autoComplete="tel"
        />
        <Field
          label="Email"
          name="email"
          type="email"
          required
          maxLength={254}
          autoComplete="email"
        />
        <Field
          label="Độ tuổi"
          name="age"
          type="number"
          min={4}
          max={100}
          required
        />
        <Field label="Khóa học quan tâm">
          <select
            name="courseId"
            required
            defaultValue={
              catalog.courses.some((c) => String(c.id) === params.get("course"))
                ? params.get("course")
                : ""
            }
          >
            <option value="">Chọn khóa học</option>
            {catalog.courses.map((c) => (
              <option key={c.id} value={c.id}>
                {c.name}
              </option>
            ))}
          </select>
        </Field>
      </div>
      <Field label="Cơ sở muốn học">
        <select
          name="campus"
          required
          defaultValue={
            catalog.campuses.some((c) => c.name === params.get("campus"))
              ? params.get("campus")
              : ""
          }
        >
          <option value="">Chọn cơ sở</option>
          {catalog.campuses.map((c) => (
            <option key={c.name}>{c.name}</option>
          ))}
        </select>
      </Field>
      <Field label="Mục tiêu học tập">
        <textarea
          name="message"
          rows={4}
          required
          maxLength={3000}
          placeholder="Ví dụ: đạt TOEIC 650 để chuẩn bị đi làm, học buổi tối…"
        />
      </Field>
      <p className="muted small-text">
        Thông tin dùng để tiếp nhận và liên hệ về yêu cầu của bạn. Với học viên
        nhỏ tuổi, vui lòng điền số điện thoại và email của phụ huynh.
      </p>
      <ErrorMessage>{error}</ErrorMessage>
      <button className="button" disabled={busy}>
        {busy
          ? "Đang gửi…"
          : trial
            ? "Gửi yêu cầu học thử"
            : "Gửi yêu cầu tư vấn"}
        <ArrowUpRight size={18} />
      </button>
    </form>
  );
}

export function Consultation({ trial = false }) {
  return (
    <>
      <PageHeading
        eyebrow={trial ? "HỌC THỬ" : "TƯ VẤN"}
        title={
          trial
            ? "Trải nghiệm một buổi học, tìm hướng đi của bạn."
            : "Bắt đầu bằng một cuộc trò chuyện."
        }
      >
        Chọn khóa học và cơ sở thuận tiện. Trung tâm sẽ liên hệ để thống nhất
        lịch.
      </PageHeading>
      <section className="section container discovery-split">
        <div>
          <span className="eyebrow">CÙNG BẠN CHỌN ĐIỂM BẮT ĐẦU</span>
          <h2>Một lộ trình vừa sức, một mục tiêu rõ ràng.</h2>
          <p>
            Buổi trao đổi giúp làm rõ trình độ hiện tại, mục tiêu và thời gian
            bạn có thể dành cho việc học.
          </p>
          <ol className="consultation-steps">
            <li>Gửi nhu cầu học tập của bạn.</li>
            <li>Nhận tư vấn và xác nhận lịch phù hợp.</li>
            <li>Trải nghiệm lớp học hoặc kiểm tra đầu vào.</li>
          </ol>
          <Link className="text-link" to="/lo-trinh">
            Khám phá lộ trình học <ArrowUpRight size={18} />
          </Link>
          <p className="muted small-text">
            Trung tâm và thông tin chương trình minh họa cho đồ án.
          </p>
        </div>
        <div className="form-panel">
          <ConsultationForm key={String(trial)} trial={trial} />
        </div>
      </section>
    </>
  );
}

export function Campuses() {
  const { catalog } = useApp();
  const [params, setParams] = useSearchParams();
  const province = params.get("province") || "",
    campus = params.get("campus") || "";
  const available = catalog.campuses.filter(
    (c) => !province || c.province === province,
  );
  const filtered = available.filter((c) => !campus || c.name === campus);
  const set = (key, value) => {
    const next = new URLSearchParams(params);
    if (key === "province") next.delete("campus");
    value ? next.set(key, value) : next.delete(key);
    setParams(next, { replace: true });
  };
  return (
    <>
      <PageHeading eyebrow="HỆ THỐNG CƠ SỞ" title="Một lớp học gần bạn hơn.">
        Tìm cơ sở, xem địa chỉ và chọn lịch học thuận tiện.
      </PageHeading>
      <section className="section container">
        <div className="discovery-filters">
          <Field label="Tỉnh / thành">
            <select
              value={province}
              onChange={(e) => set("province", e.target.value)}
            >
              <option value="">Tất cả tỉnh / thành</option>
              {[...new Set(catalog.campuses.map((c) => c.province))].map(
                (p) => (
                  <option key={p}>{p}</option>
                ),
              )}
            </select>
          </Field>
          <Field label="Chọn cơ sở">
            <select
              value={campus}
              onChange={(e) => set("campus", e.target.value)}
            >
              <option value="">Tất cả cơ sở</option>
              {available.map((c) => (
                <option key={c.name}>{c.name}</option>
              ))}
            </select>
          </Field>
        </div>
        <p className="muted small-text">
          Địa chỉ, hình ảnh và số điện thoại là dữ liệu minh họa. Bản đồ mở khu
          vực theo địa chỉ, không phải địa điểm kinh doanh đã xác minh.
        </p>
        <div className="campus-grid">
          {filtered.map((c) => (
            <article className="campus-card" key={c.name}>
              <img
                src={c.image}
                alt={`Không gian học tập minh họa tại ${c.name}`}
              />
              <div>
                <span className="eyebrow">{c.province}</span>
                <h2>{c.name}</h2>
                <p>
                  <MapPin size={18} /> {c.address}
                </p>
                <p>
                  <Phone size={18} /> <a href={`tel:${c.phone}`}>{c.phone}</a>
                </p>
                <p>{c.hours}</p>
                <a
                  className="text-link"
                  href={`https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(c.address)}`}
                  target="_blank"
                  rel="noreferrer"
                >
                  Xem khu vực trên bản đồ <ArrowUpRight size={18} />
                </a>
                <div className="discovery-actions">
                  <Link
                    className="button"
                    to={`/lich-khai-giang?campus=${encodeURIComponent(c.name)}`}
                  >
                    Xem lịch tại cơ sở
                  </Link>
                  <Link
                    className="button outline"
                    to={`/hoc-thu?campus=${encodeURIComponent(c.name)}`}
                  >
                    Đăng ký học thử
                  </Link>
                </div>
              </div>
            </article>
          ))}
        </div>
        {!filtered.length && (
          <Empty>Chưa có cơ sở phù hợp. Hãy chọn lại khu vực.</Empty>
        )}
      </section>
    </>
  );
}

const pathways = [
  {
    name: "Xây nền tảng",
    audience: "Người mới bắt đầu hoặc cần học lại",
    stages: [
      "Beginner · làm quen",
      "Elementary · nền tảng",
      "Intermediate · ứng dụng",
    ],
    categories: ["Căn bản", "Giao tiếp"],
  },
  {
    name: "Tiếng Anh học thuật",
    audience: "Học sinh, sinh viên hướng tới IELTS",
    stages: [
      "Củng cố A2–B1",
      "IELTS Foundation",
      "Mục tiêu IELTS 5.5 → 6.5 → 7.0+",
    ],
    categories: ["IELTS"],
  },
  {
    name: "Tiếng Anh cho công việc",
    audience: "Sinh viên và người đi làm",
    stages: [
      "Ngữ pháp & từ vựng công sở",
      "TOEIC Listening & Reading",
      "Giao tiếp, email & thuyết trình",
    ],
    categories: ["TOEIC", "Đi làm", "Giao tiếp"],
  },
  {
    name: "Lớn lên cùng tiếng Anh",
    audience: "Trẻ em 6–11 tuổi và thiếu niên 12–15 tuổi",
    stages: [
      "Khám phá qua trò chơi",
      "Đọc, viết & trình bày ý tưởng",
      "Dự án nhóm & tư duy học thuật",
    ],
    categories: ["Trẻ em", "Thiếu niên"],
  },
];
export function Roadmap() {
  const { catalog } = useApp();
  const [selected, setSelected] = useState(0);
  const path = pathways[selected];
  return (
    <>
      <PageHeading
        eyebrow="LỘ TRÌNH HỌC"
        title="Mỗi mục tiêu có một điểm bắt đầu."
      >
        Chọn hướng học để xem các chặng và chương trình đang có.
      </PageHeading>
      <section className="section container">
        <div className="filter-tabs" aria-label="Chọn mục tiêu học">
          {pathways.map((p, i) => (
            <button
              key={p.name}
              aria-pressed={selected === i}
              className={selected === i ? "active" : ""}
              onClick={() => setSelected(i)}
            >
              {p.name}
            </button>
          ))}
        </div>
        <div className="roadmap-detail">
          <span className="eyebrow">{path.audience}</span>
          <h2>{path.name}</h2>
          <ol className="roadmap-stages">
            {path.stages.map((stage, i) => (
              <li key={stage}>
                <span>0{i + 1}</span>
                <h3>{stage}</h3>
                <p>
                  {
                    [
                      "Xác định nền tảng hiện tại qua bài kiểm tra và trao đổi với giáo viên.",
                      "Thực hành đều đặn, nhận phản hồi và ôn tập theo mục tiêu.",
                      "Đánh giá lại tiến bộ để chọn bước học tiếp theo.",
                    ][i]
                  }
                </p>
              </li>
            ))}
          </ol>
          <h3>Chương trình hiện có</h3>
          <div className="discovery-actions">
            {catalog.courses
              .filter((c) => path.categories.includes(c.category))
              .map((c) => (
                <Link
                  className="button outline"
                  key={c.id}
                  to={`/khoa-hoc/${c.id}`}
                >
                  {c.name}
                  <ArrowUpRight size={16} />
                </Link>
              ))}
          </div>
        </div>
        <p className="muted small-text">
          Các chặng là định hướng minh họa, không quy đổi trực tiếp CEFR sang
          điểm IELTS/TOEIC và không cam kết đầu ra. Mục tiêu cao hơn cần được tư
          vấn sau đánh giá đủ kỹ năng. Bài trắc nghiệm chỉ giúp chọn điểm xuất
          phát.
        </p>
        <div className="discovery-actions">
          <Link className="button" to="/kiem-tra">
            Kiểm tra trình độ
          </Link>
          <Link className="button outline" to="/tu-van">
            Nhận tư vấn lộ trình
          </Link>
        </div>
      </section>
    </>
  );
}

export function DiscoveryLinks() {
  return (
    <section className="section container">
      <SectionHeading
        eyebrow="BƯỚC TIẾP THEO"
        title="Chọn cách bắt đầu phù hợp với bạn"
      />
      <div className="discovery-links">
        {[
          [
            "/lo-trinh",
            "01",
            "Khám phá lộ trình",
            "Từ nền tảng đến học thuật và công việc.",
          ],
          [
            "/co-so",
            "02",
            "Tìm cơ sở",
            "Xem địa chỉ và những lớp học thuận tiện.",
          ],
          [
            "/hoc-thu",
            "03",
            "Đăng ký học thử",
            "Để lại nhu cầu và nhận xác nhận từ trung tâm.",
          ],
        ].map(([url, n, title, detail]) => (
          <Link key={url} to={url}>
            <span className="eyebrow">{n}</span>
            <h3>
              {title} <ArrowUpRight size={20} />
            </h3>
            <p>{detail}</p>
          </Link>
        ))}
      </div>
    </section>
  );
}
