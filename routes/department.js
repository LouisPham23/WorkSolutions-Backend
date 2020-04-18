const express = require("express");

const router = express.Router();
const con = require("../connection");

router.get("/", (req, res) => {
  con.query("SELECT * FROM DEPARTMENT", (err, rows) => {
    if (err) throw err;
    res.send(rows);
  });
});

router.get("/:id", (req, res) => {
  con.query(
    "SELECT * FROM DEPARTMENT where DEPARTMENT_id = ?",
    [req.params.id],
    (err, row, fields, result) => {
      if (err) throw err;
      res.send(row, fields, result);
    }
  );
});

router.post("/", (req, res) => {
  const DEPARTMENT = req.body;
  con.query("INSERT INTO DEPARTMENT SET ? ", DEPARTMENT, (err, result) => {
    if (err) {
      res.send(err).status(400);
    } else {
      res.send(req.body).status(200);
    }
  });
});

//Put: you need to send in all of the information for that row, where Patch: need to send the updated information only

router.put("/:id", (req, res) => {
  const dept_id = req.params.id;
  const { Name, Location, Acronym } = req.body;
  con.query(
    "UPDATE DEPARTMENT SET Name = ?, Location = ?, Acronym = ? WHERE Department_Id = ?",
    [Name, Location, Acronym, dept_id],
    (err, result) => {
      if (err) {
        res.send(err).status(400);
      } else {
        res.send(result).status(200);
      }
    }
  );
});

router.delete("/:id", (req, res) => {
  con.query(
    "DELETE FROM DEPARTMENT WHERE Department_Id = ?",
    req.params.id,
    (err, result) => {
      if (err) {
        res.send(err).status(400);
      } else {
        res.send(result).status(200);
      }
    }
  );
});

module.exports = router;
