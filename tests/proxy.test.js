import { test } from "node:test";
import assert from "node:assert/strict";
import { createApp } from "./helpers/app.js";

for (const trustProxy of [1, false]) {
  test(`login rate limits respect the configured proxy boundary (${trustProxy})`, async () => {
    const app = await createApp({
      dbPath: ":memory:",
      demo: false,
      trustProxy,
    });
    const server = app.listen(0, "127.0.0.1");
    await new Promise((resolve) => server.once("listening", resolve));
    const attempt = (forwarded) =>
      fetch(`http://127.0.0.1:${server.address().port}/api/auth/login`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-Forwarded-For": forwarded,
        },
        body: JSON.stringify({
          email: "absent@example.com",
          password: "Wrong-password-2026",
        }),
      });
    try {
      for (let n = 0; n < 40; n++) {
        const response = await attempt("192.0.2.1");
        assert.equal(response.status, 401);
        await response.arrayBuffer();
      }
      const blocked = await attempt("192.0.2.1");
      assert.equal(blocked.status, 429);
      await blocked.arrayBuffer();
      // A caller cannot evade the limit by prepending an untrusted IP.
      const spoofed = await attempt("198.51.100.7, 192.0.2.1");
      assert.equal(spoofed.status, 429);
      await spoofed.arrayBuffer();
      const differentUser = await attempt("192.0.2.2");
      assert.equal(differentUser.status, trustProxy ? 401 : 429);
      await differentUser.arrayBuffer();
    } finally {
      await new Promise((resolve) => server.close(resolve));
      await app.locals.db.close();
    }
  });
}
