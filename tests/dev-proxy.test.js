import { test } from "node:test";
import assert from "node:assert/strict";
import { createServer } from "vite";
import { createApp } from "./helpers/app.js";
import config from "../vite.config.js";
import { mkdtempSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";

test("development proxy preserves origin checks for browser login", async () => {
  const app = await createApp({ dbPath: ":memory:", demo: true });
  const backend = app.listen(0, "127.0.0.1");
  await new Promise((resolve) => backend.once("listening", resolve));
  const target = `http://127.0.0.1:${backend.address().port}`;
  const entry = config.server.proxy["/api"];
  const vite = await createServer({
    configFile: false,
    cacheDir: mkdtempSync(join(tmpdir(), "vec-vite-test-")),
    logLevel: "silent",
    server: {
      ...config.server,
      port: 0,
      proxy: {
        "/api": typeof entry === "string" ? target : { ...entry, target },
      },
    },
  });
  try {
    await vite.listen();
    const origin = `http://127.0.0.1:${vite.httpServer.address().port}`;
    const response = await fetch(`${origin}/api/auth/login`, {
      method: "POST",
      headers: { "Content-Type": "application/json", Origin: origin },
      body: JSON.stringify({
        email: "hocvien@example.com",
        password: "Student@123456",
      }),
    });
    assert.equal(response.status, 200);
    assert.equal((await response.json()).user.role, "student");
  } finally {
    await vite.close();
    await new Promise((resolve) => backend.close(resolve));
    await app.locals.db.close();
  }
});
