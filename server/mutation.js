// Route handlers return a response value. Send it only after the transaction
// commits; failed writes roll back together and never report success.
export const mutation = (db, handler) => async (req, res) => {
  try {
    const result = await db.transaction(() => handler(req, res));
    res.status(result.status).json(result.body);
  } catch (error) {
    res.removeHeader("Set-Cookie");
    throw error;
  }
};
