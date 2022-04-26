SELECT department_id, job_id, count(*)
FROm employees
GROUP BY department_id, job_id
ORDER BY department_id, job_id;

SELECT department_id, job_id, count(*)
FROM employees
GROUP BY rollup(department_id, job_id)
ORDER BY department_id, job_id;

--grouping
SELECT DECODE(
            grouping(d.department_name)
            ,1, 'ALL Departments',
            d.department_name) AS "DNAME",
            DECODE(
            grouping(e.job_id)
            ,1, 'ALL JOBS',
            e.job_id) AS "ALL JOBS",
COUNT(*) AS "TOTAL",
SUM(e.salary) AS "total sal"
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
GROUP BY d.department_name, ROLLUP(job_id);

SELECT d.department_id,
e.job_id,
COUNT(*) AS "TOTAL",
SUM(e.salary) AS "total sal"
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
GROUP BY d.department_name, ROLLUP(job_id);

--rank, sum over

SELECT job_id, max(salary) over(PARTITION BY job_id)
FROM employees;