const express = require("express");
const app = express();
const con = require("./connection");
const cors = require("cors");

require("dotenv").config();

app.use(
  cors({
    origin: "http://localhost:3000/",
    methods: "GET,HEAD,PUT,PATCH,POST,DELETE"
  })
);
app.use(express.json());

app.get("/", (req, res) => {
  res.send({ data: "this server is working" });
});

//This route is only for testing
const person_route = require("./routes/person");
app.use("/person", person_route);

const ticket_route = require("./routes/ticket");
app.use("/ticket", ticket_route);

const department_route = require("./routes/department");
app.use("/department", department_route);

app.listen(process.env.PORT, () => {
  console.log(`Listening on port: ${process.env.PORT}`);
});
