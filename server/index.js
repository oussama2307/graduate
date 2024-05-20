const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");
const multer = require("multer");
const path = require("path");
const crypto = require("crypto");
const mv = require("mv");
const router = express.Router();

const app = express();
const upload = multer({ dest: "uploads/" });
const PORT = 3000;
app.use("/uploads", express.static(path.join(__dirname, "uploads")));
app.use("/post_uploads", express.static(path.join(__dirname, "post_uploads")));
app.use(cors());

// Create MySQL connection
const db = mysql.createPool({
  host: "localhost",
  user: "root",
  password: "root",
  database: "memoire",
});

app.use(express.json());

///////////////////////////////////////////////////////
app.post(
  "/upload-profile-picture",
  upload.single("profilePicture"),
  (req, res) => {
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

    // Move the uploaded file to the new file path

    mv(file.path, newFilePath, (err) => {
      if (err) {
        console.error("Error moving file:", err);
        return res.status(500).send("Error uploading profile picture");
      }

      const profilePictureUrl = `/uploads/${newFilename}`; // Construct the URL to be stored in the database

      const query = "UPDATE Users SET profile_picture = ? WHERE userID = ?";
      db.query(query, [profilePictureUrl, userId], (err, result) => {
        if (err) {
          console.error("Error updating profile picture path:", err);
          res.status(500).send("Error uploading profile picture");
        } else {
          res.status(200).send(profilePictureUrl);
          console.log(profilePictureUrl);
        }
      });
    });
  }
);
/////////////////////////////////////////////////////////

app.post("/register", async (req, res) => {
  const { username, name, password } = req.body;

  if (!username || !name || !password) {
    return res.status(400).send("Missing required fields");
  }
  const query = "SELECT * FROM Users WHERE username = ?";
  db.query(query, [username], (error, results, fields) => {
    if (error) {
      console.error(error);
      return res.status(500).json({ error: "Internal server error" });
    }

    if (results.length > 0) {
      return res
        .status(409)
        .json({ message: "Nom d'utilisateur déjà existant" });
    } else {
      const sql = `
      INSERT INTO Users (username, name, password)
      VALUES (?, ?, ?);
      `;
      const values = [username, name, password];

      db.query(sql, values, (err, result) => {
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
});
/*********************************************************************** */
app.post("/login", async (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ message: "Missing username or password" });
  }
  db.query(
    "select * from Users WHERE username = ? AND password = ?",
    [username, password],
    (err, result) => {
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
    }
  );
});
/******************************************************************************** */
app.post("/update", async (req, res) => {
  const { id, Name, password, city } = req.body;

  db.query(
    "UPDATE Users SET name = ?, password = ?, city = ? WHERE userID = ?",
    [Name, password, city, id],
    (err, result) => {
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
    }
  );
});

/******************************************************************* */
const storage = multer.diskStorage({
  destination: "post_uploads/",
  filename: (req, file, cb) => {
    cb(null, `${Date.now()}-${file.originalname}`);
  },
});
const uploading = multer({ storage });

// POST /api/posts
app.post(
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
  (req, res) => {
    const { userID, type, service, description, price } = req.body;

    // Insert post data into the "Posts" table
    db.query(
      "INSERT INTO Posts (user_id, type, service, description, price) VALUES (?, ?, ?, ?, ?)",
      [userID, type, service, description, price],
      (err, result) => {
        if (err) {
          console.error(err);
          return res.status(500).json({ error: "Error creating post" });
        }

        const postId = result.insertId;

        let imageUrls = [];
        if (req.files) {
          imageUrls = req.files.map((file) => `/post_uploads/${file.filename}`);
        }

        // Build the response object

        // Insert the post images
        const imageInsertions = imageUrls.map((imageUrl) => {
          return new Promise((resolve, reject) => {
            db.query(
              "INSERT INTO post_images (post_id, image) VALUES (?, ?)",
              [postId, imageUrl],
              (err) => {
                if (err) {
                  console.error(err);
                  reject(err);
                } else {
                  resolve();
                }
              }
            );
          });
        });

        Promise.all(imageInsertions)
          .then(() => {
            console.log("post created");
            return res.status(200).json({ message: "post added succeffuly" });
          })
          .catch((err) => {
            console.error(err);
            return res.status(500).json({ error: "Error storing images" });
          });
      }
    );
  }
);
/***************************************************************** */
app.get("/posts", (req, res) => {
  const query = `
    SELECT p.*, u.name, u.profile_picture, i.image
    FROM Posts p
    JOIN Users u ON p.user_id = u.userID
    LEFT JOIN post_images i ON p.post_id = i.post_id
    ORDER BY p.created_at DESC
  `;

  db.query(query, (err, results) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ error: "Internal server error" });
    }

    const posts = results.reduce((acc, row) => {
      const {
        post_id,
        user_id,
        created_at,
        type,
        service,
        description,
        price,
        name,
        profile_picture,
        image,
      } = row;
      const post = acc.find((p) => p.post_id === post_id);

      if (post) {
        post.images.push(image);
      } else {
        acc.push({
          post_id,
          user_id,
          created_at,
          type,
          service,
          description,
          price,
          userName: name,
          userProfilePicture: profile_picture,
          images: [image],
        });
      }

      return acc;
    }, []);

    res.json(posts);
  });
});
/*************************************************** */

app.get("/user_posts", async (req, res) => {
  const id = req.query.id;
  const query = `
    SELECT p.*, u.name, u.profile_picture, i.image    
    FROM Posts p
    JOIN Users u ON p.user_id = u.userID AND u.userID = ?
    LEFT JOIN post_images i ON p.post_id = i.post_id
    ORDER BY p.created_at DESC
  `;

  db.query(query, [id], (err, results) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ error: "Internal server error" });
    }

    const posts = results.reduce((acc, row) => {
      const {
        post_id,
        user_id,
        created_at,
        type,
        service,
        description,
        price,
        name,
        profile_picture,
        image,
      } = row;
      const post = acc.find((p) => p.post_id === post_id);

      if (post) {
        post.images.push(image);
      } else {
        acc.push({
          post_id,
          user_id,
          created_at,
          type,
          service,
          description,
          price,
          userName: name,
          userProfilePicture: profile_picture,
          images: [image],
        });
      }

      return acc;
    }, []);

    res.json(posts);
  });
});
/********************************************************************* */
app.get("/favorites", (req, res) => {
  const userID = req.query.userID;
  const query = `
  SELECT
    f.id AS favorite_id,
    f.post_id,
    p.type,
    p.service,
    p.description,
    p.price,
    p.created_at,
    u.name,
    u.profile_picture,
    pi.image
  FROM
    favorite f
  JOIN
    Posts p ON f.post_id = p.post_id
  JOIN
    Users u ON p.user_id = u.userID
  LEFT JOIN
    post_images pi ON p.post_id = pi.post_id
  WHERE
    f.user_id = ?
  ORDER BY p.created_at DESC;
  `;

  db.query(query, [userID], (err, results) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ error: "Internal server error" });
    }

    const favorites = results.reduce((acc, row) => {
      const {
        favorite_id,
        post_id,
        type,
        service,
        description,
        price,
        created_at,
        name,
        profile_picture,

        image,
      } = row;
      const post = acc.find((p) => p.post_id === post_id);

      if (post) {
        post.images.push(image);
      } else {
        acc.push({
          favorite_id,
          post_id,
          type,
          service,
          description,
          price,
          created_at,
          userName: name,
          userProfilePicture: profile_picture,

          images: [image],
        });
      }

      return acc;
    }, []);

    res.json(favorites);
  });
});
/****************************************************************** */
// Delete post endpoint
app.delete("/posts/:postId", (req, res) => {
  const postId = req.params.postId;
  const userId = req.body.userId; // Assuming userId is provided in the request body

  console.log(
    `Received request to delete post with ID ${postId} by user with ID ${userId}`
  );

  // Check if the post belongs to the user
  const checkPostOwnershipQuery =
    "SELECT * FROM Posts WHERE post_id = ? AND user_id = ?";
  db.query(checkPostOwnershipQuery, [postId, userId], (err, results) => {
    if (err) {
      console.error("Error querying the database:", err);
      return res.status(500).send("Internal server error");
    }

    if (results.length === 0) {
      console.log(
        `Post with ID ${postId} not found or does not belong to user with ID ${userId}`
      );
      return res
        .status(404)
        .send(
          "Post not found or you do not have permission to delete this post"
        );
    }

    console.log(`Post with ID ${postId} verified for user with ID ${userId}`);

    // Delete images associated with the post
    const deleteImagesQuery = "DELETE FROM post_images WHERE post_id = ?";
    db.query(deleteImagesQuery, [postId], (err, results) => {
      if (err) {
        console.error("Error deleting images:", err);
        return res.status(500).send("Internal server error");
      }

      console.log(`Deleted images associated with post ID ${postId}`);

      // Delete the post
      const deletePostQuery = "DELETE FROM Posts WHERE post_id = ?";
      db.query(deletePostQuery, [postId], (err, results) => {
        if (err) {
          console.error("Error deleting post:", err);
          return res.status(500).send("Internal server error");
        }

        console.log(`Deleted post with ID ${postId}`);
        res
          .status(200)
          .json({ message: "Post and associated images deleted successfully" });
      });
    });
  });
});
/************************************************************************* */
app.post("/update_post", async (req, res) => {
  const { post_id, type, service, description, price, disponibilité } =
    req.body;

  db.query(
    "UPDATE Posts SET type = ?, service = ?, description = ? , price = ? , disponibilité = ? WHERE post_id = ?",
    [type, service, description, price, disponibilité, post_id],
    (err, result) => {
      if (err) {
        console.log(err);
        res.status(500).json({ message: "internal server error" });
      } else {
        res.status(200).json({
          message: "Mettre a jour",
        });
        console.log({
          message: "Mettre a jour",
        });
      }
    }
  );
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
