import { openDatabase } from "../server/db.js";
import { addPublicContent } from "../server/public-content.js";
const db = openDatabase(process.env.DB_PATH || "data/center.sqlite", false);
try {
  console.log(addPublicContent(db));
} finally {
  db.close();
}
