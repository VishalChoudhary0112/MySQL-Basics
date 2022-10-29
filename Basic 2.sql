-- Shows all the tables in database HR
show tables;

-- Show table employees
select * from employees;

-- Show table Departments
select * from departments;

-- Show table Locations
select * from locations;


-- Query :--------------------------------------------------------------------------------------------------------------------------

-- 1|.   List all employees who are working for department 80.
select * from employees where department_id=80;
-- OR
select count(employee_id) from employees where department_id=80;  						 -- Counts number of employees working in dept 80.

-- 2|.   List all employees earning salary more than 10000. 	
select * from employees where salary>10000;

-- 3|.   List all employees who do not have manager.
select * from employees where manager_id is NULL;

-- 4|.	 List all employees who are not working for department 80.
select * from employees where department_id!=80;
-- OR
select count(employee_id) from employees where department_id!=80;  						-- Counts number of employees do not working in dept 80.

-- 5|.   List all employees working for department 80 and 90.
select * from employees where department_id=80 or department_id=90;

-- 6|.   List all employees working for 80 and earn more than 5000 salary.
select * from employees where department_id=80 and salary>5000;

-- 7|.    List all employees working for department 80,90 and 100.
select * from employees where department_id=80 or department_id=90 or department_id=100;
-- OR
select * from employees where department_id in (80,90,100); 							-- Using 'in' operator.

-- 8|.	  List all employees who all earning salary in the range of 12000 to 18000.
select * from employees where salary>=12000 and salary<=18000;
-- OR
select * from employees where salary between 12000 and 18000;                           -- Using between operator





-- Like operator is also known as Soundex and pattern matching operator.

-- Wild characters   : 
--    %      - multiple characters 
--    _      - replace single character

-- 9|. 	 List name whose first_name starts with 'a'.
select first_name from employees where first_name like 'a%';

-- 10|.	  List name whose first_name ends with 'a'.
select first_name from employees where first_name like '%a';

-- 11|.   List name whose first_name contains 'a'.
select first_name from employees where first_name like '%a%';

-- 12|.   List name contains 'a' in second position.
select first_name from employees where first_name like '_a%';

-- 13|.	  List name contains 'l' in second last positon.
select first_name from employees where first_name like '%l_';




-- Arthmatic Operations ------------------------------------------------------------------------------------------------------

select employee_id,first_name,salary,
salary*0.2 as bonus from employees;                       -- Here bonus is assign as column name where salary*0.2 and using 'as' is optional.
														  -- Here bonus is for calculation purpose. Does not get stored.


select *,salary*0.2 bonus from employees;

select *, salary*0.2 "employee bonus" from employees;

create table temp as									  -- Create a temperory table 'temp'.
select employee_id,first_name,salary,
salary*0.2 as bonus from employees; 

select * from temp;


-- NULL Values -------------------------------------------------------------------------------------------

select 1+null;

select salary,commission_pct,salary+commission_pct from employees;




-- 14|. 	List all employees joined after 1995.
select * from employees where hire_date>'1995-12-31';


-- 15|. 	List all employees where dept id is not 90,80 and 70.
select * from employees where department_id not in (90,80,70);


-- 16|.		List name and annual salary of all the employees.
select first_name,salary*12 Annual_salary from employees;


-- 17|. 	List all department_id,department_name whose department name are IT related
select department_id,department_name from departments where department_name like 'IT%';


-- 18|.		List department_id and hire_date for Neena and Bruce.
select department_id,first_name,hire_date from employees where first_name='Neena' or first_name='Bruce';
-- OR
select department_id,first_name,hire_date
from employees
where first_name in ('neena','bruce');

-- 19|.		List all employees whose job_id is IT_prog and earns salary more than 5000.
select * from employees where job_id='IT_prog' and salary>5000;		



-- Order by----------------------------------------------------------------------------------------------------------------------------------------
select employee_id,first_name,salary from employees        
order by salary;																	-- Default order is ascending.
-- OR
select employee_id,first_name,salary from employees        
order by 2;

select employee_id,first_name,salary from employees        
order by salary desc;																-- Descending order.
-- OR
select employee_id,first_name,salary from employees        
order by 2 desc;

-- 20|.		List 5 employees having higest salary.
select employee_id,first_name,salary from employees        
order by salary desc
limit 5;

-- 21|.		List 3 employees of department id is 80 having higest salary.
select employee_id,first_name,salary 
from employees
where department_id=80
order by salary desc
limit 3;


select department_id,salary from employees        
order by department_id,salary;                           				-- In output Null value is smallest value in department_id.



-- 22|.		List first_name and last_name whose last name contains 'li' and arrange first name in alphabetical order.
select first_name,last_name from employees 
where last_name like '%li%'
order by first_name;

-- 23|.		List first_name,department_id and hire_date in the department id and hire date order.
select first_name,department_id,hire_date
from employees 
order by department_id,hire_date;

-- INDEXING --------------------------------------------------------------------------------------------------------------------------------------------

-- 24|. 	List Lex details from employees.
select * from employees
limit 2,1;

-- 25|.		List lex and alexender details from employees.
select * from employees
limit 2,2;

-- 26|. 	List third highest salaried employee details having job_id is 'ST_MAN'.
select * from employees
where job_id='St_MAN'
order by salary desc
limit 2,1;

-- 27|. List 2 matching records with salary greater than 10000
select * from employees where salary>10000
limit 2;

-- Numeric Operation---------------------------------------------------------------------------------------------------------------------------

select round(45.929,2);           -- change value to nearest number
select round(45.929,0);

select Truncate(45.929,2);        -- just chop the value

select floor(25.99);

select ceiling(25.05);

select mod(25,5);				  -- Gives reminder
select mod(25,4);

select pow(2,3);				  -- Gives power

select sqrt(25);				  -- Gives square root

-- CHARACTER FUNCTION------------------------------------------------------------------------------------------------------------------------

-- 1. Case conversion functions
-- lower or lcase
select lower(first_name) from employees;


-- upper or ucase
select upper(first_name) from employees;



-- 2. Character manipulation functions :

-- concatination :
select concat(first_name,' ',last_name) name from employees;

-- substring :
select substr('welcome',4,4);									  -- Start from 4th position and take 4 values. If taken (4,10) still would print 'come'.

help 'substr';

-- instr :  Gives first occurance of character.
select instr('welcome','e');
select instr('welcome','o');

-- lpad :
select lpad('salary',10,'*') from employees;

-- rpad :
select rpad('salary',10,'*') from employees;

-- Replace :
select replace(' jack and BLue','j','bl');

-- Trim :
select replace(first_name,'i','j') from employees trim;

select length( trim(' vidhya '));						--

select trim('M' from 'Madam');

-- 28|. 
select employee_id,concat(first_name,' ',last_name) name,job_id,length(last_name),instr(last_name,'a') 
from employees 
where job_id like '%REP%' and last_name like '%a%';



-- DATE FUNCTION------------------------------------------------------------------------------------------------------------------------------------

-- adddate or date_add :
select adddate(current_date(),interval 1 day);   -- Add 1 day to today.
select adddate(current_date(),interval 2 day);   -- Add 2 day to today.

select adddate(current_date(),interval 1 week);  -- Add 1 week to today.

select date_add('2020-01-31',interval 1 month);	-- Add 1 month to given date.



-- subdate or date_sub :
select subdate(current_date(),interval 1 day);	 -- Sub 1 day to today.

select date_sub(current_date(),interval 1 year); -- Sub 1 year to today.


-- Date_format :
select date_format(current_date(),'%d-%m-%y');   -- Gives numerical values
select date_format(current_date(),'%D-%M-%Y');   
select date_format(current_date(),'%D-%m-%Y'); 

select date_format(current_date(),'%a');         -- Gives today's day.

select date_format(current_date(),'%b');         -- Gives this month.

select date_format(current_date(),'%c');         -- Gives date.


select str_to_date('13-09-2020','%d-%m-%Y');

select str_to_date('13-jan-2020','%d-%b-%Y');

select str_to_date('13 09 2020','%d %m %Y');

-- DATE Difference ------------------------------------
select datediff('2022-09-12','2022-09-13');


-- 29|. List the tenure of each employee till date and display in seniority order.
select employee_id,first_name,hire_date,round(datediff('2022-09-14',hire_date)/365,2) Tenure
from employees
order by tenure desc;

-- IF date of retirement is given :
-- select *,round(datediff(ifnull(date_retirement,current_date()),hire_date)/365,2) Tenure
-- from emoloyees
-- order by tenure desc;
