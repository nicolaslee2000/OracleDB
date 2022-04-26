SELECT * FROM tab;

SELECT * FROM locations;

-- alias

SELECT salary, salary*10 AS bonus FROM EMPLOYEES;

SELECT last_name || '''s salary is ' || salary AS name FROM EMPLOYEES;

SELECT DISTINCT first_name FROM employees;

-- order of syntax
SELECT column1, column2 FROM table_name WHERE column_name = 'value'
GROUP BY column_name
HAVING column_name='value' ORDER BY column_name ASC(DESC);

--order of sql
-- from, where, group by, having, select, order by

SELECT first_name, salary 
FROM employees 
WHERE salary < 3000;

SELECT first_name, salary FROM employees WHERE first_name != 'David';
