const mysql = require('mysql');

// Database connection setup
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'your_user',
    password: 'unique_password',
    database: 'sumcoin_index'
});

// Connect to the database
connection.connect(err => {
    if (err) {
        console.error('Error connecting to the Sumcoin Index database:', err);
        return;
    }
    console.log('Connection Successful to Sumcoin Index MySQL server.');
});

module.exports = connection;
