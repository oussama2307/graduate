const favorite = require("../models/Favoritemodel");

const favoriteController = {
  fetch_user_favorites: (req, res) => {
    const userID = req.query.userID;
    favorite.fetchfavorite(userID, (err, results) => {
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
          disponibilité,
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
            disponibilité,
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
  },
  /*************************************************** */
  upload: (req, res) => {
    const { user_id, post_id } = req.body;
    favorite.uploadfavorite({ user_id, post_id }, (err, result) => {
      if (err) {
        res.status(500).send("Internal server error");
      }
      res.status(200).json({ message: "favorite uploaded successfully" });
    });
  },
};

module.exports = favoriteController;
