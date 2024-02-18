

create database EmployeeDetails;
drop table employee;
CREATE TABLE Employee (
    EmployeeId INT AUTO_INCREMENT,
    employeeName VARCHAR(67),
    jobType VARCHAR(10),
    employeeEmail VARCHAR(20),
    employeeAddress VARCHAR(20),
    distanceFromSchool INT,
    PRIMARY KEY (EmployeeId)
);
ALTER TABLE Employee AUTO_INCREMENT = 100000;
insert into Employee values(100000,"DemoName", "JobType","DemoEmail","DemoAddress",9);
SELECT 
    *
FROM
    employee;
