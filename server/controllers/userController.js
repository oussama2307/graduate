const User = require("../models/User");
const path = require("path");
const crypto = require("crypto");
const mv = require("mv");
// User controller
const UserController = {
  register: (req, res) => {
    const { username, name, password } = req.body;

    if (!username || !name || !password) {
      return res.status(400).send("Missing required fields");
    }
    User.getById({ username }, (error, results, fields) => {
      if (error) {
        console.error(error);
        return res.status(500).json({ error: "Internal server error" });
      }

      if (results.length > 0) {
        return res
          .status(409)
          .json({ message: "Nom d'utilisateur déjà existant" });
      } else {
        User.create({ username, name, password }, (err, result) => {
          if (err) {
            console.error(err);
            res.status(500).send("Error during registration");
          } else {
            res.status(200).json({
              message: "Registration successful",
              user: {
                userID: result.insertId,
                username: username,
                name: name,
                password: password,
                profile_picture: null,
                city: null,
              },
            });
            console.log({
              message: "Registration successful",
              user: {
                userID: result.insertId,
                username: username,
                name: name,
                password: password,
                profile_picture: null,
                city: null,
              },
            });
          }
        });
      }
    });
  },
  /************************************************************************* */
  login: (req, res) => {
    const { username, password } = req.body;

    if (!username || !password) {
      return res.status(400).json({ message: "Missing username or password" });
    }
    User.getbyusernamePassword({ username, password }, (err, result) => {
      if (err) {
        console.log(err);
        res.status(500).json({ message: "internal server error" });
      } else {
        if (result.length > 0) {
          res.status(200).json({ message: "user loged in ", user: result[0] });
          console.log({ message: "succes", User: result[0] });
        } else {
          res
            .status(404)
            .json({ message: "Nom d'utilisateur ou mot de passe incorrect" });
        }
      }
    });
  },
  /********************************************************************** */
  update: (req, res) => {
    const { id, Name, password, city } = req.body;
    User.update({ id, Name, password, city }, (err, result) => {
      if (err) {
        console.log(err);
        res.status(500).json({ message: "internal server error" });
      } else {
        res.status(200).json({
          message: "Mettre a jour",
          user: {
            userID: id,
            name: Name,
            password: password,
            city: city,
          },
        });
        console.log({
          message: "Mettre a jour",
          user: {
            userID: id,
            name: Name,
            password: password,
            city: city,
          },
        });
      }
    });
  },
  /****************************************************************** */
  updatepfp: (req, res) => {
    const file = req.file;
    const userId = req.body.userId;

    if (!file) {
      return res.status(400).send("No profile picture uploaded");
    }

    const extension = path.extname(file.originalname); // Get the file extension
    const newFilename = `${userId}_${crypto
      .randomBytes(16)
      .toString("hex")}${extension}`; // Generate a unique filename
    const newFilePath = path.join("uploads", newFilename); // Construct the new file path

    mv(file.path, newFilePath, (err) => {
      if (err) {
        console.error("Error moving file:", err);
        return res.status(500).send("Error uploading profile picture");
      }

      const profilePictureUrl = `/uploads/${newFilename}`; // Construct the URL to be stored in the database

      User.changepfp({ userId, profilePictureUrl }, (err, result) => {
        if (err) {
          console.error("Error updating profile picture path:", err);
          res.status(500).send("Error uploading profile picture");
        } else {
          res.status(200).send(profilePictureUrl);
          console.log(profilePictureUrl);
        }
      });
    });
  },
};

module.exports = UserController;
