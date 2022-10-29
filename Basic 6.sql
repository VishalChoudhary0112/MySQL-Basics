-- SUBQUERY-----------------------------
select * from employees
where salary< ( select salary from employees where first_name='payam');

select *
from employees e1 join employees e2
on e1.salary<e2.salary
where e2.first_name='payam';

-- Single row V/S Multiple row subquery :

# Returns one row. -- Returns multiple rows
# Scalar subquery returns a single row with 1 column -- 


select * from employees
where department_id=
(select department_id from departments where department_name='marketing');


select employee_id,first_name,salary
from employees
where salary=(select salary from employees where first_name='neena');


select *
from employees
where (job_id,salary)=(select job_id,salary from employees where first_name='payam');

select employee_id,concat(first_name,last_name) employee_name,salary
from employees
where salary>(select avg(salary) from employees);


select *
from employees
where department_id=(select department_id from departments where department_name='sales');

select *
from employees
where manager_id=(select employee_id from employees where first_name='payam');


select * 
from employees
where year(hire_date)=(select year(hire_date) from employees where first_name='clara') and first_name!='clara';


select first_name,salary
from employees
where salary=(select salary from employees order by salary desc limit 1,1);


select employee_id,first_name,salary,department_name,city
from employees e join departments d 
on e.department_id=d.department_id
join locations l
on d.location_id=l.location_id
where salary>(select max(salary) from employees where year(hire_date)=1997);


select first_name,salary,department_id 
from employees
where salary<( select avg(salary) from employees where department_id=
( select department_id from employees where first_name='laura'));



-- Multiple row---------------------------

 ##### List the employees who all earning salary less than david.
select * from employees where salary<any
(select salary from employees where first_name='david');

select * from employees where salary<all
(select salary from employees where first_name='david');


#### List employees who are earning the salary which is min salary of any of the department.
select * from employees
where salary=any
(select min(salary) from employees group by department_id);
-- OR
select * from employees
where salary in
(select min(salary) from employees group by department_id);



#### List department_name where atleast somebody is working.
select department_name
from departments
where department_id in (select department_id from employees where department_id is not null);
-- OR
select department_name
from departments
where department_id in (select distinct department_id from employees);


#### Display all the information of employees who does not work in these departments whose manager id within range 100 and 200.
select *
from employees
where department_id not in(select department_id from departments where manager_id between 100 and 200);

#### Write the name of all the managers.
select first_name
from employees
where employee_id=any(select manager_id from employees);


#### List the employees those belong to location 1700. 
select * 
from employees
where department_id =any (select department_id from departments where location_id=1700);



-- EXISTS--------------------------------------------------------------------
#The EXISTS operator is used to test for the existence of any record in a subquery.
#The EXISTS operator returns TRUE if the subquery returns one or more records.

-- Syntax :-
#	SELECT column_name(s)
#	FROM table_name
#	WHERE EXISTS
#	(SELECT column_name FROM table_name WHERE condition);


#
select * from employees e1 where salary>
(select avg(salary) from employees e2
where e1.department_id=e2.department_id);

# Display the name and dept id for all dept where atleast one employee with salary greater than 10000.
select department_name,department_id from departments d 
where d.department_id=any
(select e.department_id from employees e where salary>10000);
-- OR
select department_name,department_id from departments d 
where exists
(select e.department_id from employees e where salary>10000 and d.department_id=e.department_id);

# Display the name of the employees who are manager.
select first_name
from employees e1
where exists
(select 1 from employees e2 where e1.employee_id=e2.manager_id);
-- OR
select first_name from employees where employee_id in
(select  distinct manager_id from employees);

# Select salary where salary is more than dept mininum salary.
select first_name,e1.salary
from employees e1
where salary>any
(select min(salary)from employees e2 group by department_id );

# Find the highest avg salary among all the department.
select max(salary),department_id 
from employees
where salary>(select avg(salary)from employees order by salary desc);





