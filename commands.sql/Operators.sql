SELECT * from employee
WHERE department= 'IT';

SELECT * from employee
WHERE age <=30 ;

SELECT * from employee 
WHERE age >=60;

SELECT * from employee
WHERE AGE>50 OR department='IT';

SELECT * from employee
WHERE AGE>50  AND department='ECE ';

SELECT * from employee
WHERE emp_name LIKE '%m';

SELECT DISTINCT department,age 
FROM employee;

SELECT * from employee  WHERE AGE between 20 and 50 ORDER by AGE;
SELECT * from employee  WHERE emp_name IN('ravi','ram','john');
SELECT * from employee  WHERE emp_name  NOT IN('ravi','ram','john');

SELECT department FROM employee 
LIMIT 5;

SELECT * from employee
WHERE department='EEE';

--logical operator-OR 
SELECT * from employee
WHERE AGE>35 OR department='IT';

--logical operator-AND 
SELECT * from employee
WHERE salary<40000  AND department='IT';
