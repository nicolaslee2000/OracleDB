CREATE TABLE students(
    name varchar(20),
    age number(1),
    avg number(5,2),
    hire_date date
    );
    
INSERT INTO STUDENTS(name, age, avg, hire_date)
VALUES('nick', 20, 54.53, sysdate);


SELECT *
FROM all_constraints cons, all_cons_columns cols
WHERE cols.table_name = 'STUDENTS'
AND cons.constraint_name = cols.constraint_name
AND cons.owner = cols.owner
ORDER BY cols.table_name, cols.position;

ALTER TABLE students 
ADD CONSTRAINT student_id_primarykey PRIMARY KEY (student_id);

ALTER TABLE students drop constraint name_primarykey_constraint;

SELECT *
  FROM user_cons_columns
 WHERE table_name = 'STUDENTS';
 
 ALTER TABLE students 
 ADD student_id number(5) ;

UPDATE students 
SET student_id = students_student_id_seq.nextval;
 
CREATE SEQUENCE students_student_id_seq
    INCREMENT BY 1
    START WITH 1
    NOCYCLE
    NOCACHE;

ALTER TABLE students ADD CONSTRAINT age_constraint CHECK(age BETWEEN 20 AND 50);
DESC students;

SELECT * FROM user_constraints;

SELECT * FROM user_users;
SELECT * FROM dba_users;