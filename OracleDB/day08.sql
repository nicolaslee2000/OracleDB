SELECT * FROM user_tab_privs_recd;
SELECT * FROM user_tab_privs_made;
GRANT CREATE SESSION to nick;

GRANT SELECT ON employees TO nick;
SELECT * FROM user_sys_privs;
show user;

CREATE USER user03 identified by a1234;
GRANT CREATE session to user03;
REVOKE CREATE SESSION from user03;
--role
GRANT CONNECT, RESOURCE TO user03;
SELECT * FROM dba_roles;
