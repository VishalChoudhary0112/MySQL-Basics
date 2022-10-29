-- DISTINCT -----------------------------------------------------------------------------------------------------------------------------------------

# 	 1|. List the dept where employees are working.
select distinct department_id from employees
where department_id is not null;

select distinct department_id,job_id from employees
where department_id is not null;

select distinct * from employees;


-- Control Flow Functions ----------------------------------------------------------------------------------------------------------------------------
-- Functions that control the flow of the query based on data value 

-- 	IF(exp1,exp2,exp3) - if exp1 is true then return exp2 ortherwise exp3.alter

-- 	IFNULL(exp1,exp2)  - if exp1 is not NULL,return exp1 otherwise exp2

-- 	NULLIF(exp1,exp2)  - if exp1=exp2,return NULL,otherwise exp1

-- CASE value WHEN condition THEN result WHEN condition THEN result.... ELSE result END.



-- IF(exp1,exp2) ---------------------------------------------------------
select if (50>10,'1st number is bigger','1st number is smaller');


#  2|. Tag the employee salary as good or bad.
select employee_id,first_name,salary,if(salary>10000,'GOOD','POOR') TAG 
from employees;



#  3|. List employeed by adding salary and commision_pct and if commsision is NULL take 0.
select employee_id,first_name,salary,commission_pct,salary+ifnull(commission_pct,0) comm_sal 
from employees;
-- OR
select employee_id,first_name,salary,commission_pct,salary+if(commission_pct is NULL,0,commission_pct) comm_sal
from employees;


# 4|. Replace the designation as null for all the employees who are designated as IT_PROG.
select employee_id,first_name,job_id,nullif(job_id,'it_prog') 
from employees;
-- OR
select employee_id,first_name,job_id,if(job_id='it_prog',null,job_id) 
from employees;


-- CASE--------------------------------------------------------

# 5|. Grade salary of employees on the basis of there salary in employees.
select salary,
 case 
when salary>18000 then 'A+'
when salary between 15000 and 18000 then 'Grade 1'
when salary between 12000 and 15000 then 'Grade 2'
when salary between 10000 and 12000 then 'Grade 3'
when salary<10000 then 'Grade 4'
end Grade
from employees;



-- SET OPERATIONS-----------------------------------------------------------------------------------------------------------------------------------

-- Union :
	# Common no. of attribute.
    # Data type should be similar.

# 6|. Show common department and manager id from employees and departments.
select department_id,manager_id from employees
union
select department_id,manager_id from departments;

# 7|. Display  * ** *** each in seperate lines using UNION.
select '*'
union
select '* *'
union
select '* * *';



-- KEYS/CONSTRAINTS----------------------------------------------------------------------------------------------------------------------------------------

# NOT NULL 			Cannot be left blank.

# UNIQUE	    	Cannot be duplicated. (NULL IS UNIQUE)

# PRIMARY KEY   	Features of both not null and unique.

# FOREIGN KEY   	A primary key of one table used in another table is considered as foreign key.

# CHECK				Check controls the value in a column. Determine whetther value is valid or not from a logical expression.

# DEFAULT			When a value is not given then it takes default value given in default constraint.


-- Student case to understand :-------------------------------------------------------

# roll no : 	unique ,not null and primary key
# phone no :	unique ,not null and alternative key
# email :		unique key

create table Student_demo
(
	roll_no int primary key,
    name varchar(10) not null,
    email varchar(20) unique,
    phone_no int unique not null
);


-- Author case to understand :---------------------------------------------------------------------
create table author
( 
	id int primary key,
	name varchar(10) not null default 'Mr.X',
	country varchar(10) not null check(country in ('usa','uk','uae')),
	page int check(page>0),
	contact_no int unique
);

describe author; 


insert into author values
(101,'A','USA',12,123);


insert into author
(id,country,page,contact_no)
values
(102,'USA',12,12);

select * from author;

-- GROUP BY FUNCTION------------------------------------------------------------------------------------------------------------------------------
select min(salary)
from employees
group by department_id;

select department_id,min(salary) from employees
group by department_id;

# 8|. Find the total amount spend against salary from each designation.
select job_id,sum(salary)
from employees
group by job_id;


# 9|. 
select job_id,count(employee_id) 'No. of employees',
case
when count(employee_id)=1 then 'J Dept'
when count(employee_id)=2 then 'M Dept'
when count(employee_id)=3 then 'h Dept'
when count(employee_id)>3 then 'S Dept'
end
from employees
group by job_id;

-- HAVING ---------------------------------------------------------------------------------------

# 10|. List only the dept which has maximum salary above 10000.
select department_id,max(salary) from employees
group by department_id
having max(salary)>10000;						-- Where cannot work on aggregated rows.



# 11|. List for dept id is 80,90 and 100 having maximum salary above 10000.
select department_id,max(salary) from employees
group by department_id
having max(salary)>10000
and department_id in (80,90,100);
-- OR
select department_id,max(salary) from employees
where department_id in (80,90,100)
group by department_id
having max(salary)>10000;


# 12|. List the department and no of employees where deparment have more than 2 employees.
select department_id,count(employee_id) from employees
group by department_id
having count(employee_id)>2;


# 13|. List dep_id and the number of emp for those belong to depart id 30,80 and 90.
select department_id,count(employee_id) from employees
where department_id in (30,80,90)
group by department_id;


# 14|. How many clerk are working in different deparment.
select department_id,count(job_id) from employees
where job_id like '%clerk%'
group by department_id;

select department_id,job_id,count(job_id) from employees
where job_id like '%clerk%'
group by department_id,job_id;




-- COALESCE FUNCTION------

select ifnull(department_id,commission_pct)from employees;
# if comission_pct value is also null then it would show null in ouput.

select coalesce(department_id,commission_pct,salary)from employees;
# Coalesce will take salary value if commision_pct value is null.






