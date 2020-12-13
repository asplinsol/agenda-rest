
const settings = require("./settings");

const { app, agenda } = require("./dist");

const server = app.listen(settings.port, () => {
  console.log(`App listening on port ${settings.port}.`);
});

async function graceful() {
  console.log("\nClosing server...");
  await server.close();
  console.log("Shutting down gracefully...");
  await agenda.stop();
  process.exit(0);
}

process.on("SIGTERM", graceful);
process.on("SIGINT", graceful);
