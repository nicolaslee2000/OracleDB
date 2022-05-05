SET SERVEROUTPUT ON;
DECLARE
    vempno employees.employee_id%type;
    vname employees.first_name%type;
    vdeptno employees.department_id%type;
    vdname varchar2(20);
BEGIN
    SELECT employee_id, first_name, department_id
        INTO vempno, vname, vdeptno
        FROM employees
        WHERE employee_id = 100;
        
    CASE vdeptno
        WHEN 10 THEN vdname := 'ACCOUNT';
        WHEN 20 THEN vdname := 'RESEARCH';
        WHEN 30 THEN vdname := 'SALES';
        WHEN 40 THEN vdname := 'OPERATIONS';
        ELSE vdname := 'OTHER';
        
    END CASE;
    dbms_output.put_line(vempno || vname || vdeptno || vdname);
END;
/

SELECT employee_id, first_name, department_id,

CASE employee_id
        WHEN 10 THEN 20
        WHEN 20 THEN 40
        WHEN 30 THEN 60
        ELSE 90
        
    END
        FROM employees
        WHERE employee_id = 100;
        
DECLARE 
    num number := 1;
BEGIN
    WHILE num < 6 LOOP
        dbms_output.put_line(num);
        num := num + 1;
    END LOOP;
END;
/

DECLARE 
    num number := &num;
BEGIN
    FOR i IN 1..9 LOOP
    dbms_output.put_line(num||'X'||i||'='||num*i);
    END LOOP;
END;
/
    
--take 2 dept_id as input. pritout employee_id, first)name, salary, department_id where dept_id > first input and < last input
--using table type
--practicing table type
DECLARE
    
    dept_id1 employees.department_id%TYPE:= &dept_id1;
    dept_id2 employees.department_id%TYPE:= &dept_id2;
    
    CURSOR c_employee IS
        SELECT employee_id, first_name, salary, department_id
        FROM employees
        WHERE department_id > dept_id1 AND department_id < dept_id2;
        
    record_employee c_employee%ROWTYPE;

    TYPE tbl_employee_type 
    IS TABLE OF record_employee%TYPE
    INDEX BY binary_integer;
    
    tbl_employee tbl_employee_type;

BEGIN
    OPEN c_employee;
        FOR i IN 1..20
        LOOP
            FETCH c_employee INTO tbl_employee(i);
            EXIT WHEN c_employee%NOTFOUND;
            dbms_output.put_line(tbl_employee(i).first_name||tbl_employee(i).employee_id||tbl_employee(i).department_id);
        END LOOP;
END;
/
SELECT * FROM employees WHERE department_id > 100 AND department_id < 200;
--alternatively using bulk collect into/forall
DECLARE
    
    CURSOR c_employee IS
        SELECT employee_id, first_name, salary, department_id
        FROM employees
        WHERE department_id > 50 AND department_id < 200;
        
    record_employee c_employee%ROWTYPE;

    TYPE tbl_employee_type 
    IS TABLE OF record_employee%TYPE
    INDEX BY binary_integer;
    
    tbl_employee tbl_employee_type;

BEGIN
    OPEN c_employee;
    FETCH c_employee
    BULK COLLECT INTO tbl_employee;
    CLOSE c_employee;
    
    FOR i IN tbl_employee.first..tbl_employee.last
        LOOP
        dbms_output.put_line(tbl_employee(i).department_id||tbl_employee(i).first_name);
        END LOOP;
END;
/

--procedures
CREATE OR REPLACE PROCEDURE greetings(name IN varchar2, y OUT varchar2)
IS
txt varchar2(20);
BEGIN
    y := name||'hello';
    
END;
/


SELECT * FROM user_procedures;
SELECT * FROM user_source;
EXECUTE greetings('yoman');

--trying function
--CREATE OR REPLACE FUNCTION deptTotalSalary(deptId IN number)
    


CREATE TABLE emp
AS
(SELECT employee_id, first_name, salary
FROM employees);

CREATE OR REPLACE PROCEDURE pro_inmode
(emp_id IN emp.employee_id%TYPE)
IS 
BEGIN
    UPDATE emp
    SET salary = salary *1.5
    WHERE employee_id = emp_id;
END;
/
SELECT * FROM emp
WHERE employee_id = 100;
EXECUTE pro_inmode(100);

CREATE OR REPLACE PROCEDURE pro_outmode
(
    id IN emp.employee_id%type,
    name OUT employees.first_name%type,
    avg_salary OUT employees.salary%TYPE,
    deptname OUT departments.department_name%TYPE
)
IS
    deptid number;
BEGIN
    SELECT first_name, department_id
    INTO name, deptid
    FROM employees
    WHERE employee_id = id;
    
    SELECT d.department_name, (SELECT ROUND(AVG(salary))FROM employees WHERE department_id = deptid) avg_sal
    INTO deptname, avg_salary
    FROM departments d
    WHERE d.department_id = deptid;
    
END;
/
var name varchar2;
var salary number;
var deptname varchar2;
EXECUTE pro_outmode(200, :name, :salary, :deptname);
print name;
print salary;
print deptname;


CREATE OR REPLACE PROCEDURE inoutmode(
    salary IN OUT varchar2
)
IS
BEGIN
    salary := '&' || substr(salary, -9, 3) || ',' || substr(salary, -6, 3) || 
    ',' || substr(salary, -3, 3);
END;
/
var slry varchar2(20);
EXECUTE inoutmode(:slry);
print slry;
EXEC :slry := '123455678';

SELECT * FROM mem;

CREATE OR REPLACE PROCEDURE pro_othermode
(
    name IN mem.name%type,
    location IN mem.loc%TYPE default 'seoul'
)
IS
BEGIN
    INSERT INTO mem
    VALUES(mem_num_seq.nextval, name, 40, location);
END;
/

BEGIN
    pro_othermode('jake', 'vegas');
    pro_othermode(name => 'luke');
END;
/

--function
CREATE OR REPLACE FUNCTION func01
(
    deptId IN employees.department_id%type
)
RETURN char
IS
    deptName departments.department_name%Type;
BEGIN
    SELECT department_name INTO deptName
    FROM departments
    WHERE department_id = deptId;
    RETURN deptName;
END;
/


BEGIN
    dbms_output.put_line(func01(100));
END;
/
