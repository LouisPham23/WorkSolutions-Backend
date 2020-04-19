const express = require("express");
const app = express();
const con = require("./connection");
const cors = require("cors");
const morgan = require("morgan");

app.use(
  cors({
    // origin: "http://localhost:3000/",
    methods: "GET,HEAD,PUT,PATCH,POST,DELETE",
  })
);

app.use(morgan("common"));

app.use(express.json());

app.get("/", (req, res) => {
  res.send({ data: "this server is working" });
});

const ticket_route = require("./routes/ticket");
app.use("/ticket", ticket_route);

const department_route = require("./routes/department");
app.use("/department", department_route);

const team_route = require("./routes/team");
app.use("/team", team_route);

const employee_route = require("./routes/employee");
app.use("/employee", employee_route);

app.listen(process.env.PORT, () => {
  console.log(`Listening on port: ${process.env.PORT}`);
});
