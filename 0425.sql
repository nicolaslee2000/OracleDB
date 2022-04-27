
CREATE TABLE mem(
  num number ,
  name varchar2(50),
  age number,
  loc varchar2(30));
    
  SELECT * FROM mem;
   DROP SEQUENCE mem_num_sq;
   
  CREATE SEQUENCE mem_num_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;
     
  SELECT * FROM user_sequences;
  
  INSERT INTO mem
  VALUES (mem_num_seq.nextval, '고수', 30, '서울');
  
  SELECT * FROM mem;
  commit;
  
  
  SELECT * FROM employees;
  
  SELECT e.employee_id, e.first_name, e.hire_date, e.salary, d.department_name
  FROM employees e, departments d
  WHERE e.department_id=d.department_id
  ORDER BY e.employee_id;
  

  
  
  
  