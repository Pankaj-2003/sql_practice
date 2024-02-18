show databases;
create database shop;
use shop;
create table customers(
	ID INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);
CREATE TABLE orders (
	ID INT PRIMARY KEY AUTO_INCREMENT,
    order_data DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);
INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);
select * from customers; 
select * from orders;

-- cross join
select * from customers, orders;

-- inner join
select * from customers 
join orders 
	on customers.id = orders.customer_id;
SELECT 
    first_name, last_name, order_date, amount
FROM
    customers
        JOIN
    orders ON customers.id = orders.customer_id;
    
-- other way (the output format will change)
SELECT 
    *
FROM
    orders
        JOIN
    customers ON orders.customer_id = customers.id;
    
-- left join. the main difference is that we get nulls in the intersection it will give all from left table but only those from right table which intersect

select first_name, last_name , amount from customers left join orders on customers.id = orders.customer_id;
select first_name, last_name , amount from orders left join customers on orders.customer_id = customers.id; -- same ----- 

-- left join with groupby / if null    
select first_name ,last_name , ifnull((amount),0) from customers left join orders on customers.id = orders.customer_id group by first_name , last_name;

--  right join
select first_name , last_name , amount from customers right join orders on customers.id = orders.customer_id; -- same -----
select first_name , last_name , amount from customers join orders on customers.id = orders.customer_id;  -- same ---- inner join 

-- on delete casacade 
delete from customers where last_name = "George"; -- this will not work because orders.customer_id is a subset of it.

drop table orders;
drop table customers;

create table customers(
	ID INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);
CREATE TABLE orders (
	ID INT PRIMARY KEY AUTO_INCREMENT,
    order_data DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id) on delete cascade
);

alter table orders change column order_data order_date date;


INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);

delete from customers where last_name = "George"; -- what happens is.. it will delete the customer george and also its orders from order table to main tain referential integrity
select * from customers;

-- practice of joins

create table students(
	id int PRIMARY KEY auto_increment,
    first_name varchar(40)

);
create table papers(
	title varchar(40),
    grade int check (grade <= 100),
    student_id int,
    foreign key (student_id) references students(id) on delete cascade
);
INSERT INTO students (first_name) VALUES 
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');
 
INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

select first_name , title , grade from students join papers on students.id = papers.student_id order by grade desc;
select first_name , ifnull(title,"missing") , ifnull(grade,0) from students left join papers on students.id = papers.student_id;
select first_name , ifnull(avg(grade),0) as AVERAGE,CASE WHEN ifnull(avg(grade),0) < 75 THEN "FAILING" ELSE "PASSING" END AS PASSING_STATUS from students left join papers on students.id = papers.student_id group by first_name order by AVERAGE DESC;

-- MANY TO MANY RELATIONSHIP TV SERIES DATASET
create database tv_db;
use tv_db;

create table reviewers (id int PRIMARY KEY auto_increment,
						first_name varchar(50) not null,
                        last_name varchar(50) not null);

create table series ( id int PRIMARY KEY AUTO_INCREMENT,
					title varchar(150) ,
                    released_year year ,
                    genre varchar(150));
                    
create table reviews (id int PRIMARY KEY AUTO_INCREMENT,
					  rating decimal(2,1),
                      series_id int,
                      review_id int,
                      foreign key (series_id) references series(id),
                      foreign key (review_id) references reviewers(id)
                      );
alter table reviews change column review_id  reviewer_id int;
INSERT INTO series (title, released_year, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');
 
 
INSERT INTO reviewers (first_name, last_name) VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');
    
 
INSERT INTO reviews(series_id, reviewer_id, rating) VALUES
    (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),
    (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
    (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
    (10,5,9.9),
    (13,3,8.0),(13,4,7.2),
    (14,2,8.5),(14,3,8.9),(14,4,8.9);

select * from series;
select * from reviewers;
select * from reviews;

-- tasks/challenges
select title , rating from series join reviews on series.id = reviews.series_id;
select title , avg(rating) from series join reviews on series.id = reviews.series_id group by title;
select first_name, last_name , rating from reviewers join reviews on reviewers.id = reviews.reviewer_id;
select title  as unreviewed_series from series left join reviews on reviews.series_id = series.id where rating is null;
select title  as unreviewed_series from reviews right join series on reviews.series_id = series.id where rating is null;
select genre , avg(rating) as avg_rating from series left join reviews on series.id = reviews.series_id group by genre;

SELECT 
    first_name,
    last_name,
    COUNT(rating) AS COUNT,
    IFNULL(MIN(rating), 0) AS MIN,
    IFNULL(MAX(rating), 0) AS MAX,
    IFNULL(AVG(rating), 0) AS AVG,
    CASE
        WHEN COUNT(rating) = 0 THEN 'INACTIVE'
        ELSE 'ACTIVE'
    END AS STATUS
FROM
    reviewers
        LEFT JOIN
    reviews ON reviewers.id = reviews.reviewer_id
GROUP BY first_name , last_name;

SELECT 
    first_name,
    last_name,
    COUNT(rating) AS COUNT,
    IFNULL(MIN(rating), 0) AS MIN,
    IFNULL(MAX(rating), 0) AS MAX,
    IFNULL(AVG(rating), 0) AS AVG,
    IF(COUNT(rating)>0 , "ACTIVE","INCATIVE") AS STATUS
FROM
    reviewers
        LEFT JOIN
    reviews ON reviewers.id = reviews.reviewer_id
GROUP BY first_name , last_name;

select title , rating , concat(first_name , " ", last_name) as full_name  from series join reviews on series.id = reviews.series_id inner join reviewers on reviewers.id = reviews.reviewer_id;
select * from series;
select * from reviews;
select * from reviewers;



























