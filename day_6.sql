/*
================================================================
DATAPENCIL - 7 DAYS SQL CHALLENGE
DAY 6 | PROJECT 5
ORDER FULFILLMENT & DELIVERY ANALYSIS
================================================================

PROJECT OBJECTIVE:
Analyze order statuses, delivery performance, monthly order
volumes, payment statuses, delayed deliveries, and delivery
performance by customer city using SQL.

BUSINESS QUESTIONS:
1. How many orders belong to each order status?
2. How many deliveries belong to each delivery status?
3. What is the average delivery time for completed deliveries?
4. Which 10 completed deliveries took the longest?
5. How does order volume change month by month?
6. How are payment records distributed across payment statuses?
7. Which completed deliveries took more than five days?
8. Which customer cities have the longest average delivery times?

DATABASE:
This script uses the existing database: sql7challenge

TABLES AND COLUMNS USED:
- orders: order_id, customer_id, order_date, status
- deliveries: order_id, dispatch_date, delivery_date, delivery_status
- payments: payment_status
- customers: customer_id, city

IMPORTANT:
Check your actual table and column names in MySQL Workbench
before running this script.

The challenge material may use the database name
datapencil_store. This script uses sql7challenge, based on
the database created earlier. If your database has a different
name, change the USE statement below.

DELIVERY TIME NOTE:
The delivery-time queries calculate the number of days from
dispatch_date to delivery_date.

SQL CONCEPTS USED:
SELECT, COUNT(), AVG(), ROUND(), DATEDIFF(), DATE_FORMAT(),
GROUP BY, ORDER BY, LIMIT, JOIN, and WHERE.

BUSINESS INSIGHTS:
After running the queries, write your findings here using
your actual output:
1. The most common order status is [status], with [count] orders.
2. The average dispatch-to-delivery time is [number] days.
3. [city] has the highest average delivery time at [number] days.

Do not submit the placeholders. Replace them with actual
values from your query results.

================================================================
*/

USE sql7challenge;


-- ================================================================
-- QUERY 1: ORDER STATUS DISTRIBUTION
-- Count the number of orders in each order status.
-- ================================================================

SELECT
    status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY status
ORDER BY total_orders DESC;


-- ================================================================
-- QUERY 2: DELIVERY STATUS DISTRIBUTION
-- Count the number of deliveries in each delivery status.
-- ================================================================

SELECT
    delivery_status,
    COUNT(*) AS total_deliveries
FROM deliveries
GROUP BY delivery_status
ORDER BY total_deliveries DESC;


-- ================================================================
-- QUERY 3: AVERAGE DELIVERY TIME
-- Calculate average dispatch-to-delivery days for completed
-- deliveries.
-- ================================================================

SELECT
    ROUND(AVG(DATEDIFF(delivery_date, dispatch_date)), 2)
        AS average_delivery_days
FROM deliveries
WHERE LOWER(delivery_status) = 'delivered'
  AND dispatch_date IS NOT NULL
  AND delivery_date IS NOT NULL;


-- ================================================================
-- QUERY 4: TOP 10 LONGEST DELIVERIES
-- Display the 10 completed deliveries that took the longest.
-- ================================================================

SELECT
    order_id,
    dispatch_date,
    delivery_date,
    DATEDIFF(delivery_date, dispatch_date) AS delivery_days
FROM deliveries
WHERE LOWER(delivery_status) = 'delivered'
  AND dispatch_date IS NOT NULL
  AND delivery_date IS NOT NULL
ORDER BY delivery_days DESC
LIMIT 10;


-- ================================================================
-- QUERY 5: MONTHLY ORDER VOLUMES
-- Count orders month by month.
-- ================================================================
