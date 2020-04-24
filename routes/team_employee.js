const express = require("express");

const router = express.Router();
const con = require("../connection");

router.get("/", (req, res) => {
  con.query("CALL GetTeamsAndMembers()", (err, results, fields) => {
    if (err) {
      res.send(err).status(400);
    } else {
      res.send(results).status(200);
    }
  });
});

router.post("/", (req, res) => {
  con.query("INSERT INTO TEAM_EMPLOYEE SET ?", [req.body], (err, result) => {
    if (err) {
      res.send(err).status(400);
    } else {
      res.send(result).status(200);
    }
  });
});

module.exports = router;
