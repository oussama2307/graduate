const db = require("../database");

const favorite = {
  fetchfavorite: (userID, callback) => {
    db.query(
      `
        SELECT
          f.id AS favorite_id,
          f.post_id,
          p.type,
          p.service,
          p.description,
          p.price,
          p.disponibilité,
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
        `,
      [userID],
      (err, result) => {
        if (err) {
          callback(err, null);
        } else {
          callback(null, result);
        }
      }
    );
  },
  /************************************************ */
  uploadfavorite: (favoritedata, callback) => {
    const { user_id, post_id } = favoritedata;
    db.query(
      "INSERT into favorite (user_id,post_id) VALUES (?,?)",
      [user_id, post_id],
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

module.exports = favorite;
