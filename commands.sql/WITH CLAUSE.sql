---Sql WITH CLAUSE
--Q1.get students with fees > 50k
WITH high_fees AS (
      SELECT student_name,student_id,fees 
      FROM student 
      WHERE fees > 50000
)
SELECT * FROM high_fees;

--Q2.Find students who's fees where better than the avrg fees across all students.
--STEP  BY STEP QUERY
SELECT s.student_id, SUM(fees) AS total_fees_per_student
FROM students s
GROUP BY student_id;

SELECT  cast(AVG(total_fees_per_student) AS INT) AS avg_fees_for_all_student
FROM total_fees
GROUP BY student_id) x) avg_fees


SELECT * 
FROM (SELECT s.student_id, SUM(fees) AS total_fees_per_student
      FROM students s
	  GROUP BY student_id) total_fees
JOIN (SELECT  cast(AVG(total_fees_per_student) AS INT) AS avg_fees_for_all_student
     FROM(SELECT s.student_id, SUM(fees) AS total_fees_per_student
     FROM students s
     GROUP BY student_id) x) avg_fees 
	 ON total_fees.total_fees_per_student >avg_fees.avg_fees_for_all_student;

--USING WITH CLAUSE 
WITH total_fees(student_id,total_fees_per_student) AS 
               (SELECT s.student_id, SUM(fees) AS total_fees_per_student
                FROM students s
                GROUP BY student_id),
avg_fees (avg_fees_for_all_student) AS 
             (SELECT  cast(AVG(total_fees_per_student) AS INT) AS avg_fees_for_all_student
             FROM total_fees)

SELECT * 
FROM total_fees tf
JOIN avg_fees af ON tf.total_fees_per_student >af.avg_fees_for_all_student;
