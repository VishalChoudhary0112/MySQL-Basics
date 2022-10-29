-- create a new database called day 1
create database day1;

-- new table student
-- rollno int
-- name string
-- dob date
-- course string
-- score float
use day1;      -- to higlight the table using
show tables;   -- to show tables in day1 database
create table student
(
rollno int,
name varchar(15),
dob date,
course varchar(10),
score float
);
-- To list the structure of the table
desc student;

create table employee
(
emp_id int,
name varchar(15),
doj date,
department varchar(10),
salary int
);
-- to list the structure of employee
desc employee;

-- adding a new attribute in datastructure
alter table student add genders char(1),
add contact_no int;

-- dropping 
alter table student drop gender;

-- add new attribute age after the course column
alter table student add age int after course;

-- add new attribute row_no at first position
alter table student add row_no int first;

-- modify the datatype of column attribute
alter table student modify age float;

-- rename along with changing data type
alter table student change
marks score int;

-- Drop table : will delete all record and datastructure.
drop table student;

-- Truncate : will delete all the records but retains all the datastructure.
truncate table student;








-- DATA MANUPULATION LANGUAGE (DML) :
-- Insert , Update , Delete


-- INSERT :
insert into employee values
(101,'AAA','2020-12-01','sales',5000);


insert into employee                                                     -- When we dont have value of specific column
(emp_id,name,doj,salary)
values
(102,'BBB','2021-02-22',7000);
desc employee;


insert into employee										        	-- Using NULL in unknown values
values(103,'CCC',NULL,NULL,8000);


insert into employee values                                            -- Inserting multiple rows in datastructure
(104,'DDD','2020-02-01','HR',8500),
(105,'EEE','2022-02-01','HR',8600);


select * from employee;              -- Display all the data entered in datastrucuture.

-- UPDATE :

update employee set salary=15000
where name='AAA';

update employee set salary=salary +(salary*0.20);

select * from employee where salary>5000;

update employee set department='Finance'
where department is NULL;

select * from employee;

update employee set department='Operation'
where salary<10000 and department='sales';
select * from employee;

-- Delete :

delete from employee 
where department='Finance';
select * from employee;

create table data_test
(
dte date,
dt datetime,
t time
);



-- Build in functions :
select 1+1 from dual;  
select 1+1;                -- Here a dummy datastructure dual is created
select current_date();
select current_time();
select now();
select current_timestamp();
select utc_timestamp();



insert into data_test values
(current_date(),now(),current_time());
select * from data_test;

insert into data_test values
('2020-12-14','2020-12-14 09:00:00','10:28:10');
select * from data_test;
