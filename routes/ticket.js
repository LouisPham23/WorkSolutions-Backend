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
      console.log(result);
      res.send(result).status(200);
    }
  });
});

router.delete("/:id", (req, res) => {
  con.query(
    "DELETE FROM TICKET WHERE Ticket_number = ?",
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
//Put: you need to send in all of the information for that row, where Patch: need to send the updated information only

router.put("/:id", (req, res) => {
  const ticket_id = req.params.id;

  const {
    Ticket_type,
    Priority,
    Status_Id,
    Title,
    Assigned_To,
    Deadline_Date,
    Description,
  } = req.body;

  let d = con.query(
    "UPDATE TICKET SET Ticket_type = ?, Priority = ?, Status_Id = ?, Title = ?, Assigned_To = ?, Deadline_Date = ?, Description = ? WHERE Ticket_number = ?",
    [
      Ticket_type,
      Priority,
      Status_Id,
      Title,
      Assigned_To,
      Deadline_Date,
      Description,
      ticket_id,
    ],
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
