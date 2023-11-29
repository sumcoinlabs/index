-- Creating the 'sumcoin_index' database.
CREATE DATABASE sumcoin_index;
USE sumcoin_index;

-- Creating the 'sumcoin' table with specific default values for 'id', 'symbol', and 'name', and a predefined image URL.
-- The 'max_supply' field is set to allow NULL values, reflecting that it's an optional field for Sumcoin.
-- The table is designed to store both historical and future data about Sumcoin.
CREATE TABLE sumcoin (
    id VARCHAR(50) NOT NULL PRIMARY KEY DEFAULT 'sumcoin',
    symbol VARCHAR(50) NOT NULL DEFAULT 'sum',
    name VARCHAR(100) NOT NULL DEFAULT 'Sumcoin',
    image VARCHAR(255) DEFAULT 'https://sumcoin.org/wp-content/uploads/2019/07/sumcoin_400x400.png',
    current_price DOUBLE,
    market_cap DOUBLE,
    market_cap_rank INT,
    fully_diluted_valuation DOUBLE,
    total_volume DOUBLE,
    high_24h DOUBLE,
    low_24h DOUBLE,
    price_change_24h DOUBLE,
    price_change_percentage_24h DOUBLE,
    market_cap_change_24h DOUBLE,
    market_cap_change_percentage_24h DOUBLE,
    circulating_supply DOUBLE,
    total_supply DOUBLE,
    max_supply DOUBLE DEFAULT NULL,
    ath DOUBLE,
    ath_change_percentage DOUBLE,
    ath_date DATETIME,
    atl DOUBLE,
    atl_change_percentage DOUBLE,
    atl_date DATETIME,
    last_updated DATETIME
);

-- Creating the 'roi' table for storing ROI data.
-- This table will have a foreign key relationship with the 'sumcoin' table.
CREATE TABLE IF NOT EXISTS roi (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sumcoin_id VARCHAR(50),
    times DOUBLE,
    currency VARCHAR(10),
    percentage DOUBLE,
    FOREIGN KEY (sumcoin_id) REFERENCES sumcoin(id)
);

-- Creating the 'sparkline_data' table for storing sparkline data.
-- This table will also have a foreign key relationship with the 'sumcoin' table.
CREATE TABLE IF NOT EXISTS sparkline_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sumcoin_id VARCHAR(50),
    data LONGTEXT,  -- Storing serialized data, e.g., JSON
    FOREIGN KEY (sumcoin_id) REFERENCES sumcoin(id)
);

-- Granting all privileges to the 'YOUR-USER' user for the 'sumcoin_index' database.
-- Uncomment the following lines if you need to explicitly set these permissions for 'YOUR-USER'.
-- GRANT ALL PRIVILEGES ON sumcoin_index.* TO 'YOUR-USER'@'localhost';
-- FLUSH PRIVILEGES;
