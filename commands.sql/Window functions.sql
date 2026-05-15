--Window functions in SQL
--1.Aggregate window function 
SELECT student_id,student_name,branch,
AVG(fees) OVER (PARTITION BY branch) AS avg_fees 
FROM student
GROUP BY student_id,student_name,branch;

--2.Row_Number():-Assigining unique value for each record 
SELECT student_id,student_name,
ROW_NUMBER() OVER (PARTITION BY branch ORDER BY fees ASC) as rn
FROM student
GROUP BY student_id,student_name;

SELECT student_id,student_name,
ROW_NUMBER() OVER (PARTITION BY branch ORDER BY fees DESC ) as rn
FROM student
GROUP BY student_id,student_name;

--Q.fetch first 2students from each department join the college.
SELECT * FROM (
              SELECT student_id,student_name,branch,
              ROW_NUMBER() OVER (PARTITION BY branch ORDER BY fees ASC) as rn
              FROM student) s
			  WHERE s.rn <2;

--RANK():-assigning same fees for same rank,if it has same rank,will skip
--Q.fetch first 3 students from each department pay in  max salary.
SELECT * FROM (
              SELECT student_id,student_name,branch,
              RANK() OVER (PARTITION BY branch ORDER BY fees DESC) as rn
              FROM student) s
			  WHERE s.rn < 3;

--DENSE_RANK()
SELECT * FROM (
              SELECT student_id,student_name,branch ,
              RANK() OVER (PARTITION BY branch ORDER BY fees DESC) as rnk,
			  DENSE_RANK() OVER (PARTITION BY branch ORDER BY fees DESC) as dense_rnk
              FROM student) s;

--LEAD()&LAG()
--Q.fetch a query to display if the fees of an student is high,low or equal to previous student.
SELECT student_id,student_name,branch,fees,
LAG(fees) OVER (PARTITION BY branch ORDER BY fees DESC) as prev_fees
FROM student s;

SELECT student_id,student_name,branch,fees,
LEAD(fees) OVER (PARTITION BY branch ORDER BY fees DESC) as next_fees
FROM student s;

SELECT student_id,student_name,branch,fees,
LAG(fees) OVER (PARTITION BY  branch ORDER BY fees DESC) as prev_student_fees,
LEAD(fees) OVER (PARTITION BY branch ORDER BY fees DESC) as next_student_fees
FROM student s;

--Also using CASE STATEMENT
SELECT student_id,student_name,department,
LAG(fees) OVER (PARTITION BY department ORDER BY fees DESC) as prev_student_fees,
CASE WHEN s.fees > LAG(fees) OVER (PARTITION BY department ORDER BY fees DESC) then 'higher than previous student'
     WHEN s.fees < LAG(fees) OVER (PARTITION BY department ORDER BY fees DESC) then 'lower than previous student' 
     WHEN s.fees = LAG(fees) OVER (PARTITION BY department ORDER BY fees DESC)  then 'same as previous student'
     END AS fees_range
FROM students s;

--FIRST VALUE()
--Q.Fetch a query highest fees under each department(corresponding to each record).
SELECT *,
FIRST_VALUE(fees) OVER (PARTITION BY branch ORDER BY fees ASC ) as highest_fees
FROM student;

--LAST_VALUE()
--Q.Fetch a query lowest fees under each department(corresponding to each record).
SELECT *,
FIRST_VALUE(fees) 
       OVER (PARTITION BY branch ORDER BY fees ASC) 
       as highest_fees,
LAST_VALUE(fees) 
       OVER (PARTITION BY branch ORDER BY fees ASC
	   range between unbounded preceding and unbounded following)
       as lowest_fees
FROM student
WHERE branch='IT';

--Average of last 3departments(real world problem)
SELECT student_id,fees,
AVG(fees) 
    OVER (ORDER by student_id
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW ) 
	AS average
FROM student;

--ROWS BETWEEN UNBOUNDED PRECEDING
SELECT student_id,fees,
SUM(fees) 
    OVER (ORDER by student_id
    ROWS BETWEEN  UNBOUNDED PRECEDING AND CURRENT ROW ) 
	AS total
FROM students;

--Alternate to write query using windownfunctions.
SELECT *,
FIRST_VALUE(fees) 
       OVER w as highest_fees,
LAST_VALUE(fees) 
       OVER w as lowest_fees
FROM student
WHERE branch='IT'
window w as (PARTITION BY branch ORDER BY fees ASC
	   range between unbounded preceding and unbounded following);

--NTH_VALUE()
--fetch query to display the second highest fees paid under each category.
SELECT *,
     FIRST_VALUE(fees) OVER w as highest_fees,
     LAST_VALUE(fees) OVER w as lowest_fees,
     nth_value(fees, 2) OVER w as second_highest_fees
FROM student
window w as (PARTITION BY branch ORDER BY fees DESC
            rows between unbounded preceding and unbounded following);
	   
--NTILE: Divide records into top/middle/low 
SELECT *,
NTILE(3) OVER (ORDER BY fees asc) AS other_fees
FROM students;

--Also using as 'WHEN' statement(filter condition)
SELECT fees,
CASE WHEN x.other_fees=1 then 'top fees'
     WHEN x.other_fees=2 then 'middle fees'
     WHEN x.other_fees=3 then 'lowest fees' END fees
from (
     SELECT *,
     NTILE(3) OVER (ORDER BY fees asc) AS other_fees
     FROM students
	 Where department='IT') x;

--CUME_DIST()
--Real-world use case as percentage of students less than or equal
SELECT *,
CUME_DIST() OVER (ORDER BY fees asc) AS cume_fees
FROM student; 

--PERCENT_RANK()
SELECT *,
PERCENT_RANK() OVER (ORDER BY fees asc) AS other_fees,
round(PERCENT_RANK() OVER (ORDER BY fees asc)::numeric *100,2)  AS percent_rank
FROM student; 

--Q.Query to identify how much percentage more highest in department IT when compared to all students.
SELECT branch,fees
FROM (
       SELECT *,
       PERCENT_RANK() OVER (ORDER BY fees asc) AS other_fees,
       round(PERCENT_RANK() OVER (ORDER BY fees asc)::numeric *100,2) as other_rank
       FROM student x
WHERE x.branch='IT');
