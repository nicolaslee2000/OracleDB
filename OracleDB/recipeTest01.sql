create user recipe_admin_test identified by "a1234";
create user recipe_user_test identified by "a1234";

grant all privileges to recipe_admin_test;
grant create session, create table, create view, create procedure, create sequence, create trigger to recipe_user_test;