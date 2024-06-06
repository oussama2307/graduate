const express = require("express");
const cors = require("cors");
const path = require("path");
const router = express.Router();
const db = require("./database");
const userRoutes = require("./routes/userRoutes");
const postRoutes = require("./routes/postRoutes");
const favoriteRoutes = require("./routes/favoriteRoutes");

const app = express();

const PORT = 3000;

app.use("/uploads", express.static(path.join(__dirname, "uploads")));
app.use("/post_uploads", express.static(path.join(__dirname, "post_uploads")));
app.use(cors());
app.use(express.json());
app.use(userRoutes);
app.use(postRoutes);
app.use(favoriteRoutes);

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
