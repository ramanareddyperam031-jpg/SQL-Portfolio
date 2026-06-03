--JOINS(betwwen two tables)

SELECT e.emp_id,e.emp_name,s.student_name
FROM employee AS e
JOIN student AS s ON e.emp_id=s.student_id;

SELECT s.student_name,s.department,s.fees
FROM employee AS e
JOIN student AS s ON e.department=s.department;

SELECT e.emp_name,s.student_name
FROM employee e
JOIN student s ON e.emp_id=s.student_id;

--WHERE clause of two tables

SELECT  e.emp_id,s.student_id
FROM employee AS e  INNER JOIN students AS s
ON e.emp_id=s.student_id ;
SELECT * FROM student;
