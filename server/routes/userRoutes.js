const express = require("express");
const multer = require("multer");
const router = express.Router();
const UserController = require("../controllers/userController");
const { required } = require("nodemon/lib/config");

// Register a new user
router.post("/register", UserController.register);

// User login
router.post("/login", UserController.login);

// Update user information
router.post("/update", UserController.update);
const upload = multer({ dest: "uploads/" });
router.post(
  "/upload-profile-picture",
  upload.single("profilePicture"),
  UserController.updatepfp
);

module.exports = router;
