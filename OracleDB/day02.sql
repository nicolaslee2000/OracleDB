SELECT first_name, salary, hire_date FROM employees ORDER BY hire_date DESC;

SELECT first_name, job_id, salary FROM employees WHERE job_id = 'FI_ACCOUNT' ORDER BY salary DESC;

/*
1) employees���̺��� �޿��� 17000������ ����� �����ȣ, �����(first_name), �޿��� ����Ͻÿ�.
 SELECT employee_id, first_name, salary
 */
SELECT employee_id, first_name, salary FROM employees WHERE salary <= 17000;
/*
2) employees���̺��� 2005�� 1�� 1�� ���Ŀ� �Ի��� ����� ����Ͻÿ�.
*/
SELECT * FROM employees WHERE hire_date >= '2005-01-01';
/*

3) employees���̺��� �޿��� 5000�̻��̰� ����(job_id)�� 'IT_PROG'�� ����� �����(first_name), �޿�, 
   ������ ����Ͻÿ�.
   */
SELECT first_name, salary FROM employees WHERE salary >= 5000 and job_id = 'IT_PROG';

/*
4) employees���̺��� �μ���ȣ�� 10, 40, 50 �� ����� �����(first_name), �μ���ȣ, �̸���(email)�� ����Ͻÿ�.
*/
SELECT first_name, department_id, email FROM employees WHERE department_id in(10,40,50);

--5) employees���̺��� �����(first_name)�� even�� ���Ե� �����,�޿�,�Ի����� ����Ͻÿ�.
SELECT first_name, salary, hire_date FROM employees WHERE first_name LIKE '%even%';

--6) employees���̺��� �����(first_name)�� teve�յڿ� ���ڰ� �ϳ��� �ִ� �����,�޿�,�Ի����� ����Ͻÿ�.
SELECT first_name, salary, hire_date FROM employees WHERE first_name LIKE '%_teve_%';

--7) employees���̺��� �޿��� 17000�����̰� Ŀ�̼��� null�� �ƴҶ��� �����(first_name), �޿�, 
--  Ŀ�̼��� ����Ͻÿ�.
SELECT first_name, salary, commission_pct FROM employees WHERE salary<=17000 AND commission_pct IS NOT null;

--8) 2005�⵵�� �Ի��� ����� �����(first_name),�Ի����� ����Ͻÿ�.
SELECT first_name, hire_date FROM employees WHERE EXTRACT(YEAR FROM hire_date) = 2005;

--9) Ŀ�̼� ���� ����� ����� �����(first_name), Ŀ�̼��� ����Ͻÿ�.
SELECT first_name, commission_pct FROM employees WHERE commission_pct IS NOT null;

--10) ����� 206�� ����� �̸�(first_name)�� �޿��� ����Ͻÿ�.
SELECT first_name, salary FROM employees WHERE employee_id = 206;

--11) �޿��� 3000�� �Ѵ� ����(job_id),�޿�(salary)�� ����Ͻÿ�.
SELECT job_id, salary FROm employees WHERE salary > 3000;

--12)'ST_MAN'������ ������ ������� �����(first_name)�� ����(job_id)�� ����Ͻÿ�.
SELECT first_name, job_id FROM employees WHERE NOT job_id = 'ST_MAN';


--13) ������ 'PU_CLERK' �� ��� �߿��� �޿��� 10000 �̻��� �����(first_name),����(job_id),�޿�(salary)�� ����Ͻÿ�.
SELECT first_name, job_id, salary FROM employees WHERE job_id = 'PU_CLERK' AND salary > 10000;

--14) commission�� �޴� �����(first_name)�� ����Ͻÿ�.
SELECT first_name FROm employees WHERE commission_pct IS NOT null;

--15) 20�� �μ��� 30�� �μ��� ���� ����� �����(fist_name), �μ��� ����Ͻÿ�.
SELECT first_name, department_id FROM employees where department_id IN(20,30);

--16) �޿��� ���� ������� ����ϵ� �޿��� ���� ��� �����(first_name) ������� ����Ͻÿ�.
SELECT first_name, salary FROM employees ORDER BY salary DESC;

--17) ������ 'MAN' ������ ����� �����(first_name), �޿�(salary), ����(job_id)�� ����Ͻÿ�.
SELECT first_name, salary, job_id FROM employees WHERE job_id LIKE '%MAN';

SELECT * FROM NLS_SESSION_PARAMETERS WHERE parameter = 'NLS_DATE_FORMAT';

--UNION
SELECT department_id, first_name, last_name
FROM employees
WHERE department_id = 20 OR department_id = 40
MINUS
SELECT department_id, first_name, last_name 
FROM employees
WHERE department_id = 20 OR department_id = 60;