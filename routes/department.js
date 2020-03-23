const express = require("express");

const router = express.Router();
const con = require("../connection");

router.get("/", (req, res) => {
  con.query("SELECT * FROM department", (err, rows) => {
    if (err) throw err;
    res.send(rows);
  });
});

router.get("/:id", (req, res) => {
  con.query(
    "SELECT * FROM department where Department_id = ?",
    [req.params.id],
    (err, row, fields, result) => {
      if (err) throw err;
      res.send(row, fields, result);
    }
  );
});

router.post("/", (req, res) => {
  const department = req.body;
  con.query("INSERT INTO department SET ? ", department, (err, result) => {
    if (err) {
      res.send(err).status(400);
    } else {
      res.send(result).status(200);
    }
  });
});

//Put: you need to send in all of the information for that row, where Patch: need to send the updated information only

router.patch("/", async (req, res) => {
  const dep_id = req.body.Department_id;
  const updated_dep = req.body;
  // const updated_dep = {
  //   Department_id: 2,
  //   Location: "Vacaville"
  // };
  let statement = con.query(
    `UPDATE deparment SET Location = ? where Department_id = ${dep_id}`,
    updated_dep,
    (err, result) => {
      if (err) throw err;
      res.send(result).status(200);
    }
  );
  console.log(statement.sql);
});

module.exports = router;
