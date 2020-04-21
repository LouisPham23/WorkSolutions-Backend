const express = require("express");

const router = express.Router();
const con = require("../connection");

router.get("/", (req, res) => {
  con.query("SELECT * FROM TICKET", (err, rows) => {
    if (err) throw err;
    res.send(rows);
  });
});

router.get("/:id", (req, res) => {
  con.query(
    "SELECT * FROM TICKET WHERE Ticket_number = ?",
    req.params.id,
    (err, rows) => {
      if (err) throw err;
      res.send(rows);
    }
  );
});

router.post("/", (req, res) => {
  console.log(req.body);
  con.query("INSERT INTO TICKET SET ?", [req.body], (err, result) => {
    if (err) {
      res.send(err).status(400);
    } else {
      res.send(result).status(200);
    }
  });
});

module.exports = router;
