// models/user.model.js
const db = require("../database");

const User = {
  getById: (username, callback) => {
    db.query(
      "SELECT * FROM Users WHERE username = ?",
      [username],
      (err, results) => {
        if (err) {
          callback(err, null);
        } else {
          callback(null, results);
        }
      }
    );
  },
  /************************************************************** */
  create: (userData, callback) => {
    const { username, name, password } = userData;
    db.query(
      `
    INSERT INTO Users (username, name, password)
    VALUES (?, ?, ?);
    `,
      [username, name, password],
      (err, result) => {
        if (err) {
          callback(err, null);
        } else {
          callback(null, result);
        }
      }
    );
  },
  /*************************************************************** */
  getbyusernamePassword: (userdata, callback) => {
    const { username, password } = userdata;
    db.query(
      "select * from Users WHERE username = ? AND password = ?",
      [username, password],
      (err, result) => {
        if (err) {
          callback(err, null);
        } else {
          callback(null, result);
        }
      }
    );
  },
  /**************************************************************** */
  update: (updatedData, callback) => {
    const { id, Name, password, city } = updatedData;

    db.query(
      "UPDATE Users SET name = ?, password = ?, city = ? WHERE userID = ?",
      [Name, password, city, id],
      (err, result) => {
        if (err) {
          callback(err, null);
        } else {
          callback(null, result);
        }
      }
    );
  },
  /**************************************************************** */
  changepfp: (pfpdata, callback) => {
    const { id, imageurl } = pfpdata;
    db.query(
      "UPDATE Users SET profile_picture = ? WHERE userID = ?",
      [id, imageurl],
      (err, result) => {
        if (err) {
          callback(err);
        } else {
          callback(null);
        }
      }
    );
  },
};

module.exports = User;
