const mysql = require("mysql");
require("dotenv").config();

const connect_str = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_SCHEMA
});

connect_str.connect(err => {
  if (err) {
    console.log(err);
  } else {
    console.log("Connected");
  }
});

module.exports = connect_str;
