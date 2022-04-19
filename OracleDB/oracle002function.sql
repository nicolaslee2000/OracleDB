SELECT * FROM employees;

SELECT initcap('dfj') FROM dual;
SELECT upper('doyoufeelit') FROM dual;

SELECT first_name, salary FROM employees WHERE LOWER(first_name) LIKE LOWER('%JA%');

SELECT LENGTH('ENGLISH') FROM dual; 

CREATE TABLE user1 (
    data varchar2 (5)
);

SELECT * FROM user1;
INSERT INTO user1(data) VALUES('KOREA');

SELECT SUBSTR('ABCDEFG',-7,4) FROM dual;

SELECT job_id, COUNT(job_id) FROM employees GROUP BY job_id;

SELECT EXTRACT(YEAR FROM ADD_MONTHS(sysdate, 9000)) FROM dual;
SELECT TO_CHAR(2040, 'L999,999.9') FROM dual;

SELECT first_name || 'joined the company on ' || TO_CHAR(hire_date, 'fmDdth Month yyyy')
FROM employees
WHERE first_name = 'Steven';

--NVL
SELECT first_name, NVL(commission_pct, 0)
FROM employees;

SELECT first_name, NVL(TO_CHAR(manager_id), 'CEO') manager
FROM employees;

SELECT first_name, job_id, salary, salary* DECODE(job_id, 'IT_PROG', 1.1, 'PU_CLERK', 2, 1) AS "New Salary"
FROM employees 
ORDER BY "New Salary";
