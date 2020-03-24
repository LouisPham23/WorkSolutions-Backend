const express = require("express");

const router = express.Router();
const con = require("../connection");

router.get("/", (req, res) => {
  con.query("SELECT * FROM ticket", (err, rows) => {
    if (err) throw err;
    res.send(rows);
  });
});

module.exports = router;
