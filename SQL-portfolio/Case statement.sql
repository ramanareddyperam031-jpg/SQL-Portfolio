--CASE STATEMENT 
SELECT student_id,fees,
CASE   WHEN fees >=90000 THEN 'high fees'
       WHEN  fees  BETWEEN 50000 AND 80000 THEN 'average fees'
	   WHEN fees  <=20000 THEN 'too low'
	   ELSE 'other'
END AS range
FROM  student
ORDER BY 2 ASC;
