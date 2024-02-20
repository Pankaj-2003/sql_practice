create database salaries;
use salaries;


CREATE TABLE employees (
    emp_no INT PRIMARY KEY AUTO_INCREMENT,
    department VARCHAR(20),
    salary INT
);
 
INSERT INTO employees (department, salary) VALUES
('engineering', 80000),
('engineering', 69000),
('engineering', 70000),
('engineering', 103000),
('engineering', 67000),
('engineering', 89000),
('engineering', 91000),
('sales', 59000),
('sales', 70000),
('sales', 159000),
('sales', 72000),
('sales', 60000),
('sales', 61000),
('sales', 61000),
('customer service', 38000),
('customer service', 45000),
('customer service', 61000),
('customer service', 40000),
('customer service', 31000),
('customer service', 56000),
('customer service', 55000);
 
select * from employees; 
select  avg(salary) over() from employees;
select emp_no, department, salary,min(salary) , max(salary) over() from employees;
SELECT 
    emp_no, 
    department, 
    salary, 
    MIN(salary) OVER(),
    MAX(salary) OVER()
FROM employees;
 
 -- Partition By
 select emp_no , department, salary , avg(salary) over(partition by department) from employees;
 select department , count(*) over(partition by department) from employees;
 select emp_no , department , salary, sum(salary) over(partition by department) , sum(salary) over() from employees;
 
 -- order by windows 
 
 select emp_no, department, salary , sum(salary) over(partition by department order by salary desc) , sum(salary) over(partition by department) from employees;
 
 -- rank()
select emp_no , department, salary , rank() over(partition by department order by salary desc) as overall_salary_rank from employees;
select emp_no , department, salary , rank() over(partition by department order by salary desc),rank() over(order by salary desc) as overall_salary_rank from employees;

