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

use instagram_db;

-- check if the follower id = followee id user dont follow himself
select * from faulows;

DELIMITER $$
CREATE trigger prevent_self_follows 
		before insert on faulows for each row 
        begin 
			if NEW.follower_id = NEW.followee_id 
			then 
				signal sqlstate '45000' 
					set message_text = "You cannot follow yourself"; 
			end if; 
		end; 
$$ 
DELIMITER ;
insert into faulows (follower_id , followee_id) values (5,5);

-- after trigger if we delete something in 'faulows' table trigger gets called and an automatic insert happens in table unfollows 

DELIMITER $$
CREATE trigger capture
		after delete on faulows for each row 
        begin 
			insert into unfollows 
            set follower_id = old.follower_id,
            followee_id  = old.followee_id;
		end; 
$$ 
DELIMITER ;

delete from faulows where follower_id = 2 and followee_id = 1;


-- managing trigger and deleting
show triggers;
drop trigger capture_unfollow;













