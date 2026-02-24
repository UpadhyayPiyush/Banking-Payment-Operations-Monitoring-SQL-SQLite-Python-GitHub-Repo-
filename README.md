# Banking Payment Operations Monitoring 

## Project Overview
This project presents an end-to-end banking transaction monitoring and operational risk analytics system built using MySQL, SQL, Python, and Power BI.  
The system analyzes 120,000+ financial transactions across customers, accounts, login activity, and settlements to simulate a real payment operations environment.  
The dashboard enables operations teams to monitor system health, detect transaction backlogs, identify abnormal customer behavior, and evaluate settlement performance. The solution combines SQL-based operational KPIs, statistical anomaly detection in Python, and an interactive Power BI monitoring interface to support data-driven decision making.

## Business Problem 
Banks process thousands of payment transactions daily. Even a small percentage of processing delays can create:
- customer dissatisfaction
- settlement reconciliation failures
- financial exposure
- regulatory compliance risks  
However, operations teams often only see transaction counts, not operational risk.

The key challenge: 
How can a bank proactively monitor transaction processing, detect operational issues early, and identify risky behavior before escalation?

## Objective 
The objective of this project was to design a payment operations monitoring framework that:
- Tracks real-time operational health of transactions
- Detects processing backlogs and settlement delays
- Identifies abnormal user behavior and high-risk activity
- Quantifies financial exposure from pending payments
- Supports operational and compliance decision-making

## Schema Structure 
The relational database was designed using a multi-table banking structure.

`sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    country VARCHAR(50),
    risk_category VARCHAR(20),
    kyc_status VARCHAR(20),
    account_open_date DATE
);

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(20),
    account_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_time DATETIME,
    transaction_amount DECIMAL(12,2),
    transaction_type VARCHAR(20),
    merchant_category VARCHAR(50),
    location VARCHAR(50),
    device_type VARCHAR(20),
    status VARCHAR(20),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE TABLE login_activity (
    login_id INT PRIMARY KEY,
    customer_id INT,
    login_time DATETIME,
    login_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE settlements (
    settlement_id INT PRIMARY KEY,
    transaction_id INT,
    settlement_date DATETIME,
    settlement_status VARCHAR(20),
    delay_hours INT,
    FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id)
);`
