use instagram_db;
select * from users;

-- too 5 oldest users
select user_name from users order by created_at limit 5;

-- one what day of week do most users register on?
select * from users;
SELECT 
    COUNT(*), DAYNAME(created_at) AS weekday_name
FROM
    users
GROUP BY weekday_name
LIMIT 2;

-- find the users who never posted a photo
select user_name from users left join photos on users.id = photos.user_id where photos.id is null;

-- find the person with most likes on a single photo
select user_name from users join photos on users.id = photos.user_id join likes on likes.photo_id = photos.id group by photo_id order by count(*) desc limit 1;

-- how many times average user posts?
select ((select count(*) from photos) / (select count(*) from users));

-- what are the top 5 commonly used hashtags?
select * from tags ;
select count(*) , tag_name from tags join photo_tags on tags.id = photo_tags.tag_id group by tag_id order by count(*) desc limit 5;

-- find the users who have liked every single photo 
select * from likes;
SELECT 
    user_name, user_id, COUNT(*) AS num_likes
FROM
    users
        INNER JOIN
    likes ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING num_likes = (SELECT 
        COUNT(*)
    FROM
        photos);

