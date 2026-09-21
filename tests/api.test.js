import { test, before, after } from 'node:test';
import assert from 'node:assert/strict';
import { createApp } from '../server/app.js';
let server, base, admin, student;
async function request(path, method = 'GET', body, cookie) {
  const res = await fetch(base + path, { method, headers: { ...(body ? { 'Content-Type': 'application/json' } : {}), ...(cookie ? { Cookie: cookie } : {}) }, body: body ? JSON.stringify(body) : undefined });
  return { status: res.status, body: await res.json(), cookie: res.headers.get('set-cookie')?.split(';')[0] };
}
before(async () => {
  const app = createApp({ dbPath: ':memory:', demo: true });
  server = app.listen(0, '127.0.0.1'); await new Promise(resolve => server.once('listening', resolve));
  base = `http://127.0.0.1:${server.address().port}/api`;
  admin = (await request('/auth/login', 'POST', { email: 'admin@vinhenglish.vn', password: 'Admin@123456' })).cookie;
  student = (await request('/auth/login', 'POST', { email: 'hocvien@example.com', password: 'Student@123456' })).cookie;
});
after(() => new Promise(resolve => server.close(resolve)));
test('catalog exposes six courses without private student data', async () => {
  const r = await request('/catalog'); assert.equal(r.status, 200); assert.equal(r.body.courses.length, 6); assert.equal(r.body.users, undefined);
});
test('admin routes reject guests and students', async () => {
  assert.equal((await request('/admin/overview')).status, 401);
  assert.equal((await request('/admin/overview', 'GET', null, student)).status, 403);
});
test('login rejects invalid credentials and logout revokes the session', async () => {
  assert.equal((await request('/auth/login', 'POST', { email: 'admin@vinhenglish.vn', password: 'wrong' })).status, 401);
  const login = await request('/auth/login', 'POST', { email: 'hocvien@example.com', password: 'Student@123456' });
  await request('/auth/logout', 'POST', {}, login.cookie);
  assert.equal((await request('/student', 'GET', null, login.cookie)).status, 401);
});
test('registration persists, rejects invalid data and duplicates', async () => {
  assert.equal((await request('/enrollments', 'POST', { name: 'A' })).status, 400);
  const payload = { name: 'Học viên kiểm thử', email: 'test@example.com', phone: '0901234567', birthday: '2000-01-01', classId: 2, note: '' };
  const r = await request('/enrollments', 'POST', payload); assert.equal(r.status, 201);
  assert.equal((await request('/enrollments', 'POST', payload)).status, 409);
  const rows = await request('/admin/enrollments', 'GET', null, admin);
  assert.ok(rows.body.some(row => row.id === r.body.id));
});
test('placement hides answers and requires a complete valid submission', async () => {
  const questions = (await request('/questions')).body; assert.equal(questions.length, 15); assert.equal(questions[0].answer, undefined);
  assert.equal((await request('/placement', 'POST', { answers: {} })).status, 400);
  const answers = Object.fromEntries(questions.map(q => [q.id, 0]));
  const r = await request('/placement', 'POST', { answers }); assert.equal(r.status, 200); assert.equal(r.body.total, 15); assert.ok(r.body.score >= 0 && r.body.score <= 15); assert.ok(r.body.courseId);
});
test('course CRUD validates and preserves foreign key relationships', async () => {
  const input = { name: 'Khóa kiểm thử', category: 'Giao tiếp', level: 'A2', duration: 12, tuition: 2500000, description: 'Khóa học dành cho kiểm thử dữ liệu.', image: '/images/adults.jpg', lessons: 24, audience: 'Người lớn', material: 'Bài tập ôn tập' };
  const created = await request('/admin/courses', 'POST', input, admin); assert.equal(created.status, 201);
  const id = created.body.id;
  assert.equal((await request(`/admin/courses/${id}`, 'PATCH', { tuition: -1 }, admin)).status, 400);
  assert.equal((await request(`/admin/courses/${id}`, 'PATCH', { name: 'Đã cập nhật' }, admin)).status, 200);
  assert.equal((await request(`/admin/courses/${id}`, 'DELETE', null, admin)).status, 200);
  assert.equal((await request('/admin/courses/1', 'DELETE', null, admin)).status, 409);
});
test('student data is scoped to the current account', async () => {
  const r = await request('/student', 'GET', null, student); assert.equal(r.status, 200); assert.ok(r.body.enrollments.every(e => e.userId === r.body.user.id)); assert.equal(r.body.user.passwordHash, undefined);
});
test('cross-origin writes are refused', async () => {
  const r = await fetch(base + '/contact', { method: 'POST', headers: { Origin: 'https://untrusted.example', 'Content-Type': 'application/json' }, body: '{}' }); assert.equal(r.status, 403);
});
