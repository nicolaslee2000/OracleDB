alter table users 
modify (
user_pwd varchar2(20)
);

insert into users(user_id, user_pwd, email, salt, language)
values('a1234', 'asdfasdf', 'nicolaslee2000@gmai.com', '12351234', 'en');

insert into users(user_id, user_pwd, email, salt, language)
values('a2222', 'asdfasdf', 'nicolaslee2000@gmasdfai.com', '12351234', 'en');

insert into recipes(RECIPE_NAME, user_id, recipe_content, published_date)
values('plzletitworkrecipe', 'a1234', 'do this do that', sysdate);

select * from recipes;
select * from recipe_likes;
insert into recipe_likes
values(2, 'a2222', 'Y');
select r.recipe_id, r.user_id, l.isLiked, l.user_id from recipes r
INNER JOIN recipe_likes l
ON r.recipe_id = l.recipe_id
WHERE r.recipe_id = 1;

select r.recipe_id, r.user_id, l.isLiked, l.user_id from recipes r
JOIN recipe_likes l
ON r.user_id = l.user_id;

select r.recipe_id, r.user_id, l.user_id from recipes r
				JOIN recipe_likes l
				ON r.recipe_id = l.recipe_id WHERE r.recipe_id = 1;
                
commit;
                