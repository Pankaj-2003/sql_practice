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

-- dense_rank() , row_number()
select emp_no , department, salary , row_number() over(partition by department order by salary) , row_number() over(partition by department) from employees;

-- dense_rank() unlike rank() it does not skip number to assign when there is a tie
SELECT 
    emp_no, 
    department, 
    salary,
    ROW_NUMBER() OVER(PARTITION BY department ORDER BY SALARY DESC) as dept_row_number,
    RANK() OVER(PARTITION BY department ORDER BY SALARY DESC) as dept_salary_rank,
    RANK() OVER(ORDER BY salary DESC) as overall_rank,
    DENSE_RANK() OVER(ORDER BY salary DESC) as overall_dense_rank,
    ROW_NUMBER() OVER(ORDER BY salary DESC) as overall_num
FROM employees ORDER BY overall_rank;

-- ntile()
select emp_no , department, salary , 
ntile(4) over(partition by department order by salary),
ntile(4) over(order by salary desc) as quartile 
from employees;

-- first_value()
select emp_no , department, salary , 
first_value(emp_no) over(partition by department order by salary desc) as highest_paid_dept, 
first_value(emp_no) over(order by salary desc) from employees;

-- lead() and lag()
select emp_no , department , salary 
, salary-lag(salary) over(order by salary desc) from employees;
select emp_no , department , salary 
, salary-lead(salary) over(partition by department order by salary desc) from employees;
select emp_no , department , salary , lag(salary ,2) over(order by salary desc) from employees;




