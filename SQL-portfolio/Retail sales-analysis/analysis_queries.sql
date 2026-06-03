SELECT COUNT(*) AS total_sales 
FROM sales;

SELECT SUM(total_amount) AS total_revenue 
FROM sales;

SELECT AVG(total_amount) AS avg_amount,
MAX(total_amount) as maxm_amount,
MIN(total_amount) as minm_amount
FROM sales;

SELECT sale_id,total_amount
FROM sales
ORDER BY total_amount DESC;

SELECT *
FROM sales 
WHERE discount_pct > 0;

-- Performing "WINDOW FUNCTIONS".
--Rank sales by total amount.
SELECT sale_id,customer_id,total_amount,
RANK() OVER (PARTITION BY total_amount ORDER BY total_amount DESC ) AS rnk
FROM sales;

--TOP 3 highest sales.
SELECT sale_id,customer_id,total_amount,
DENSE_RANK() OVER (PARTITION BY total_amount ORDER BY total_amount DESC ) AS dns_rnk
FROM sales
LIMIT 3;

--Assign ROW numbers to sales ordered by date.(descending order)
SELECT sale_id,customer_id,sale_date as newsale_date ,
ROW_NUMBER() OVER (PARTITION BY sale_id  ORDER BY sale_id DESC ) AS row_num
FROM sales
ORDER BY sale_date DESC;

--Find the previous sale amount using LAG().
SELECT sale_id,customer_id,total_amount,
LAG(total_amount) OVER (ORDER BY total_amount ASC ) AS prev_amount,
LEAD(total_amount) OVER (ORDER BY total_amount ASC ) AS nxt_amount
FROM sales;

--Calculates running total revenue for each customer.
SELECT sale_id,customer_id,sale_date,total_amount,
SUM(total_amount) over(PARTITION BY customer_id ORDER BY sale_date) as running_total
FROM sales;

--Calculate cumulative(SUM) quanatity sold.
SELECT customer_id,quantity,sale_date,total_amount,
SUM(quantity) over(PARTITION BY customer_id ORDER BY sale_date   ASC ) as running_total
FROM sales;

--CASE STATEMENT(categorize,label data,custom sorting order).
Select sale_id,customer_id,sale_date,total_amount,
CASE 
    WHEN total_amount < 1000 THEN 'low_amount'
	WHEN total_amount BETWEEN 1000 AND 3000 THEN 'avg_amount'
	ELSE 'high_amount'
	END AS amount_category
FROM sales
ORDER BY amount_category;


--Subqueries& CTE'S.
--Find sale with highest,lowest amount.
SELECT *
FROM sales
WHERE total_amount= (SELECT MAX(total_amount) as high_amount 
                    FROM sales);
					

SELECT *
FROM sales
WHERE total_amount=(SELECT MIN(total_amount) as high_amount 
                    FROM sales);

--2nd highest sale amount.
WITH ranked_sales AS 
(SELECT sale_id,total_amount,
 DENSE_RANK() OVER (ORDER BY  total_amount  DESC ) AS rnk
FROM sales 
)

SELECT *
FROM ranked_sales 
WHERE rnk = 2;

--Using "SUBQUERY".
SELECT MAX(total_amount) as  secondhigh_amount
FROM sales
WHERE total_amount< (SELECT MAX(total_amount) 
                    FROM sales);

--Find  customers whose spending is above the average sale amount.
SELECT sale_id,sale_date,total_amount AS spending_amount
FROM sales
WHERE total_amount >(SELECT AVG(total_amount) 
                     FROM sales);

--Find customers who made the maximum number of purchases.
SELECT customer_id,quantity as max_quantity
FROM sales
WHERE quantity = (SELECT MAX(quantity) 
                     FROM sales);

--Find customers whose total spending > average customer spending.
SELECT MAX(total_amount )  AS max_amount
FROM sales  WHERE total_amount >(SELECT AVG(total_amount) 
                                 FROM sales);

--Find  sales that occured on last date.
SELECT *
FROM sales
WHERE sale_date =(SELECT MAX(sale_date) 
                  FROM sales);
--Calculate total revenue per customer and display all customers.
WITH cte AS ( 
SELECT customer_id,MAX(total_amount)  AS amount
FROM sales
GROUP BY customer_id)

SELECT customer_id
FROM cte ;

--Find Top 3 customers by revenue.
WITH customer_revenue  AS (
SELECT customer_id,SUM(total_amount) AS revenue
FROM sales
GROUP BY customer_id)

SELECT *
FROM customer_revenue
ORDER BY revenue DESC
LIMIT 3;

--Total quantity sold per product.
WITH cte AS (
SELECT product_id,SUM(quantity) as total_quantity
FROM sales
GROUP BY product_id)

SELECT *
FROM cte ;

--Find products whose revenue exceeds 30000.
WITH cte AS (
SELECT sale_id,product_id,total_amount AS revenue
FROM sales
WHERE total_amount > 3000)

SELECT * FROM cte;

--categorize sales category.(low,medium,high)
Select sale_id,customer_id,sale_date,total_amount,
CASE 
    WHEN total_amount < 1000 THEN 'low_sale'
	WHEN total_amount BETWEEN 1000 AND 3000 THEN 'avg_sale'
	ELSE 'high_sale'
	END AS sale_category
FROM sales
ORDER BY sale_category;

SELECT * FROM sales;

--Find customers with more than one purchase.
WITH customer_purchases AS (
SELECT customer_id,
COUNT(*) AS purchase_count
FROM sales
GROUP BY customer_id)

SELECT *
FROM customer_purchases
WHERE purchase_count > 1;
