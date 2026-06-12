CREATE TABLE customers (
    customer_id     INT PRIMARY KEY,
    full_name       VARCHAR(100) NOT NULL,
    email           VARCHAR(150) UNIQUE NOT NULL,
    city            VARCHAR(50),
    signup_date     DATE NOT NULL,
    is_premium      BOOLEAN DEFAULT FALSE
);

CREATE TABLE categories (
    category_id     INT PRIMARY KEY,
    category_name   VARCHAR(60) NOT NULL
);
 
CREATE TABLE products (
    product_id      INT PRIMARY KEY,
    product_name    VARCHAR(150) NOT NULL,
    category_id     INT REFERENCES categories(category_id),
    price           DECIMAL(10,2) NOT NULL,
    stock_qty       INT NOT NULL DEFAULT 0
);
 
CREATE TABLE orders (
    order_id        INT PRIMARY KEY,
    customer_id     INT REFERENCES customers(customer_id),
    order_date      DATE NOT NULL,
    status          VARCHAR(20) CHECK (status IN ('Completed','Cancelled','Pending','Returned'))
);
 
CREATE TABLE order_items (
    item_id         INT PRIMARY KEY,
    order_id        INT REFERENCES orders(order_id),
    product_id      INT REFERENCES products(product_id),
    quantity        INT NOT NULL CHECK (quantity > 0),
    unit_price      DECIMAL(10,2) NOT NULL
);
 
CREATE TABLE reviews (
    review_id       INT PRIMARY KEY,
    customer_id     INT REFERENCES customers(customer_id),
    product_id      INT REFERENCES products(product_id),
    rating          INT CHECK (rating BETWEEN 1 AND 5),
    review_date     DATE NOT NULL
);
 