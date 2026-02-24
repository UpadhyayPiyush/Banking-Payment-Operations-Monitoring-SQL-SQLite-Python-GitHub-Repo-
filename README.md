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

```sql
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
);
```

## Tools & Technologies 
- **MySQL**: relational database & data storage
- **SQL**: KPI creation, aggregations, and operational analysis
- **Python (Pandas, NumPy, Seaborn, Matplotlib)**: statistical analysis & anomaly detection
- **Power BI**: interactive monitoring dashboard & reporting
- **GitHub**: project documentation and version control
- **MS Word**: report creation

## Project Workflow 
1) Data ingestion into MySQL relational database
2) SQL queries used to validate data and create operational KPIs
3) Root-cause analysis performed using grouped aggregations
4) Python statistical analysis:
   - Z-score detection (value anomalies)
   - IQR detection (behavior anomalies)
5) Identification of abnormal transaction behavior
6) Power BI dashboard development:
   - Page 1: Operations monitoring
   - Page 2: Risk & investigation analysis
7) Business insights and operational recommendations

## Visual Analysis & Dashboard Walkthrough
This section demonstrates how analytical findings were validated using statistical visualization (Python) and operational monitoring dashboards (Power BI).  
The visuals below illustrate transaction behavior, operational workload, anomaly detection, and predictive monitoring.  

**Transaction Amount Distribution**  
![img1](https://github.com/UpadhyayPiyush/Banking-Payment-Operations-Monitoring-SQL-SQLite-Python-GitHub-Repo-/blob/main/Graphs/Img1.png)  

**Purpose**:  
This histogram visualizes the distribution of transaction values across 120,000+ transactions.  
**What it shows**:  
Most transactions fall within low-value ranges (< ₹40,000), while a long right tail represents rare high-value payments. Using statistical thresholds (Z-score > 3), approximately 2,227 transactions (~1.85%) were flagged as abnormal.  
**Business Use**:  
Most transactions fall within low-value ranges (< ₹40,000), while a long right tail represents rare high-value payments. Using statistical thresholds (Z-score > 3), approximately 2,227 transactions (~1.85%) were flagged as abnormal.  

**Hourly Transaction Load Pattern** 
![img2](https://github.com/UpadhyayPiyush/Banking-Payment-Operations-Monitoring-SQL-SQLite-Python-GitHub-Repo-/blob/main/Graphs/Img2.png)

**Purpose**: 
Shows how transaction processing load varies across a 24-hour cycle.  
**What it shows**:  
Transaction volume peaks around 22:00 (10 PM) with more than 5,100 transactions/hour, indicating customer payment activity is concentrated in late evening hours.  
**Business Use**:  
Transaction volume peaks around 22:00 (10 PM) with more than 5,100 transactions/hour, indicating customer payment activity is concentrated in late evening hours.

**Transaction Frequency Per Count**  
![img3](https://github.com/UpadhyayPiyush/Banking-Payment-Operations-Monitoring-SQL-SQLite-Python-GitHub-Repo-/blob/main/Graphs/Img3.png)  

**Purpose**:  
Detects abnormal user behavior based on number of transactions per account.  
**What it shows**:  
Most customers perform ~60–72 transactions, but statistical IQR analysis identified 6 high-frequency accounts significantly exceeding normal activity levels.  
**Business Use**:  
Supports detection of automated retries, bots, or suspicious transaction patterns contributing to system pressure.  

**Transaction Volume Forecast**  
![img4](https://github.com/UpadhyayPiyush/Banking-Payment-Operations-Monitoring-SQL-SQLite-Python-GitHub-Repo-/blob/main/Graphs/Img4.png)  

**Purpose**:  
Predicts expected transaction workload using a 7-day moving average.  
**What it shows**  
Predicts expected transaction workload using a 7-day moving average.  
**Business Use**  
Allows proactive operational planning rather than reactive incident response.  

**Page 1 — Payment Operations Health Monitoring**  
![img5](https://github.com/UpadhyayPiyush/Banking-Payment-Operations-Monitoring-SQL-SQLite-Python-GitHub-Repo-/blob/main/Graphs/Img5.png)  

This page functions as a control panel for operations teams.  
It tracks success rate, failure rate, settlement performance, and daily transaction workload to immediately assess system health and detect processing backlogs.  

**Page 2 — Risk & Investigation Analysis**  
![img6](https://github.com/UpadhyayPiyush/Banking-Payment-Operations-Monitoring-SQL-SQLite-Python-GitHub-Repo-/blob/main/Graphs/Img6.png)  

This investigation view helps analysts diagnose operational incidents.
It highlights pending transactions, high-value exposure, abnormal accounts, and merchant patterns to identify root causes and prioritize operational action.  


## Key Insights 
- ~3% of transactions were pending, impacting 959 customers
- Pending transactions represented approximately ₹7.18 crore financial exposure
- Peak transaction load exceeded 5,100 transactions/hour at 22:00
- 6 abnormal high-frequency accounts identified using statistical anomaly detection
- Travel and e-commerce transactions contributed most to processing backlog
- Some settlements exceeded 24-hour SLA, indicating operational delays

## Recommendations 
- Implement monitoring alerts when pending transaction rate exceeds threshold
- Prioritize high-value pending transactions for manual review
- Introduce retry cooldown for repeated payment attempts
- Apply additional authentication after multiple failed login attempts
- Monitor settlement delays to prevent reconciliation failures
- Restrict high-value transactions for incomplete KYC profiles

## Conclusion
This project demonstrates how data analytics can move beyond reporting to operational decision support.  
By combining SQL monitoring, statistical anomaly detection, and interactive dashboards, the system enables early identification of transaction backlogs, risky behavior, and settlement delays.  

The solution highlights the value of analytics in banking operations — not only to measure performance, but to proactively detect and mitigate operational and compliance risks.

