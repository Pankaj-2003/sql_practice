use instagram_db;
select * from users;

-- too 5 oldest users
select user_name from users order by created_at limit 5;

-- one what day of week do most users register on?
select * from users;
SELECT count(*),DAYNAME(created_at) AS weekday_name from users group by weekday_name limit 2;

-- find the users who never posted a photo
select user_name from users left join photos on users.id = photos.user_id where photos.id is null;

-- find the person with most likes on a single photo
select user_name from users join photos on users.id = photos.user_id join likes on likes.photo_id = photos.id group by photo_id order by count(*) desc limit 1;

-- how many times average user posts?
select ((select count(*) from photos) / (select count(*) from users));

-- what are the top 5 commonly used hashtags?
select * from tags ;
select count(*) , tag_name from tags join photo_tags on tags.id = photo_tags.tag_id group by tag_id order by count(*) desc limit 5;
