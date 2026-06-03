--subquery 
SELECT student_name,fees
FROM student
WHERE fees >(SELECT AVG(fees)FROM student);

--subquery in single row 
SELECT student_name 
FROM student
WHERE fees >(SELECT fees FROM student 
             WHERE student_name='ram');

--multiple row subquery 
SELECT student_name
FROM student
WHERE department IN (SELECT department FROM student 
                     WHERE fees >40000); 

--subquery in WHERE clause
SELECT student_name,department 
FROM student
WHERE fees> (SELECT AVG(fees) FROM student);

