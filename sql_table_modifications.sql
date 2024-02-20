-- uniq constraint 
create table contacts (
	name VARCHAR(100) NOT NULL,
    phone varchar(30) NOT NULL UNIQUE
    );
alter table contacts modify phone varchar(30);
insert into contacts (name , phone)
VALUES ('pankaj', '7017'),
       ('anjali', '8368593883'),
       ('hansi', '9910575972');
select * from contacts;

-- check constraint
create table users(
name varchar(20) not null,
age int check (age>0)
);
alter table users change name user_name varchar(40); 
insert into users (user_name  ,  age)
values ('pankaj', 89),
       ('anjali', 10),
       ('hansi', 97495);
select * from users;

ALTER TABLE users
ADD COLUMN id INTEGER auto_increment primary key first;
select * from users;




-- named constraints


 
create table parties(
name varchar(89) , age int constraint age_over_18 check(age>18));
alter table parties change name username varchar(40);
insert into parties (username, age) 
values ('chickenman',-19);

-- multiple named constraints
create table companies (
supplier_id int not null,
phone varchar(15) not null unique,
name varchar(60) not null, 
address varchar(255) not null, 
primary key (supplier_id),
constraint name_address unique (name , address));

-- alter table

select * from contacts;
alter table contacts add column address varchar(80);
insert into contacts ( name , phone  ,address)
values ("ram", 794637975,"ayodhya");
select * from contacts;

alter table contacts add column networth int not null default 1;
select * from contacts;
insert into contacts (name)
values ('jlsdj');
insert into contacts (phone)
values (98954678);
select * from contacts;

-- drop column
select * from contacts;
alter table contacts drop column networth;

-- rename table
show tables;
select * from companyes;
rename table companies to companyes;

-- renaming columns
alter table companyes rename column name to user_name;

-- modify column definition
alter table employee modify employeename varchar(200);
desc employee;
alter table employee modify jobType varchar(100) default "unknown";
alter table employee change employeeEmail Email varchar(90);

-- add and drop constraints after table has been created
alter table employee add constraint positive_id check (id>=0);
alter table employee add column id int; 
desc employee;
insert into employee (id) values (-1);

-- drop constraint
alter table employee drop constraint positive_id;



