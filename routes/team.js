const express = require("express");

const router = express.Router();
const con = require("../connection");

router.get("/", (req, res) => {
  con.query("CALL GetTeamsAndMembers;", (err, rows) => {
    if (err) throw err;
    res.send(rows);
  });
});

router.get("/:id", (req, res) => {
  con.query(
    `SELECT Team_name, TE.Team_Id, E.First_name, E.Last_name
      FROM TEAM_EMPLOYEE TE 
        JOIN EMPLOYEE E ON E.Employee_Id = TE.Employee_Id
        JOIN TEAM T ON TE.Team_Id = T.Team_Id
        WHERE TE.Team_Id = ?`,
    req.params.id,
    (err, rows) => {
      if (err) throw err;
      res.send(rows);
    }
  );
});

router.post("/", (req, res) => {
  con.query("INSERT INTO TEAM SET ?", req.body, (err, result) => {
    if (err) {
      res.send(err).status(400);
    } else {
      res.send(result).status(200);
    }
  });
});

router.delete("/", (req, res) => {
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
