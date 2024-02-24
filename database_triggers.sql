create database trigger_demo;
use trigger_demo;
CREATE TABLE users (
    user_name VARCHAR(100),
    age INT
);
insert into users (user_name  , age) values ('bobby', 22);
select * from users;

-- database triggers (automatically run code when a table is changed)
DELIMITER $$
CREATE trigger must_be_adult 
		before insert on users for each row 
        begin 
			if NEW.age < 18 
			then 
				signal sqlstate '45000' 
					set message_text = "Must Be An Adult!"; 
			end if; 
		end; 
$$ 
DELIMITER ;
select * from ajfll;


insert into users (user_name , age) values ("pankaj" , 15);
