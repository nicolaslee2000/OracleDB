show user;
/*===================================================================================
PL/SQL : Procedural Language extension to SQL(SQL을 확장한 절차적 언어)
PL/SQL의 프로그램 종류:  Procedure, Function, Trigger

PL/SQL은 Oracle's Procedural Language extension to SQL의 약자이다.
PL/SQL은 SQL에 없는 변수선언, 비교처리(if), 반복문처리(loop, while, for)
등을 제공하고 있다.

PL/SQL은 기본적으로 블록(Block)구조를 가지고 있다.
블록의 기본적인 구성은 declare(선언부) ~ executable(실행부) ~ exception(예외처리부)이다.

PL/SQL BLOCK기본 구성
 Declare(선언부) : 모든 변수나 상수를 선언하는 부분이다.
 Executable(실행부) : 제어문, 반복문, 함수정의 등의 로직을 기술한다.
 Exception(예외처리부) : 실행 도중 에러 실행시 해결하는 문장들을 기술한다.

PL/SQL블록구조에서 선언부와 예외처리부는 생략이 가능하지만 실행부는 생략할 수 없다.

PL/SQL 프로그램의 작성방법
 PL/SQL 블록 내에서는 한 문장을 종료할때마다 세미콜론(;)을 사용한다.
 END뒤에 ;을 사용하여 하나의 블록이 끝났다는 것을 명시합니다.
 PL/SQL 블록은 편집기를 통해 파일로 작성 할 수 도 있고, 프롬프트에서 바로 작성할 수도 있다.
 SQL*PLUS 환경에서는 Delclare나 Begin이라는 키워드로 PL/SQL블록이 시작하는 것을 알 수 있다.
 --단일행 주석은 --이고 여러행 주석은  /* */이다.
 --쿼리문을 수행하기 위해서 /가 반드시 입력되어야 하며,  PL/SQL 블록은 행에 /가 있으면 종결된 것으로 간주한다.
 /*========================================================================================*/
 
 /*
 PL/SQL은 기본적으로 처리된 PL/SQL문장의 결과를 화면에 출력하지 않는다.
 그래서 결과를 화면에 출력하기 위해서는 화면 출력 기능을 활성화 시켜야 한다.
 */
 SET SERVEROUTPUT ON;
 
 DECLARE
   -- SELECT을 수행한 결과를 저장한 변수 선언
    vno number(20);
    vname varchar2(20);
 BEGIN
    --SELECT 수행 결과를 INTO 다음의 변수에 저장
    SELECT salary, first_name INTO vno, vname
    FROM employees
    WHERE employee_id=100;
    --두 변수에 저장된 값을 화면에 출력
    DBMS_OUTPUT.put_line(vno ||'   ' || vname);
 END;
 /  -- 작성된 PL/SQL 블록을 실행시킨다.
 
--------------------------------------------------------------------------------- 
 PL/SQL내에서의  SELECT문장 사용하기
 SELECT column_name, column_name, column_name 
 INTO variable_name, variable_name, variable_name
 FROM table_name
 [WHERE condition];
 
 PL/SQL에서 데이터를 조회한 후 INTO 절에 있는 변수에 조회된 데이터를 저장할 수 있다.
 그래서 SELECT절의 column와 INTO절의 variable의 갯수와 타입이 같아야 한다.
 ---------------------------------------------------------------------------
 -- 사용자에게 값을 입력받아서 변수에 할당 할때는 '&(앰퍼샌트)'기호를 사용한다.
 DECLARE
   vno number(20);
   vname varchar2(20);
 BEGIN
   SELECT salary, first_name INTO vno, vname
    FROM employees
    WHERE employee_id=&employee_id;
    
   DBMS_OUTPUT.put_line(vno ||'   ' || vname);
 END;
 /
 
---------------------------------------------------------------------------
--dbms_output 패키지에 정의된 프로시저 확인
DESC dbms_output
 
PROCEDURE DISABLE
PROCEDURE ENABLE
인수 이름                          유형                                                                                                                입/출력      기본값?                                                                            
------------------------------ ----------------------------------------------------------------------------------------------------------------- --------- --------------------------------------------------------------------------------
BUFFER_SIZE                    NUMBER(38)                                                                                                        IN                                                                                        

PROCEDURE GET_LINE
인수 이름                          유형                                                                                                                입/출력      기본값?                                                                            
------------------------------ ----------------------------------------------------------------------------------------------------------------- --------- --------------------------------------------------------------------------------
LINE                           VARCHAR2                                                                                                          OUT                                                                                       
STATUS                         NUMBER(38)                                                                                                        OUT                                                                                       

PROCEDURE GET_LINES
인수 이름                          유형                                                                                                                입/출력      기본값?                                                                            
------------------------------ ----------------------------------------------------------------------------------------------------------------- --------- --------------------------------------------------------------------------------
LINES                          TABLE OF VARCHAR2(32767)                                                                                          OUT                                                                                       
NUMLINES                       NUMBER(38)                                                                                                        IN/OUT                                                                                    

PROCEDURE GET_LINES
인수 이름                          유형                                                                                                                입/출력      기본값?                                                                            
------------------------------ ----------------------------------------------------------------------------------------------------------------- --------- --------------------------------------------------------------------------------
LINES                          DBMSOUTPUT_LINESARRAY                                                                                             OUT                                                                                       
NUMLINES                       NUMBER(38)                                                                                                        IN/OUT                                                                                    

PROCEDURE NEW_LINE
PROCEDURE PUT
인수 이름                          유형                                                                                                                입/출력      기본값?                                                                            
------------------------------ ----------------------------------------------------------------------------------------------------------------- --------- --------------------------------------------------------------------------------
A                              VARCHAR2                                                                                                          IN                                                                                        

PROCEDURE PUT_LINE
인수 이름                          유형                                                                                                                입/출력      기본값?                                                                            
------------------------------ ----------------------------------------------------------------------------------------------------------------- --------- --------------------------------------------------------------------------------
A                              VARCHAR2                                                                                                          IN                                                                                        
 
 
--======================================================================

sql> edit D:/smart_study/oracledemo/source/puttest01

BEGIN
    DBMS_OUTPUT.put('aaa');
    DBMS_OUTPUT.new_line( );
    DBMS_OUTPUT.put('bbb');
    DBMS_OUTPUT.new_line( );
END;
/

sql> @D:/smart_study/oracledemo/source/puttest01

/*-------------------------------------------------------------------
PL/SQL내에서의 DML문장 사용하기
INSERT, UPDATE, DELETE, MERGE 문장을 이용하여 PL/SQL 블록내에서 데이터를 변경할 수 있다.
---------------------------------------------------------------------*/
CREATE TABLE emp_test(
 no number,
 name varchar2(20));
 
 CREATE SEQUENCE emp_test_no_seq
 START WITH 1
 INCREMENT BY 1
 NOCACHE
 NOCYCLE;
 
 BEGIN
    INSERT INTO emp_test
    VALUES(emp_test_no_seq.nextval, 'kim');
 END;
 /
 
 COMMIT;
 
 SELECT * FROM emp_test;
 
 /*----------------------------------------------------------------------
 변수에 사용자로 부터 입력받은 값을 저장할때 '&치환변수'을 사용한다.
 
 verify
  - verify가 커져 있으면(ON)이면 치환변수를 값으로 대체하기 전후의 치환변수 값을 표시한다.
  - verify가 꺼져 있으면(OFF)이면 치환변수를 값으로 대체하기 전후의 치환변수 값을 표시하지 않는다.  
 ------------------------------------------------------------------------*/
 -- 현재 verify상태 를 검색
 -- verify ON
 sql> show verify
 
 DECLARE
    v_no number := '&no';
    v_name varchar2(20) := '&name';
 BEGIN
   INSERT INTO emp_test
   VALUES(v_no, v_name);
 END;
 /
 
Enter value for no: 300
old   2:     v_no number := '&no';
new   2:     v_no number := '300';
Enter value for name: 여진구
old   3:     v_name varchar2(20) := '&name';
new   3:     v_name varchar2(20) := '여진구';
 
 
sql> verify off
Enter value for no: 300
Enter value for name: 여진구
 
 --PL/SQL에서 update 쿼리를 수행
BEGIN
  UPDATE emp_test
  SET name = '김연아'
  WHERE no = 200;
END;
/
 
 SELECT * FROM emp_test;
 
 -- PL/SQL에서 delete 쿼리를 수행
 BEGIN
    DELETE FROM emp_test
    WHERE no=400;
 END;
 /

 SELECT * FROM emp_test;
 
 --merge을 수행하기 전에 emp_test2테이블을 생성
 CREATE TABLE emp_test2(
   no number,
   first varchar2(20),
   last varchar2(20));
   
 --merge을 수행하기 전에 emp_test2테이블에 데이터 삽입  
 BEGIN
    INSERT INTO emp_test2
    VALUES(500, '클라라', 'ko');
 END;
 /
 
 BEGIN
    INSERT INTO emp_test2
    VALUES(600, '바다', 'pu');
 END;
 /
 
BEGIN
    INSERT INTO emp_test2
    VALUES(300, '마운트', 'high');
 END;
 /
 
 SELECT * FROM emp_test2;
 
 --emp_test2테이블에 emp_test테이블 병합
 BEGIN
    MERGE INTO emp_test2 e2
    USING emp_test e1
    ON(e1.no=e2.no)
      WHEN matched then
        UPDATE SET e2.first=e1.name             -- UPDATE  SET column=value
      WHEN NOT matched then
        INSERT VALUES(e1.no, e1.name, null);    --INSERT VALUES()
 END;
 /
 
 --300	여진구
 SELECT * FROM emp_test
 WHERE no=300;
 
 --300	마운트	high    
 SELECT * FROM emp_test2
 WHERE no=300;
 
 /*----------------------------------------------------------------------------------------
 PL/SQL변수
  PL/SQL변수    -  단순변수   - 스칼라변수
                            - 참조 변수     - %TYPE변수
                                          - %ROWTYPE변수
              
                - 복합변수   - RECORD TYPE
                           - TABLE TYPE

  비 PL/SQL변수  - BIND변수
 ---------------------------------------------------------------------------------------*/
 
 
 --scalar변수를 활용한 예제
 DECLARE
    num number := 10;
    name varchar2(20) := 'hong';
    hire date default sysdate;
 BEGIN
    dbms_output.put_line(num || '  ' || name || '   ' || hire);
 END;
 /
 
 
 
-- reference변수중 %TYPE를 활용한 예제
 DECLARE
    num employees.employee_id%type;
    name employees.first_name%type;
    hire employees.hire_date%type;
 BEGIN
    SELECT employee_id, first_name, hire_date INTO num, name,hire
    FROM employees
    WHERE employee_id = 100;
    dbms_output.put_line(num || '  ' || name || '   ' || hire);
 END;
 /
 
 -- reference변수중 %ROWTYPE를 활용한 예제
 DECLARE
    emp employees%rowtype;
 BEGIN
    SELECT * INTO emp
    FROM employees
    WHERE employee_id = 100;
    dbms_output.put_line(emp.employee_id || '  ' || emp.first_name || '   ' || emp.hire_date);
 END;
 /
 
 /*============================================================================================
 %type변수를 사용하여 employees, departments테이블을 조인하여 employee_id=100인 사람의 정보를 4개의 변수에
넣은후 employee_id, first_name, depatment_id, department_name을 가져오는쿼리를 작성하시오.
<<실행결과>>
100  Steven  90  Executive
 ==============================================================================================*/
 DECLARE
      v_employee_id employees.employee_id%type;
      v_employee_first_name employees.first_name%type;
      v_department_id departments.department_id%type;
      v_department_name departments.department_name%type;
 BEGIN
     SELECT e.employee_id, e.first_name, d.department_id, d.department_name
     INTO v_employee_id, v_employee_first_name, v_department_id, v_department_name
     FROM employees e, departments d
     WHERE e.department_id=d.department_id
      AND  e.employee_id = 100;
      
      dbms_output.put_line(v_employee_id || '  ' || v_employee_first_name || '  '
         || v_department_id || '  '  || v_department_name);
 END;
 /
 
 /*======================================================================
 두개의 데이터를 입력받아서 합을 구하는 쿼리를 작성하시오.
<<실행결과>>
Enter value for no1: 10
old   2: v_no1 number :=&no1;
new   2: v_no1 number :=10;
Enter value for no2: 20
old   3: v_no2 number :=&no2;
new   3: v_no2 number :=20;
30
 =====================================================================*/
 DECLARE
    v_no1 number :=&no1;
    v_no2 number :=&no2;
    v_sum number;
 BEGIN
    --SELECT v_no1 + v_no2 INTO v_sum
    --FROM dual;
     v_sum := v_no1 + v_no2;
     
     dbms_output.put_line(v_sum);
 END;
 /
 
 /*===================================================================================
 복합변수는 변수 하나안에 여러 가지 다른 유형의 데이터를 포함할 수 있다.
복합변수는 Record type변수와 Table Type(컬렉션 타입)변수로 나눌 수 있다.
 Record Type변수 내부는 여러가지 유형의 데이터 형태로 정의한다.
 Table Type변수는 한가지 유형의 데이터 형태가 정의된다.  
주로 동일한  데이터 타입의 여러 건의 데이터를 저장하고 싶을 경우 Table Type(컬렉션타입)을 사용하고
다른 유형의 데이터 타입을 사용할 경우 레코드 타입의 변수를 사용한다.
 ====================================================================================*/
 
 -- Record type 변수를 활용한 예제
 
 DECLARE
    --RECORD TYPE를 정의
    TYPE emp_reocrd_type IS RECORD(
      emp_id employees.employee_id%type,
      emp_name employees.first_name%type,
      emp_salary employees.salary%type,
      emp_hire employees.hire_date%type      
    );    
    --RECORD TYPE의 변수 선언
    v_emp emp_reocrd_type; 
 BEGIN
   SELECT employee_id, first_name, salary, hire_date INTO v_emp.emp_id, v_emp.emp_name, v_emp.emp_salary, v_emp.emp_hire
   FROM employees
   WHERE employee_id = 100;
   
   dbms_output.put_line(v_emp.emp_id || '  '||v_emp.emp_name || '  ' || v_emp.emp_salary ||'  ' || v_emp.emp_hire);
 END;
 /
 
 /*==============================================================================================
 record type변수를 활용하여 부서번호가 30번인 부서의 부서번호와 부서명과 도시명을 record type변수에 저장한후
출력하시오.(단, record type데이터 타입명은 dept_record_type으로 한다.)
  <<실행결과>>
30   Purchasing   Seattle
 =============================================================================================*/
 
 DECLARE
  -- record type정의
    TYPE dept_record_type IS RECORD
    (
       v_id departments.department_id%type,
       v_name departments.department_name%type,
       v_city locations.city%type
    );
    
  -- record type 변수 선언
    v_data dept_record_type;
    
 BEGIN
   SELECT d.department_id, d.department_name, l.city INTO v_data.v_id, v_data.v_name, v_data.v_city
   FROM departments d, locations l
   WHERE d.location_id=l.location_id
    AND d.department_id = 30;
    
   dbms_output.put_line(v_data.v_id ||'  '|| v_data.v_name ||'  '|| v_data.v_city); 
 END;
 /
 
 /*==================================================================================================
 record type변수를 활용하여 employees테이블을 사용하여 사용자로부터 사원번호를 입력받은 후 employee_id, first_name,
hire_date, salary을 출력하시오.(단, record type데이터 타입명은 sawon_record_type으로 한다.)
<<실행결과>>
Enter value for input: 100
old  11: v_input employees.employee_id%type :=&input;
new  11: v_input employees.employee_id%type :=100;
사원번호:100
사원명:Steven
입사일:03/06/17
급여: 24000
 =====================================================================================================*/
 
 DECLARE
   TYPE sawon_record_type IS RECORD
   (
       v_id  employees.employee_id%type,
       v_name employees.first_name%type,
       v_hire employees.hire_date%type,
       v_salary employees.salary%type       
   );
   
   v_sawon sawon_record_type;
   v_input employees.employee_id%type := &input;
 BEGIN
   SELECT employee_id, first_name, hire_date, salary INTO v_sawon.v_id, v_sawon.v_name, v_sawon.v_hire, v_sawon.v_salary
   FROM employees
   WHERE employee_id = v_input;
   
   dbms_output.put_line('사원번호:' || v_sawon.v_id);
   dbms_output.put_line('사원명:' || v_sawon.v_name);
   dbms_output.put_line('입사일:' || v_sawon.v_hire);
   dbms_output.put_line('급여:' || v_sawon.v_salary);
 END;
 /
 
 
 /*=================================================================
 복합변수의 Table Type변수(컬렉션)
  Table Type변수는 Record Type과 같이 여러 가지 유형의 데이터 칼럼을 가질수도 있다.
  TABLE 타입은 TABLE을 색인하는데 사용되는 BINARY_INTEGER 데이터 타입의 Primary Key와 TABLE 요소를 저장하는 
  Scalar 데이터 타입의 두 가지 구성요소를 갖고 있어야 합니다.
  
TYPE [type명] IS TABLE OF
{column_type or variable%TYPE or 테이블명.컬럼명%TYPE}
INDEX BY BINARY_INTEGER;
식별자 type명;
table type변수를 사용하여 데이터를 출력한다.
 =====================================================================*/
 DECLARE
   t_name varchar2(20);
   
   -- table type 정의
   TYPE tbl_emp_name IS TABLE OF
     employees.first_name%type
     index by binary_integer;
     
   --table type 변수
   v_name tbl_emp_name;
   i binary_integer := 0;
   
 BEGIN
    SELECT first_name INTO  t_name
    FROM employees
    WHERE employee_id = 100;
 
    v_name(i) := t_name;
    dbms_output.put_line(v_name(i));
 END;
 /
 
 --for 반복문을 사용하여 변수에 여러 건의 데이터를 입력하는 방법
 DECLARE    
   -- table type 정의
   TYPE neme_table_type IS TABLE OF
     employees.first_name%type
     index by binary_integer;
     
   --table type 변수
   v_name neme_table_type;
   num binary_integer := 0;
   
 BEGIN
   for record_line in (SELECT first_name FROM employees) loop
     num := num + 1;
     v_name(num) := record_line.first_name;
   end loop;
 
   for j in 1..num loop
      dbms_output.put_line(v_name(j));
   end loop;
 END;
 /
 
/*==========================================================================
비 PL/SQL변수(바인드 변수)
바인드 변수는 호스트 환경에서 생성되어 데이터를 저장하므로 호스트 변수라 한다.
Variable키워드를 사용하여 생성되며 SQL문과 PL/SQL블록에서 사용된다.
print키워드를 사용해서 바인드변수에 저장된 값을 출력한다.
========================================================================*/
 --바인드 변수로 변수를 사용한다.
 sql> variable v_bind number;
 
 --바인드변수에 쿼리의 결과를 저장한다.
 BEGIN
    SELECT salary INTO :v_bind
    FROM employees
    WHERE employee_id=100;
 END;
 /

--v_bind 변수에 저장된 값을 출력한다. 
sql> print v_bind; 
 
 /*=================================================================
 pl_sql문을 편집/수정하기 위해서 edit명령문을 실행한다.
SQL> edit D:/smart_study/oracledemo/source/if01

쿼리문을 작성한후 sql확장자로 저장한다.

c:드라이브 testsql폴더에 저장된 파일을 실행하기 위해서 @D:/smart_study/oracledemo/source/if01파일명을 실행한다.
SQL> @D:/smart_study/oracledemo/source/if01
 ==================================================================*/
 
 /*===================================================================
 PL/SQL 제어문
 : 조건문은 if문과 case문이 있다.
   반복문은 base loop문과 while문이 있다.
if~then~end if

IF condition THEN
     statements;
END if;
========================================================================*/

SQL> edit D:/smart_study/oracledemo/source/if01
DECLARE
    vempno employees.employee_Id%type;
    vname employees.first_name%type;
    vdeptno employees.department_id%type;
    vdname varchar2(20);
BEGIN
   SELECT employee_id, first_name, department_id 
    INTO vempno, vname, vdeptno     
   FROM employees
   WHERE employee_id=100;
   
   if vdeptno=10 then
     vdname := 'ACCOUNT';
   end if;
   
    if vdeptno=20 then
     vdname := 'RESEARCH';
   end if;  
   
   if vdeptno=30 then
     vdname := 'SALES';
   end if;
   
   if vdeptno=90 then
     vdname := 'OPERATIONS';
   end if;
   
   dbms_output.put_line(vempno || ' ' || vname || '  ' || vdeptno || '  ' || vdname);
END;
/
 
 --소스 입력 후 저장한다.
 SQL>@D:/smart_study/oracledemo/source/if01
 
 
 /*===================================
 
 IF condition THEN
     statement;
 ELSE
    statement;
END IF;
     
 ====================================*/
 
 DECLARE
    vempno   employees.employee_id%type;
    vname   employees.first_name%type;
    vcomm   employees.commission_pct%type;
    vsalary   employees.salary%type;
 BEGIN
   SELECT employee_id, first_name, commission_pct, salary
   INTO vempno, vname, vcomm, vsalary
   FROM employees
   WHERE employee_id=100;
   
   if vcomm != null then
     vsalary := vsalary + vcomm;
   else
      vsalary := vsalary + 0;
   end if;
   
   dbms_output.put_line(vempno || '  ' || vname || '   ' || vsalary);  
 END;
 /
 