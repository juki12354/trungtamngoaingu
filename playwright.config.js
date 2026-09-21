import { defineConfig } from "@playwright/test";
import { mkdtempSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
const testDir = mkdtempSync(join(tmpdir(), "vinh-english-e2e-"));
export default defineConfig({
  testDir: "./tests/browser",
  workers: 1,
  timeout: 45000,
  use: {
    baseURL: "http://127.0.0.1:3002",
    browserName: "chromium",
    headless: true,
    screenshot: "only-on-failure",
    trace: "retain-on-failure",
  },
  webServer: {
    command: "node server/index.js",
    url: "http://127.0.0.1:3002/api/health",
    reuseExistingServer: false,
    env: { PORT: "3002", DB_PATH: join(testDir, "e2e.sqlite") },
  },
});
