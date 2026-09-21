import { z } from 'zod';
const text = z.string().trim().min(1, 'Vui lòng điền đủ thông tin.').max(500);
const long = z.string().trim().min(1).max(20000);
export const email = z.string().trim().toLowerCase().email('Email chưa đúng định dạng.').max(254);
export const phone = z.string().trim().regex(/^(?:\+84|0)[0-9]{9,10}$/, 'Số điện thoại phải bắt đầu bằng 0 hoặc +84.');
const date = z.string().regex(/^\d{4}-\d{2}-\d{2}$/).refine(v => !Number.isNaN(Date.parse(v)) && new Date(v).toISOString().slice(0,10) === v, 'Ngày không hợp lệ.');
const birthday = z.union([z.literal(''), date.refine(v => v <= new Date().toISOString().slice(0,10), 'Ngày sinh không được ở tương lai.')]).default('');
const id = z.number().int().positive();
const image = z.string().max(1000).refine(v => /^\/images\/[a-zA-Z0-9._-]+$/.test(v) || /^https:\/\//.test(v), 'Ảnh phải là đường dẫn /images/ hoặc HTTPS.');
export const profile = z.object({ name: text.max(100), phone, birthday });
export const enrollment = profile.extend({ email, classId: id, note: z.string().trim().max(2000).default('') });
export const register = profile.extend({ email, password: z.string().min(10, 'Mật khẩu cần ít nhất 10 ký tự.').max(128) });
export const login = z.object({ email, password: z.string().min(1).max(128) });
export const contact = z.object({ name: text.max(100), email, phone, message: long.max(3000) });
export const schemas = {
  courses: z.object({ name: text, category: text, level: text, duration: z.number().int().min(1).max(104), tuition: z.number().int().min(0).max(100000000), lessons: z.number().int().min(1).max(500), audience: text, image, description: long, material: z.string().max(20000).default('') }),
  teachers: z.object({ name: text, degree: text, experience: z.number().int().min(0).max(60), specialty: text, image, description: long }),
  classes: z.object({ courseId: id, teacherId: id, name: text, startDate: date, endDate: date, schedule: text, campus: text, capacity: z.number().int().min(1).max(100) }),
  news: z.object({ title: text, category: text, date, image, excerpt: text, content: long }),
  questions: z.object({ prompt: text, options: z.array(text).length(4), answer: z.number().int().min(0).max(3) }),
  students: register,
  enrollments: z.object({ status: z.enum(['pending', 'confirmed', 'cancelled']), userId: id.nullable().optional(), grades: z.object({ listening: z.number().min(0).max(10).optional(), reading: z.number().min(0).max(10).optional(), writing: z.number().min(0).max(10).optional(), speaking: z.number().min(0).max(10).optional() }).default({}) }),
};
