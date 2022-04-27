
UPDATE dept01
SET deptno = 50
WHERE deptno = 20;

SELECT view_name
FROM user_views;

CREATE TABLE emp01_copy
AS 
SELECT * FROM employees;

CREATE VIEW emp01_view(employee_id, first_name, department_id)
AS SELECT employee_id, first_name, department_id
FROM emp01_copy;

SELECT * FROM emp01_view;

SELECT * FROM user_views;