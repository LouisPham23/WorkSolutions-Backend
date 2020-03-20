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

app.listen(process.env.PORT, () => {
  console.log("Listening on port 3000");
});
