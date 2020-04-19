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

module.exports = router;
