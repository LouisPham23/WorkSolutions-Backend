const express = require("express");

const router = express.Router();
const con = require("../connection");

router.get("/", (req, res) => {
  con.query("SELECT * FROM heroku_4626acc8b075c22.persons", (err, rows) => {
    if (err) throw err;
    res.send(rows);
  });
});

router.get("/:id", (req, res) => {
  con.query(
    "SELECT * FROM heroku_4626acc8b075c22.persons where PersonID = ?",
    [req.params.id],
    (err, rows, results) => {
      if (err) throw err;
      res.send(rows);
    }
  );
});

router.post("/", (req, res) => {
  const { id, first, last, address, city } = req.body;

  con.query(
    `Insert into heroku_4626acc8b075c22.persons values (${id}, '${first}', '${last}', '${address}', '${city}')`,
    (err, result) => {
      if (err) {
        res.send(err).status(400);
      } else {
        res.json({ message: "added user" }).status(200);
      }
    }
  );
});

router.delete("/", (req, res) => {
  con.query(
    `Delete from heroku_4626acc8b075c22.persons where PersonID = ${req.body.id}`,
    (err, result) => {
      if (err) {
        res.send(err);
      } else {
        res.json({ message: "deleted user" });
      }
    }
  );
});

module.exports = router;
