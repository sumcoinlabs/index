const express = require('express');
const axios = require('axios');
const connection = require('./db'); // Import the database connection

const app = express();
const port = 3000;

// Function to fetch and update Sumcoin data
const fetchAndUpdateSumcoinData = async () => {
    try {
        const response = await axios.get('https://sumcoinindex.com/rates/price2.json');
        const data = response.data;

        // Assuming 'data' contains the fields directly
        const query = `INSERT INTO sumcoin (id, current_price, circulating_supply, max_supply, market_cap,) 
                       VALUES ('sumcoin', ?, ?, ?, ?)
                       ON DUPLICATE KEY UPDATE 
                       current_price = VALUES(exch_rate), 
                       circulating_supply = VALUES(circulating_supply), 
                       max_supply = VALUES(max_supply),
                       market_cap = VALUES(marketcap_usd); 
                       

        const values = [data.current_price, data.circulating_supply, data.market_cap, new Date()];

        connection.query(query, values, (err, results) => {
            if (err) {
                console.error('Error updating the database:', err);
                return;
            }
            console.log('Database updated:', results);
        });

    } catch (error) {
        console.error('Error fetching Sumcoin data:', error);
    }
};

// API endpoint to get the latest Sumcoin data
app.get('/sumcoin', (req, res) => {
    const query = 'SELECT * FROM sumcoin WHERE id = "sumcoin" ORDER BY last_updated DESC LIMIT 1';
    connection.query(query, (err, results) => {
        if (err) {
            res.status(500).send('Error retrieving data from database');
            return;
        }
        res.json(results[0]);
    });
});

// Endpoint to trigger data fetch and update
app.get('/update-sumcoin', async (req, res) => {
    await fetchAndUpdateSumcoinData();
    res.send('Sumcoin data updated.');
});

// Start the Express server
app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});
