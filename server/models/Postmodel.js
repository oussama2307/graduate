const db = require("../database");
const { update } = require("./User");

const Post = {
  createPost: (postData, callback) => {
    const { userID, type, service, description, price } = postData;
    db.query(
      "INSERT INTO Posts (user_id, type, service, description, price,disponibilité) VALUES (?, ?, ?, ?, ?,'Disponible')",
      [userID, type, service, description, price],
      (err, result) => {
        if (err) {
          callback(err, null);
        } else {
          callback(null, result);
        }
      }
    );
  },
  /************************************************************ */
  uploadImages: (postId, imageUrl, callback) => {
    db.query(
      "INSERT INTO post_images (post_id, image) VALUES (?, ?)",
      [postId, imageUrl],
      (err) => {
        if (err) {
          callback(err);
        } else {
          callback(null);
        }
      }
    );
  },
  /*********************************************************** */
  fetchPosts: (postdata, callback) => {
    const data = postdata;
    db.query(
      `
    SELECT p.*, u.name, u.profile_picture, i.image
    FROM Posts p
    JOIN Users u ON p.user_id = u.userID
    LEFT JOIN post_images i ON p.post_id = i.post_id
    ORDER BY p.created_at DESC
  `,
      (err, result) => {
        if (err) {
          callback(err, null);
        } else {
          callback(null, result);
        }
      }
    );
  },
  /****************************************************** */
  fetchuserPosts: (id, callback) => {
    db.query(
      `
    SELECT p.*, u.name, u.profile_picture, i.image    
    FROM Posts p
    JOIN Users u ON p.user_id = u.userID AND u.userID = ?
    LEFT JOIN post_images i ON p.post_id = i.post_id
    ORDER BY p.created_at DESC
  `,
      [id],
      (err, result) => {
        if (err) {
          callback(err, null);
        } else {
          callback(null, result);
        }
      }
    );
  },
  /********************************************************* */
  checkingownership: (data, callback) => {
    const { userId, postId } = data;
    db.query(
      "SELECT * FROM Posts WHERE post_id = ? AND user_id = ?",
      [postId, userId],
      (err, result) => {
        if (err) {
          callback(err, null);
        } else {
          callback(null, result);
        }
      }
    );
  },
  /********************************************************* */
  deleteimages: (id, callback) => {
    db.query(
      "DELETE FROM post_images WHERE post_id = ?",
      [id],
      (err, result) => {
        if (err) {
          callback(err, null);
        } else {
          callback(null, result);
        }
      }
    );
  },
  /****************************************************** */
  deleteposts: (id, callback) => {
    db.query("DELETE FROM Posts WHERE post_id = ?", [id], (err, result) => {
      if (err) {
        callback(err, null);
      } else {
        callback(null, result);
      }
    });
  },
  /********************************************************* */
  updatepost: (postData, callback) => {
    const { post_id, type, service, description, price, disponibilité } =
      postData;
    db.query(
      "UPDATE Posts SET type = ?, service = ?, description = ? , price = ? , disponibilité = ? WHERE post_id = ?",
      [type, service, description, price, disponibilité, post_id],
      (err, result) => {
        if (err) {
          callback(err, null);
        } else {
          callback(null, result);
        }
      }
    );
  },
};

module.exports = Post;
