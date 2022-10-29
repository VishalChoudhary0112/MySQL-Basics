-- JOINS--------------------------------------------------------------------------------------------------------------------------------------------

# Types of Joins :
					# Inner : Select all common records where the join is created. (by default)
                    
                    # Left  : Everything from left table and common from both.
                    
					# Right : Everything from right table and common from both.
                    
                    # Full  : Everything from both table and common from both.
                    

select * from employees;
select * from departments;

-- INNER JOINS-------------------------------------

select e.employee_id,e.department_id,d.department_name
from employees e inner join departments d
on e.department_id=d.department_id;

select employee_id,e.department_id,department_name
from employees e inner join departments d
on e.department_id=d.department_id;

-- LEFT JOINS-------------------------------------

select e.employee_id,e.department_id,d.department_name
from employees e left join departments d
on e.department_id=d.department_id;

-- RIGHT JOINS------------------------------------

select e.employee_id,e.department_id,d.department_name
from employees e right join departments d
on e.department_id=d.department_id;


# 1|. Display the first and last name,department_id and name,city and state province for each employee

select first_name,last_name,e.department_id,department_name,city,state_province
from employees e left join departments d
on e.department_id=d.department_id
left join locations l
on d.location_id=l.location_id;


# 2|. Display frist name and last name, department_id and department name for all employees for departments 80 or 40.

select first_name,last_name,e.department_id,department_name
from employees e left join departments d
on e.department_id=d.department_id
where e.department_id in (40,80);

# 3|. Display all departments including those where does not have any employees.
select department_name,d.department_id 
from departments d left join employees e
on d.department_id=e.department_id
where e.department_id is null;

# 4|. Display job title,full name , differnce between max salary and salary of each employee.
select job_title,concat(first_name,' ',last_name)full_name,max_salary,salary,max_salary-salary diff
from jobs j right join  employees e
on j.job_id=e.job_id;


# 5|. Display the first,last name and salary for those employees who earn less than the employee earn whose number is 182.
select e1.first_name,e1.last_name,e1.salary
from employees e1 join employees e2
on e1.salary<e2.salary and e2.employee_id=182;
-- OR
select e1.first_name,e1.last_name,e1.salary
from employees e1 join employees e2
on e1.salary<e2.salary
where e2.employee_id=182;

# 6|.Display the first name of all employees along with the manager_id.
select e1.first_name,e2.first_name
from employees e1 join employees e2
on e1.manager_id=e2.employee_id;

# 7|. Display the department name,average salary and number of employees working in that department.
select department_name,avg(salary),count(employee_id)
from  employees e join departments d 
on d.department_id=e.department_id
group by department_name;

# 8|. Display the full name and salary of those employees who are working in department located in london.
select concat(first_name,' ',last_name) Full_name, salary
from employees e join departments d 
on e.department_id=d.department_id
join locations l
on d.location_id=l.location_id
where city='london';

# 9|. Display employee name if the employee joined before his manager.
select e1.first_name,e1.hire_date,e2.first_name,e2.hire_date
from employees e1 join employees e2
on e1.manager_id=e2.employee_id
where e1.hire_date<e2.hire_date;

# 10|. Display the month in which more than 2 employees joined in any department located in seattle.
select month(hire_date),count(hire_date)
from employees e join departments d 
on e.department_id=d.department_id
join locations l
on d.location_id=l.location_id
where city='seattle'
group by month(hire_date)
having count(hire_date)>2
order by month(hire_date);

# 11|. Display employee name,job title for the jobs who worked less than ten months.
select first_name,e.job_id,start_date,end_date
from employees e join job_history jh
using(employee_id)
where datediff(end_date,start_date)/30<10;

-- CROSS JOIN------------------------------------------------------
# Syntax : select * from table_1
# 		   cross join table_2			

















-- FULL JOIN--------------------------------------

select e.employee_id,e.department_id,d.department_name
from employees e full join departments d
on e.department_id=d.department_id;





