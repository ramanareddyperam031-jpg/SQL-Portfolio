--Aggregate functions(MIN,MAX,SUM,COUNT)
SELECT MIN(marks)
FROM student;

SELECT MAX(fees)
FROM student;

SELECT SUM(marks)
FROM student;

SELECT COUNT(department)
FROM student;

--With GROUP BY STATEMENT 

SELECT  department, MIN(marks)
FROM student
GROUP BY department;

SELECT  student_name,MAX(marks)
FROM student
GROUP BY student_name;

SELECT  student_id,SUM(marks)
FROM student
GROUP BY student_id;

SELECT  student_name,student_id, COUNT(fees)
FROM student
GROUP BY student_name,student_id;

SELECT  student_name, SUM(fees)
FROM student
GROUP BY student_name
HAVING SUM(fees) >50000; 

SELECT  department, MAX(fees)
FROM student
GROUP BY department
HAVING MAX(fees) >50000; 

SELECT  age, MIN(fees)
FROM student
GROUP BY age
HAVING  MIN(fees) <50000; 

SELECT department,SUM(fees)
FROM student
WHERE Fees >40000
GROUP BY department;
