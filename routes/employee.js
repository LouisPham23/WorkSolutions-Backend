const express = require("express");

const router = express.Router();
const con = require("../connection");

router.get("/", (req, res) => {
  con.query("SELECT * FROM EMPLOYEE", (err, rows) => {
    if (err) throw err;
    res.send(rows);
  });
});

router.get("/:id", (req, res) => {
  con.query(
    "SELECT * FROM EMPLOYEE WHERE Employee_Id = ?",
    [req.params.id],
    (err, rows) => {
      if (err) throw err;
      res.send(rows);
    }
  );
});

router.post("/", (req, res) => {
  con.query("INSERT INTO EMPLOYEE SET ?", req.body, (err, result) => {
    if (err) {
      res.send(err).status(400);
    } else {
      res.send(result).status(200);
    }
  });
});

module.exports = router;
