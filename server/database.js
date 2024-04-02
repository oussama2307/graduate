import mysql from "mysql2";

const pool = mysql.createPool({
    host : "localhost",
    user : "root",
    password : "root",
    database : "memoire"
}).promise()

async function getInfo() {
    const [rows] = await pool.query("select * from Users");
    return rows[0];
}

console.log(await getInfo());