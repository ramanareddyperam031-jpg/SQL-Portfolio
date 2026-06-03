--sub queries in depth(types)

SELECT * from employe
WHERE salary> (SELECT avg(salary) from employe);

--scalar subquery(returns only 1row,1column)
SELECT emp_name,salary,
                (SELECT avg(salary) 
				from employee) AS AVG_SALARY from employee;


--Q.find the employes who earn the highest salry in each department
SELECT * FROM employee
WHERE (department,salary) IN (
                      SELECT department,MAX(salary) from employee
                      GROUP BY department
					  );

--single column &multiple-row subquery( returns only single column,and multiple rows)
SELECT emp_id FROM employee
WHERE department  NOT IN ( 
                      SELECT department 
                      FROM employee
                      WHERE department='IT'
					  );

--correalted subquery(inner query or subquery  depends on outer query)
--Q.find the employee in each department who earn more than average salary in that depaartment.

SELECT * from employee 
WHERE salary >(SELECT avg(salary) 
               FROM employee
               WHERE department='IT'
			   );
--Q.find the department who do not hav any employes.

SELECT  * FROM student AS s
WHERE NOT EXISTS (
                 SELECT  * FROM  employee e 
                 WHERE s.student_id=e.emp_id
				 );

--Nested subquery(subquery inside another subquery)
--Find employees working in the department with highest salary
SELECT emp_name from employee
WHERE department=(SELECT department
                  FROM employee 
                  WHERE salary = (SELECT MAX(salary ) 
				  FROM employee)
				  );

--Different clauses where subquery is allowed
--SELECT CLAUSE
--Q.show employe wuth total number of emploees

SELECT emp_name,emp_id,
         (SELECT COUNT(*) FROM employee) AS total_employees
FROM employee;

SELECT * FROM employee;
--find the departments whose average salary is higher than overall average salary
----Find departments with above-average salaries.

SELECT department, AVG(salary) AS avg_salary
FROM employee
GROUP BY department
HAVING AVG(salary) > (
                      SELECT AVG(salary)
                      FROM employee
                      );

--WHERE CLAUSE-Used to filter rows based on another query result
SELECT emp_name, salary
FROM employee
WHERE salary > (
    SELECT AVG(salary)
    FROM employee
);
