use instagram_db;
select * from users;

-- too 5 oldest users
select user_name from users order by created_at limit 5;

-- one what day of week do most users register on?
select * from users;
SELECT count(*),DAYNAME(created_at) AS weekday_name from users group by weekday_name limit 2;







