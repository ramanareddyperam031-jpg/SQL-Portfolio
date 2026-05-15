--GROUP BY STATEMENT(count no of employees)

SELECT department, COUNT(*) AS "total_employes"
FROM student
GROUP BY student_id;

SELECT department, COUNT(*) 
FROM student
WHERE fees >50000
GROUP BY department;

SELECT department, SUM(fees) AS total_fees
FROM students
GROUP BY department;
