import express from "express";
import { logger } from "./lib/logger";

const app = express();

app.get("/", (req, res) => {
  logger.info("Received request");
  res.send("Hello World");
});

app.listen(8080, () => console.log("App listening on port 8080"));
