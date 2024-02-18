use tv_db;
show tables;
select title , rating, released_year, genre , first_name, last_name  from series join reviews on series.id = reviews.series_id join reviewers on reviewers.id = reviews.reviewer_id ;

-- view
create view full_reviews as select title , rating, released_year, genre , first_name, last_name  from series join reviews on series.id = reviews.series_id join reviewers on reviewers.id = reviews.reviewer_id;
select * from full_reviews;

-- updatable views
delete from full_reviews where released_year = 2009;  -- not going to happen

create view ordered_series as select * from series order by released_year;
insert into ordered_series (title , released_year , genre) values ('The Great',20,'Comedy');  -- will happen

-- create or replace usage
create or replace view ordered_series as select * from series order by released_year desc;

alter view ordered_series as select * from series order by released_year;

-- group by having - filtering the groups of group by
select * from full_reviews;
select title , avg(rating) from full_reviews group by title having count(rating)>1;

-- group by rollup - it will give the average of the entire table 
select title , avg(rating) from full_reviews group by title with rollup;

select released_year , genre, avg(rating) from full_reviews group by released_year , genre with rollup;
select * from full_reviews;
select released_year , genre , avg(rating), first_name from full_reviews group by released_year ,genre, first_name with rollup;


-- modes in sql - behaviour of tables 
select @@GLOBAL.sql_mode;
select @@session.sql_mode;
select 3/0;

-- strict trans tables
desc reviews;
insert into reviews(rating) values("hi"); -- if i disable the strict trans tables mode it will insert a string value in a float column.

-- only full group by
set session sql_mode = "ONLY_FULL_GROUP_BY";
select @@SESSION.sql_mode;
select title , rating from series join reviews on series.id = reviews.series_id group by title; -- its not running because sql does not know which rating to give.










