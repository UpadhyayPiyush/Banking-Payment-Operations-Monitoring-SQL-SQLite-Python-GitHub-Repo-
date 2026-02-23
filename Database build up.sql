-- CREATE DATABASE bank_analytics;
-- USE bank_analytics;

-- # Create Customer Table 
-- CREATE TABLE customers(
-- customer_id INT PRIMARY KEY,
-- name VARCHAR(50),
-- country VARCHAR(40),
-- risk_category VARCHAR(10),
-- kyc_status VARCHAR(15),
-- account_open_date DATE
-- );

-- # Create Account table 
-- CREATE TABLE accounts(
-- account_id INT PRIMARY KEY,
-- customer_id INT,
-- account_type VARCHAR(20),
-- account_balance DECIMAL(12,2),
-- account_status VARCHAR(15),
-- FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
-- );

# Create transaction table 
-- CREATE TABLE transactions(
-- transaction_id INT PRIMARY KEY,
-- account_id INT,
-- transaction_time DATETIME,
-- transaction_amount DECIMAL(10,2),
-- transaction_type VARCHAR(20),
-- merchant_category VARCHAR(40),
-- location VARCHAR(50),
-- device_type VARCHAR(20),
-- status VARCHAR(15),
-- FOREIGN KEY (account_id) REFERENCES accounts(account_id)
-- );

# Create Login table 
-- CREATE TABLE login_activity(
-- login_id INT PRIMARY KEY,
-- customer_id INT,
-- login_time DATETIME,
-- ip_address VARCHAR(45),
-- location VARCHAR(50),
-- login_status VARCHAR(15),
-- FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
-- );

# Create Settlement table 
-- CREATE TABLE settlements(
-- transaction_id INT PRIMARY KEY,
-- settlement_date DATETIME,
-- settlement_status VARCHAR(20),
-- delay_hours INT,
-- FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id)
-- );


#Loading Data for customer table 
-- LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers.csv'
-- INTO TABLE customers
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\r\n'
-- IGNORE 1 ROWS
-- (customer_id, name, country, risk_category, kyc_status, @account_open_date)
-- SET account_open_date = STR_TO_DATE(TRIM(@account_open_date), '%d-%m-%Y');


#Loading Account Data
-- LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/accounts.csv'
-- INTO TABLE accounts
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\r\n'
-- IGNORE 1 ROWS
-- (account_id, customer_id, account_type, account_balance, account_status);


#Loading Data for transaction table 
-- DESCRIBE transactions;

-- SET autocommit=0;
-- SET unique_checks=0;
-- SET foreign_key_checks=0;

-- LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/transactions.csv'
-- INTO TABLE transactions
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\r\n'
-- IGNORE 1 ROWS
-- (transaction_id, account_id, @transaction_time, transaction_amount, transaction_type,
-- merchant_category, location, device_type, status)
-- SET transaction_time =
--     STR_TO_DATE(TRIM(@transaction_time), '%d-%m-%Y %H:%i');

#Loading login table
-- LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/login_activity.csv'
-- INTO TABLE login_activity
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\r\n'
-- IGNORE 1 ROWS
-- (login_id, customer_id, @login_time, ip_address, location, login_status)
-- SET login_time = STR_TO_DATE(TRIM(@login_time), '%d-%m-%Y %H:%i');


#Loading Settlement Data 
-- LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/settlements.csv'
-- INTO TABLE settlements
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\r\n'
-- IGNORE 1 ROWS
-- (transaction_id, @settlement_date, settlement_status, delay_hours)
-- SET settlement_date = STR_TO_DATE(TRIM(@settlement_date), '%d-%m-%Y %H:%i');
