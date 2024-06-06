const Post = require("../models/Postmodel");
const { update } = require("./userController");

/*************************************************** */
const postController = {
  create: (req, res) => {
    const { userID, type, service, description, price } = req.body;

    // Insert post data into the "Posts" table
    Post.createPost(
      { userID, type, service, description, price },
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
            Post.uploadImages(postId, imageUrl, (err) => {
              if (err) {
                console.error(err);
                reject(err);
              } else {
                resolve();
              }
            });
          });
        });

        Promise.all(imageInsertions)
          .then(() => {
            console.log("post created");
            return res.status(200).json({ message: "post added successfully" });
          })
          .catch((err) => {
            console.error(err);
            return res.status(500).json({ error: "Error storing images" });
          });
      }
    );
  },
  /************************************************************* */
  fetch: (req, res) => {
    Post.fetchPosts("no", (err, results) => {
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
          disponibilité,
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
            disponibilité,
            userName: name,
            userProfilePicture: profile_picture,
            images: [image],
          });
        }

        return acc;
      }, []);

      res.json(posts);
    });
  },
  /************************************************************* */
  fetch_user_posts: (req, res) => {
    const id = req.query.id;
    Post.fetchuserPosts(id, (err, results) => {
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
          disponibilité,
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
            disponibilité,
            userName: name,
            userProfilePicture: profile_picture,
            images: [image],
          });
        }

        return acc;
      }, []);

      res.json(posts);
    });
  },
  /**************************************************** */
  deleteposts: (req, res) => {
    const postId = req.params.postId;
    const userId = req.body.userId; // Assuming userId is provided in the request body

    console.log(
      `Received request to delete post with ID ${postId} by user with ID ${userId}`
    );

    // Check if the post belongs to the user
    Post.checkingownership({ userId, postId }, (err, results) => {
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
      Post.deleteimages(postId, (err, results) => {
        if (err) {
          console.error("Error deleting images:", err);
          return res.status(500).send("Internal server error");
        }

        console.log(`Deleted images associated with post ID ${postId}`);

        // Delete the post
        Post.deleteposts(postId, (err, results) => {
          if (err) {
            console.error("Error deleting post:", err);
            return res.status(500).send("Internal server error");
          }

          console.log(`Deleted post with ID ${postId}`);
          res.status(200).json({
            message: "Post and associated images deleted successfully",
          });
        });
      });
    });
  },
  /***************************************************** */
  update: (req, res) => {
    const { post_id, type, service, description, price, disponibilité } =
      req.body;

    Post.updatepost(
      { post_id, type, service, description, price, disponibilité },
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
  },
};

module.exports = postController;
