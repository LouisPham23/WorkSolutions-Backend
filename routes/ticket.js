const router = require("express").Router();
const con = require("../connection");

router.get("/", (req, res) => {
  con.query("SELECT * FROM heroku_4626acc8b075c22.ticket", (err, rows) => {
    if (err) throw err;
    res.send(rows);
  });
});

module.exports = router;
