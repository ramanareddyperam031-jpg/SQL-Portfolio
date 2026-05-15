CREATE TABLE employee
(
emp_id VARCHAR(30) PRIMARY KEY,
emp_name VARCHAR(30),
department CHAR(10) NOT NULL,
age INT,
email VARCHAR(100) UNIQUE,
salary INT
);

SELECT * FROM employee;

INSERT INTO employee (emp_id,emp_name,department,age,email,salary)
VALUES ( 27,'ravi','IT',25,'ravi27@gmail.com',40000),
( 22,'john', 'ECE',25,'john22@gmail.com',50000),
( 21,'mac','EEE',27,'mac21@gmail.com',60000),
(43,'ram','MECH',48,'ram43@gmail.com',20000),
(54,'shyam','AIDS',57,'shyam54@gmail.com',90000),
(65,'korean','IT',69,'korean65@gmail.com',10000);

ALTER table employee
DROP COLUMN department;

ALTER TABLE employee
ADD COLUMN department CHAR(30);