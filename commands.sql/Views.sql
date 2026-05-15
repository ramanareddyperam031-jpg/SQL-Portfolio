--VIEWS IN SQL
--Q.Fetch top most students who score more tan 50.
---CREATE OR REPLACE VIEW 
CREATE VIEW top_student AS
SELECT student_name, branch,marks,email
FROM student
WHERE marks > 50;

SELECT * FROM top_student
WHERE marks >20;

SELECT * FROM top_student;

--MODIFYNG OF VIEW(ALTER,UPDATE,DROP)
ALTER VIEW top_student
RENAME column student_name to std_name;

ALTER VIEW top_student
RENAME column branch to dept_name;

ALTER TABLE top_student
ADD COLUMN student_id VARCHAR(30)   --NOT PERFORMED 

--UPDATE VIEWS
UPDATE top_student
SET marks= 60
WHERE  dept_name= 'IT';


CREATE VIEW total_mark
AS 
SELECT marks,COUNT(*) AS total_mark
FROM top_student
GROUP BY marks;

SELECT * FROM total_mark;

--WITH CHECK OPTION 
CREATE  OR REPLACE VIEW main_students
AS
SELECT * FROM top_student
WHERE marks >20
WITH CHECK OPTION;
