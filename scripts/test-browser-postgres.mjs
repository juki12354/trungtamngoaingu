import { spawn } from "node:child_process";
import { databaseFixture } from "../tests/helpers/app.js";
if (!process.env.TEST_DATABASE_URL)
  throw new Error(
    "TEST_DATABASE_URL must point to a disposable PostgreSQL test server.",
  );
const fixture = await databaseFixture();
try {
  const child = spawn(
    process.execPath,
    ["node_modules/@playwright/test/cli.js", "test"],
    {
      env: { ...process.env, E2E_DATABASE_URL: fixture.url },
      stdio: "inherit",
      windowsHide: true,
    },
  );
  const code = await new Promise((resolve, reject) => {
    child.once("error", reject);
    child.once("exit", resolve);
  });
  process.exitCode = code ?? 1;
} finally {
  await fixture.close();
}
