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

router.patch("/", async (req, res) => {
  const dep_id = req.body.Department_id;

  con.query(
    `UPDATE deparment set Name = ?, Location = ?, Acronym = ? where Department_id = ${dep_id}`,
    req.body,
    (err, result) => {
      if (err) throw err;
      res.send(result).status(200);
    }
  );
});

module.exports = router;
