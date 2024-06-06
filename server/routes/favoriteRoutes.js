const express = require("express");
const router = express.Router();
const favoriteController = require("../controllers/favoriteController");

router.get("/favorites", favoriteController.fetch_user_favorites);
router.post("/upload_favorite", favoriteController.upload);

module.exports = router;
