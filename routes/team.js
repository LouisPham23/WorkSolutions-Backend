const express = require("express");

const router = express.Router();
const con = require("../connection");

router.get("/", (req, res) => {
  con.query("SELECT * FROM TEAM", (err, rows) => {
    if (err) throw err;
    res.send(rows);
  });
});

router.get("/", (req, res) => {
  con.query("Call GetTeamsAndMembers", (err, rows) => {
    if (err) throw err;
    res.send(rows);
  });
});

module.exports = router;
