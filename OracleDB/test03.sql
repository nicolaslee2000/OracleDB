SELECT emp.mth, emp."COUNT(*)"
FROM 
(
SELECT EXTRACT(MONTH FROM hire_date) AS mth, COUNT(*)
FROM employees
GROUP BY EXTRACT(MONTH FROM hire_date)
ORDER BY COUNT(*) DESC) emp
WHERE rownum <= 3;
--1
SELECT first_name, salary, department_id
FROM employees e
WHERE salary = (
            SELECT MAX(salary)
            FROM employees
            WHERE department_id = e.department_id)
    ORDER BY department_id;
--2
SELECT first_name, salary, department_id
FROM employees e
WHERE (department_id, salary) IN (SELECT department_id, MAX(salary)
                                    FROM employees
                                    GROUP BY department_id)
                                ORDER BY department_id;
                                
--has manager
SELECT e.employee_id, e.first_name, e.manager_id
FROM employees e
WHERE EXISTS(
SELECT d.employee_id
FROM employees d
WHERE e.manager_id = d.employee_id);

--first_names of employees whos department name has 'it' in it
SELECT e.first_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id AND
e.department_id IN(
SELECT department_id
FROM departments
WHERE department_name LIKE '%it%'
);

--first_name of employees whos salary is greater than min salary of employees in toronto exclude toronto

SELECT e.first_name, l.city, e.salary
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
INNER JOIN locations l
ON d.LOCATION_ID = l.location_id
WHERE e.salary > (
    SELECT min(h.salary)
    FROM employees h
    WHERE h.department_id = 
    (
        SELECT department_id
        FROM departments
        WHERE location_id = (
            SELECT location_id
            FROM locations
            WHERE city = 'Toronto'
        )
     )   
)
ORDER BY  salary DESC;

--select first_name, hire_date, salary of top 5 - 10

SELECT e.salary
FROM (
    SELECT emp.salary, ROWNUM AS rm
    FROM (
        SELECT first_name, hire_date, salary
        FROM employees
        ORDER BY salary DESC
        ) emp
    ) e
WHERE e.rm >= 5 AND e.rm <= 10;
