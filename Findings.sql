-- SELECT COUNT(*) FROM customers ; 
-- SELECT COUNT(*) FROM accounts;
-- SELECT COUNT(*) FROM transactions;
-- SELECT COUNT(*) FROM login_activity; 
-- SELECT COUNT(*) FROM settlements; 

###### KPIs ###########

#Total Transactions Processed
-- SELECT COUNT(*) AS total_transactions
-- FROM transactions;

#Transaction Success Rate
-- SELECT 
-- ROUND(
-- SUM(CASE WHEN status='Success' THEN 1 ELSE 0 END)*100.0 / COUNT(*),2
-- ) AS success_rate_percentage
-- FROM transactions;

#Failed Transaction Rate
-- SELECT 
-- ROUND(
-- SUM(CASE WHEN status='Failed' THEN 1 ELSE 0 END)*100.0 / COUNT(*),2
-- ) AS failed_transaction_rate
-- FROM transactions;

#Settlement SLA Compliance
-- SELECT 
-- ROUND(
-- SUM(CASE WHEN delay_hours <= 24 THEN 1 ELSE 0 END)*100.0 / COUNT(*),2
-- ) AS sla_compliance_percentage
-- FROM settlements;

#Pending Settlements (Operational Backlog)
-- SELECT COUNT(*) AS pending_settlements
-- FROM settlements
-- WHERE settlement_status='Pending';

#High-Risk Customers (Compliance Monitoring)
-- SELECT COUNT(*) AS high_risk_customers
-- FROM customers
-- WHERE risk_category='High';

#Customers Without KYC (Regulatory Risk)
-- SELECT COUNT(*) AS pending_kyc_customers
-- FROM customers
-- WHERE kyc_status='Pending';


########## Operational Issue Investigation ############

# Check Time — Are certain hours causing backlog?
-- SELECT HOUR(transaction_time) AS txn_hour,
--        COUNT(*) AS pending_txns
-- FROM transactions
-- WHERE status='Pending'
-- GROUP BY txn_hour
-- ORDER BY pending_txns DESC;

# Peak hour with maximum number of transactions 
-- SELECT 
--     HOUR(transaction_time) AS server_hour,
--     COUNT(*) AS total_transactions
-- FROM transactions
-- GROUP BY server_hour
-- ORDER BY total_transactions DESC;


#Check Location — Is a network region failing?
-- SELECT location,
--        COUNT(*) AS pending_count
-- FROM transactions
-- WHERE status='Pending'
-- GROUP BY location
-- ORDER BY pending_count DESC;

#Check Merchant Category — Is a payment partner failing?
-- SELECT merchant_category,
--        COUNT(*) AS pending_txns
-- FROM transactions
-- WHERE status='Pending'
-- GROUP BY merchant_category
-- ORDER BY pending_txns DESC;

#Check Accounts — Are specific users causing processing issues?
-- SELECT account_id,
--        COUNT(*) AS pending_txns
-- FROM transactions
-- WHERE status='Pending'
-- GROUP BY account_id
-- HAVING COUNT(*) >= 5
-- ORDER BY pending_txns DESC;

############### Risk & Control Investigation Queries ############

# Total value of pending transactions
-- SELECT 
-- ROUND(SUM(transaction_amount),2) AS pending_amount_exposure
-- FROM transactions
-- WHERE status='Pending';

# Exposrue by Loaction 
-- SELECT location,
--        ROUND(SUM(transaction_amount),2) AS total_amount
-- FROM transactions
-- WHERE status='Pending'
-- GROUP BY location
-- ORDER BY total_amount DESC;

# Customers affected by pending payments
-- SELECT COUNT(DISTINCT a.customer_id) AS affected_customers
-- FROM transactions t
-- JOIN accounts a ON t.account_id = a.account_id
-- WHERE t.status='Pending';

# Customers repeatedly retrying payments
-- SELECT a.customer_id,
--        COUNT(*) AS retry_attempts
-- FROM transactions t
-- JOIN accounts a ON t.account_id = a.account_id
-- WHERE t.status='Pending'
-- GROUP BY a.customer_id
-- HAVING COUNT(*) >= 5
-- ORDER BY retry_attempts DESC;

# Suspicious activity after failed login
-- SELECT COUNT(*) AS suspicious_transactions
-- FROM transactions t
-- JOIN accounts a ON t.account_id = a.account_id
-- JOIN login_activity l ON a.customer_id = l.customer_id
-- WHERE l.login_status='Failed'
-- AND t.transaction_time BETWEEN l.login_time 
-- AND l.login_time + INTERVAL 1 HOUR;

# High-risk customers performing high-value transactions
-- SELECT c.customer_id,
--        COUNT(*) AS high_value_txn
-- FROM transactions t
-- JOIN accounts a ON t.account_id = a.account_id
-- JOIN customers c ON a.customer_id = c.customer_id
-- WHERE c.risk_category='High'
-- AND t.transaction_amount > 150000
-- GROUP BY c.customer_id
-- ORDER BY high_value_txn DESC;

# Customers with Pending KYC still transacting
-- SELECT COUNT(DISTINCT c.customer_id) AS non_kyc_active_customers
-- FROM customers c
-- JOIN accounts a ON c.customer_id=a.customer_id
-- JOIN transactions t ON a.account_id=t.account_id
-- WHERE c.kyc_status='Pending';



# just made the data permanently visible to other applications, so we can do further analysis in jupyter notebook by connecting with mysql
commit 


