const express = require("express");
const app = express();
const con = require("./connection");

require("dotenv").config();

app.use(express.json());

app.get("/", (req, res) => {
  res.send({ data: "this server is working" });
});

//This route is only for testing
const person_route = require("./routes/person");
app.use("/person", person_route);

// const ticket_route = require("./routes/ticket");
// app.use("/ticket", ticket_route);

app.get("/ticket", (req, res) => {
  res.send("ticket route");
});
app.listen(process.env.PORT, () => {
  console.log("Listening on port 3000");
});
