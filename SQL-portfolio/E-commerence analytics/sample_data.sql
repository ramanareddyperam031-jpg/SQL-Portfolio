INSERT INTO customers VALUES
(1,  'Aarav Mehta','aarav.m@gmail.com','Mumbai','2022-01-10', TRUE),
(2,  'Priya Sharma','priya.s@yahoo.com','Delhi','2022-03-22', FALSE),
(3,  'Rohan Verma','rohan.v@outlook.com','Bangalore','2022-06-05', TRUE),
(4,  'Sneha Pillai','sneha.p@gmail.com','Chennai','2022-07-18', FALSE),
(5,  'Karan Joshi','karan.j@gmail.com','Hyderabad','2022-09-01', TRUE),
(6,  'Ananya Bose','ananya.b@hotmail.com','Kolkata','2023-01-14', FALSE),
(7,  'Vikram Nair','vikram.n@gmail.com','Mumbai','2023-02-28', TRUE),
(8,  'Deepika Rao','deepika.r@yahoo.com','Hyderabad','2023-04-10', FALSE),
(9,  'Arjun Singh','arjun.s@gmail.com','Delhi','2023-06-20', FALSE),
(10, 'Meera Iyer','meera.i@gmail.com','Chennai','2023-08-15',TRUE);

SELECT * FROM customers;

INSERT INTO categories VALUES
(1,'Electronics'),
(2,'Clothing'),
(3,'Books'),
(4,'Home & Kitchen'),
(5,'Sports & Fitness');

SELECT * FROM categories;
 

INSERT INTO products VALUES
(101, 'Wireless Headphones',1, 2999.00, 80),
(102, 'Mechanical Keyboard',1, 4500.00,45),
(103, 'USB-C Hub',1,  899.00,120),
(104, 'Men Slim Fit Jeans',2,999.00,200),
(105, 'Women Kurti Set',2,750.00,180),
(106, 'Data Structures Book',3,599.00,60),
(107, 'SQL Mastery Guide',3,499.00,75),
(108, 'Non-Stick Cookware Set',4,3200.00,30),
(109, 'Air Fryer',4,5500.00,25),
(110, 'Yoga Mat',5,799.00,150),
(111, 'Resistance Bands Set',5,450.00,200),
(112, 'Smartwatch Pro',1,8999.00,40);

SELECT * FROM products;

INSERT INTO orders VALUES
(1001,1,'2023-01-15','Completed'),
(1002,2,'2023-02-10','Completed'),
(1003,3,'2023-02-20','Cancelled'),
(1004,4,'2023-03-05','Completed'),
(1005,5,'2023-03-18','Completed'),
(1006,6,'2023-04-02','Pending'),
(1007,7,'2023-04-22','Completed'),
(1008,1,'2023-05-10','Completed'),
(1009,2,'2023-05-25','Returned'),
(1010,3,'2023-06-08','Completed'),
(1011,8,'2023-06-15','Completed'),
(1012,5,'2023-07-01','Completed'),
(1013,9,'2023-07-14','Cancelled'),
(1014,10,'2023-08-05','Completed'),
(1015,7,'2023-08-20','Completed'),
(1016,1,'2023-09-12','Completed'),
(1017,4,'2023-09-28','Completed'),
(1018,6,'2023-10-10','Completed'),
(1019,8,'2023-10-25','Completed'),
(1020,10,'2023-11-05','Completed');

SELECT * FROM orders;

INSERT INTO order_items VALUES
(1,1001,101,1,2999.00),
(2,1001,106,2,599.00),
(3,1002,104,1,999.00),
(4,1002,105,2,750.00),
(5,1003,112,1,8999.00),
(6,1004,108,1,3200.00),
(7,1005,101,1,2999.00),
(8,1005,102,1,4500.00),
(9,1006,110,2,799.00),
(10,1007,109,1,5500.00),
(11,1008,103,2,899.00),
(12,1008,107,1,499.00),
(13,1009,104,1,999.00),
(14,1010,112,1,8999.00),
(15,1011,111,3,450.00),
(16,1012,102,1,4500.00),
(17,1013,109,1,5500.00),
(18,1014,105,3,750.00),
(19,1015, 112,1,8999.00),
(20,1016,101,2,2999.00),
(21,1017,108,1,3200.00),
(22,1018,110,1,799.00),
(23,1019,106,2,599.00),
(24,1020,109,1,5500.00);

SELECT * FROM order_items;

INSERT INTO reviews VALUES
(1,1,101,5,'2023-01-20'),
(2, 2,104, 4, '2023-02-15'),
(3, 3,112, 2, '2023-02-25'),
(4, 4,108, 5, '2023-03-10'),
(5, 5,101, 4,'2023-03-22'),
(6, 5,102,5,'2023-03-23'),
(7, 7,109,5, '2023-04-27'),
(8,1,103, 3, '2023-05-15'),
(9, 10,105,4,'2023-08-10'),
(10,7,112,5,'2023-08-25');

SELECT * FROM reviews;

  
 