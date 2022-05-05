SET SERVEROUTPUT ON;
DECLARE
    vno number(20);
    vname varchar2(20);
begin
    SELECT salary, first_name INTO vno, vname
    FROM employees
    WHERE employee_id = 100;
    DBMS_OUTPUT.put_line(vno || '  ' || vname);
END;
/

DECLARE
    vno number(20);
    vname varchar2(20);
begin
    SELECT salary, first_name INTO vno, vname
    FROM employees
    WHERE employee_id = &employee_id;
    DBMS_OUTPUT.put_line(vno || '  ' || vname);
END;
/

CREATE TABLE emp_test(
    no number, name varchar(20));
    
CREATE SEQUENCE emp_test_no_seq
START WITH 1
INCREMENT BY 1;

BEGIN 
    INSERT INTO emp_test
    VALUES(emp_test_no_seq.nextval, 'kim');
END;
/

SELECT * FROM emp_test;

DECLARE 
    v_no number := '&no';
    v_name varchar2(20) := '&name';
    
BEGIN 
    INSERT INTO emp_test
    VALUES(v_no, v_name);
END;
/
--merge

CREATE TABLE emp_test02(
    no number,
    first varchar(20),
    last varchar2(20));

INSERT INTO emp_test02
values(200, 'crhs', 'bev');
SELECT * FROM emp_test;
SELECT * FROM emp_test02;
COMMIT;

BEGIN
    MERGE INTO emp_test02 e2
    USING emp_test e1
    ON(e1.no = e2.no)
        WHEN matched THEN
            UPDATE SET e2.first=e1.name
        WHEN NOT matched then
            INSERT VALUES(e1.no, e1.name, null);
END;
/

--scalar variable
DECLARE 
    num number := 10;
    name varchar2(20) := 'hong';
    hire date default sysdate;
BEGIN
    dbms_output.put_line(num || name || hire);
END;
/

--REFERENCE VARIABLE %TYPE
DECLARE 
    num employees.employee_id%type := 10;
    name employees.first_name%type := 'hong';
    hire employees.hire_date%type default sysdate;
BEGIN
    SELECT employee_id, first_name, hire_date INTO num, name, hire
    FROM employees
    WHERE employee_id = 100;
    dbms_output.put_line(num || name || hire);
END;
/

DECLARE 
    emp employees%rowtype;
BEGIN
    SELECT * INTO emp
    FROM employees
    WHERE employee_id = 100;
    dbms_output.put_line(emp.employee_id);
END;
/

DECLARE 
    num employees.employee_id%type := 10;
    name employees.first_name%type := 'hong';
    depid employees.department_id%type := 333;
    dep departments.department_name%type := 'randomname';
BEGIN
    SELECT e.employee_id, e.first_name, e.department_id, d.department_name
    INTO num, name, depid, dep
    FROM employees e
    INNER JOIN departments d
    ON e.department_id = d.department_id
    WHERE employee_id = 100;
    dbms_output.put_line(num || name || depid || dep);
END;
/

--adding two input
DECLARE 
num1 number := &num1;
num2 number := &num2;
result number := 0;
BEGIN
    result := num1 + num2;
    dbms_output.put_line(result);
END;
/

--record type
DECLARE 
    TYPE emp_record_type IS RECORD(
        emp_id employees.employee_id%type,
        emp_name employees.first_name%type,
        emp_salary employees.salary%type,
        emp_hire employees.hire_date%type
        );
        
    v_emp emp_record_type;
BEGIN
    SELECT 1 INTO v_emp.emp_id FROM dual;
END;
/


--use record type to put department_id, department_name, city to record type and print out
DECLARE
    TYPE dept_record_type IS RECORD(
        id departments.department_id%type,
        name departments.department_name%type,
        city locations.city%type
        );
    dRecord dept_record_type;
BEGIN
    SELECT d.department_id, d.department_name, l.city
    INTO dRecord.id, dRecord.name, dRecord.city
    FROM departments d
    INNER JOIN locations l
    ON d.location_id = l.location_id
    WHERE department_id = 30;
    dbms_output.put_line(dRecord.id || dRecord.name || dRecord.city);
END;
/
--trying cursor
DECLARE
    CURSOR cursor_deptLoc IS
        SELECT d.department_id, d.department_name, l.city
        FROM departments d
        INNER JOIN locations l
        ON d.location_id = l.location_id
        WHERE department_id = 30;
    dRecord cursor_deptLoc%rowtype;
BEGIN
    OPEN cursor_deptLoc;
    FETCH cursor_deptLoc INTO dRecord;
    dbms_output.put_line(dRecord.department_id || dRecord.department_name || dRecord.city);
END;
/
--looping upper statement
DECLARE
    CURSOR cursor_deptLoc IS
        SELECT d.department_id, d.department_name, l.city
        FROM departments d
        INNER JOIN locations l
        ON d.location_id = l.location_id;
    dRecord cursor_deptLoc%rowtype;
BEGIN
    OPEN cursor_deptLoc;
    LOOP
        FETCH cursor_deptLoc INTO dRecord;
        EXIT WHEN cursor_deptLoc%NOTFOUND;
        dbms_output.put_line(dRecord.department_id || dRecord.department_name || dRecord.city);
    END LOOP;
END;
/

--using record type get input of employee_id and print out employee_id, first_name, hrie_date and salary/

DECLARE
--declaring input first so that cursor targets that row only
    emp_id employees.employee_id%type := &emp_id;
    CURSOR c_employee IS
        SELECT employee_id, first_name, hire_date, salary
        FROM employees
        WHERE employee_id = emp_id;
    v_emp c_employee%rowtype;
    
BEGIN
    OPEN c_employee;
    FETCH c_employee INTO v_emp;
    dbms_output.put_line(v_emp.employee_id || v_emp.first_name || v_emp.hire_date || v_emp.salary);
END;
/

--table type
DECLARE
    t_name varchar2(20);
    TYPE tbl_emp_name IS TABLE OF
        employees.first_name%TYPE
        INDEX BY binary_integer;
        
    v_name tbl_emp_name;
    i binary_integer := 0;
BEGIN
    FOR j IN (SELECT first_name FROM employees) LOOP
        i := i +1;
        v_name(i) := j.first_name;

    END LOOP;
    FOR j in 1..i loop
        dbms_output.put_line(v_name(j));
    END LOOP;
END;
/

--bind variable
--sql>variable v_bind number;

BEGIN
    SELECT salary INTO :v_bind
    FROM employees
    WHERE employee_id = 100;
END;
/

--print v_bind;
--if condition
DECLARE
    CURSOR c_employee IS
        SELECT employee_id, first_name, department_id
        FROM employees;
    v_emp c_employee%rowtype;
    
BEGIN
    OPEN c_employee;
    LOOP
        FETCH c_employee INTO v_emp;
        EXIT WHEN c_employee%NOTFOUND;
    END LOOP;
    
END; 