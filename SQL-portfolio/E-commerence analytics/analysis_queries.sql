--1.What is the total revenue from completed orders?(aggregation)
SELECT  ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'Completed';

--2.Which are the top 5 best-selling products by total units sold?(GROUP BY +ORDER BY )
SELECT  p.product_name,SUM(oi.quantity) AS total_units_sold,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id   = o.order_id
WHERE o.status = 'Completed'
GROUP BY p.product_id, p.product_name
ORDER BY total_units_sold DESC
LIMIT 5;

--3.Which city generates the most revenue?(Multi-table join+ aggregation)
SELECT c.city,COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.unit_price),2) AS city_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id  = oi.order_id
WHERE o.status ='Completed'
GROUP BY c.city
ORDER BY city_revenue DESC;

--4.What is the month-over-month revenue trend for 2023?(Date function+GROUP BY )
SELECT TO_CHAR(o.order_date, 'YYYY-MM') AS month,COUNT(DISTINCT o.order_id) AS orders_placed,
ROUND(SUM(oi.quantity * oi.unit_price), 2) AS monthly_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'Completed' AND EXTRACT(YEAR FROM o.order_date) = 2023
GROUP BY TO_CHAR(o.order_date, 'YYYY-MM')
ORDER BY month;

--5.Which customers have never placed an order?(Left join+NULL CHECK )
SELECT c.customer_id,c.full_name,c.email,c.signup_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

--6.What percentage of orders were cancelled or returned per month?(CASE WHEN + percentage calculation)
SELECT TO_CHAR(order_date, 'YYYY-MM') AS month, COUNT(*)  AS total_orders,
COUNT(CASE WHEN status IN ('Cancelled','Returned') THEN 1 END) AS failed_orders,
    ROUND(
        COUNT(CASE WHEN status IN ('Cancelled','Returned') THEN 1 END) * 100.0/ COUNT(*), 2 ) 
		AS failure_rate_pct
FROM orders
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month;

--7.Find each customer's most recent order and its value.(CTE + Window Function: ROW_NUMBER)
WITH order_totals AS (
    SELECT o.order_id,o.customer_id,o.order_date,o.status,
    SUM(oi.quantity * oi.unit_price) AS order_value
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id, o.customer_id, o.order_date, o.status
),
ranked AS (
    SELECT *,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) As rn
    FROM order_totals
	)
SELECT c.full_name, r.order_id, r.order_date, r.status, 
ROUND(r.order_value, 2) AS latest_order_value
FROM ranked r
JOIN customers c ON r.customer_id = c.customer_id
WHERE rn = 1
ORDER BY r.order_date DESC;

