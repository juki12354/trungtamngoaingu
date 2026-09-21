import { createApp } from "./app.js";
const port = Number(process.env.PORT || 3001);
const app = createApp({
  ...(process.env.DB_PATH ? { dbPath: process.env.DB_PATH } : {}),
});
const server = app.listen(port, "127.0.0.1", () =>
  console.log(`Vinh English API: http://127.0.0.1:${port}`),
);
function stop() {
  server.close(() => {
    app.locals.db.close();
    process.exit();
  });
}
process.on("SIGINT", stop);
process.on("SIGTERM", stop);
