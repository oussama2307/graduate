const express = require("express");
const router = express.Router();
const postController = require("../controllers/postController");
const multer = require("multer");

const storage = multer.diskStorage({
  destination: "post_uploads/",
  filename: (req, file, cb) => {
    cb(null, `${Date.now()}-${file.originalname}`);
  },
});
const uploading = multer({ storage });

router.post(
  "/api/posts",
  (req, res, next) => {
    uploading.array("images[]", 10)(req, res, (err) => {
      if (err) {
        if (err.code === "LIMIT_UNEXPECTED_FILE") {
          // No images were provided, continue to the next middleware
          next();
        } else {
          // Handle other errors
          return res.status(500).json({ error: "Error uploading images" });
        }
      } else {
        // Images were provided, continue to the next middleware
        next();
      }
    });
  },
  postController.create
);

router.get("/posts", postController.fetch);
router.get("/user_posts", postController.fetch_user_posts);
router.delete("/posts/:postId", postController.deleteposts);
router.post("/update_post", postController.update);
module.exports = router;
