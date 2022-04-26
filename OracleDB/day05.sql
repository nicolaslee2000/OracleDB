CREATE TABLE emp01
AS
SELECT first_name, salary
FROM employees
WHERE 1=0;
DROP TABLE emp01;
SELECT * FROM emp01;
DESC emp01;

INSERT INTO emp01(first_name, salary)
VALUES(
(SELECT first_name
FROM employees
WHERE ROWNUM < 2),
(SELECT first_name
FROM employees
WHERE ROWNUM < 2)
);

COMMIT WORK;
UPDATE emp01
SET salary = 8000
WHERE first_name = 'candy';

INSERT INTO emp01
VALUES('jon', 3000);
SELECT * FROM emp01;
SAVEPOINT sp;
DELETE FROM emp01 WHERE first_name = 'jon';
ROLLBACK TO sp;

CREATE TABLE emp02(
emp_id number primary key,
first_name varchar2(50),
salary number);
DROP TABLE emp02;