const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");
const multer = require("multer");
const path = require("path");
const crypto = require("crypto");
const mv = require("mv");


const app = express();
const upload = multer({ dest: 'uploads/' });
const PORT = 3000;
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));
app.use(cors());

// Create MySQL connection
const db = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: 'root',
  database: 'memoire'
});

app.use(express.json());

///////////////////////////////////////////////////////
app.post('/upload-profile-picture', upload.single('profilePicture'), (req, res) => {
  const file = req.file;
  const userId = req.body.userId;

  if (!file) {
    return res.status(400).send('No profile picture uploaded');
  }

  const extension = path.extname(file.originalname); // Get the file extension
  const newFilename = `${userId}_${crypto.randomBytes(16).toString('hex')}${extension}`; // Generate a unique filename
  const newFilePath = path.join('uploads', newFilename); // Construct the new file path

  // Move the uploaded file to the new file path
  
  mv(file.path, newFilePath, (err) => {
    if (err) {
      console.error('Error moving file:', err);
      return res.status(500).send('Error uploading profile picture');
    }

    const profilePictureUrl = `/uploads/${newFilename}`; // Construct the URL to be stored in the database

    const query = 'UPDATE Users SET profile_picture = ? WHERE userID = ?';
    db.query(query, [profilePictureUrl, userId], (err, result) => {
      if (err) {
        console.error('Error updating profile picture path:', err);
        res.status(500).send('Error uploading profile picture');
      } else {
        res.status(200).send(profilePictureUrl);
        console.log(profilePictureUrl);
      }
    });
  });
});
/////////////////////////////////////////////////////////
// Route to handle user registration
app.post('/register', async (req, res) => {
  const { username, name, password } = req.body;

  // Data validation (replace with your logic)
  if (!username || !name || !password) {
    return res.status(400).send('Missing required fields');
  }
  const query = 'SELECT * FROM Users WHERE username = ?';
  db.query(query, [username], (error, results, fields) => {
    if (error) {
      console.error(error);
      return res.status(500).json({ error: 'Internal server error' });
    }

    // If the username already exists, return an error message
    if (results.length > 0) {
      return res.status(409).json({ message: 'Nom d\'utilisateur déjà existant' });
    }else{
      const sql = `
      INSERT INTO Users (username, name, password)
      VALUES (?, ?, ?);
      `;
      const values = [username, name, password];

      db.query(sql, values, (err, result) => {
        if (err) {
          console.error(err);
          res.status(500).send('Error during registration');
        } else {
          res.status(200).json({ message: 'Registration successful', user:{
          userID : result.insertId,
          username:username,
          name:name,
          password: password,
          profile_picture: null,
          city : null
          }});
          console.log({ message: 'Registration successful',user:{
            userID : result.insertId,
            username:username,
            name:name,
            password: password,
            profile_picture: null,
            city : null
          }});
        }
      })
    }
  });

  
});


app.post('/login', async (req, res) => {
  const { username, password } = req.body;

  // Input validation (basic example, consider more robust validation)
  if (!username || !password) {
    return res.status(400).json({ message: 'Missing username or password' });
  }
  db.query("select * from Users WHERE username = ? AND password = ?",[username,password],(err,result)=>{
    if (err) {
      console.log(err);
      res.status(500).json({message:"internal server error"});
    } else {
      if(result.length>0){
        res.status(200).json({message:"user loged in ",user: result[0]});
        console.log({message : "succes", User :result[0] })
      }else{
        res.status(404).json({message:"Nom d'utilisateur ou mot de passe incorrect"});
      }
    }
  })
});

app.post('/update', async (req,res)=>{
  const { id,Name, password ,city} = req.body;
  
  db.query("UPDATE Users SET name = ?, password = ?, city = ? WHERE userID = ?",[Name,password,city,id],(err,result)=>{
    if (err) {
      console.log(err);
      res.status(500).json({message:"internal server error"});
    } else {
      res.status(200).json({ message: 'Mettre a jour', user:{
        userID : id,
        name:Name,
        password: password,
        city : city
        }});
        console.log({ message: 'Mettre a jour', user:{
          userID : id,
          name:Name,
          password: password,
          city : city
          }});
    }
  })
})


app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
