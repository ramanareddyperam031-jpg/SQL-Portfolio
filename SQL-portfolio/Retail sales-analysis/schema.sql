CREATE TABLE sales (
  sale_id       INT PRIMARY KEY,
  customer_id   INT,
  product_id    INT,
  sale_date     DATE,
  quantity      INT,
  discount_pct  DECIMAL(5,2),
  total_amount  DECIMAL(10,2)
);
