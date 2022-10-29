-- Subqueries: Select Clause--------------------------------------------------------------------------------------------------------------

select count(employee_id) cnt_emp,
(select count(department_id)from departments)cnt_dept
from employees;

-- OR

select
(select count(employee_id) from employees) emp_cnt,
(select count(department_id)from departments) dept_cnt
from dual;


# Using co-relations :
select employee_id, department_id ,
(select department_name from departments d 
where d.department_id= e.department_id) d_name
from employees e;


# Display employee name along with manager name.
select employee_id,first_name,
(select first_name from employees e2
where e1.manager_id=e2.employee_id)manager_name
from employees e1;


-- Subquery : From clause -------------------------------------------------------------------------

# Calculate bonus 20% on salary list bonus>2000.
-- Derived table / Inline table.

select * from
(select employee_id,department_id,salary,salary*0.2 bonus from employees)temp
where bonus>2000;

-- Common table expression using WITH clause :

with temp as
(select employee_id,department_id,salary,salary*0.2 bonus from employees )
select * from temp where bonus>2000;


select job_tag,count(job_tag) from
(select job_id,
case
when job_id like '%mgr%' then 'manager'
when job_id like '%clerk%' then 'Clerk'
end job_tag
from employees
where job_id like '%mgr%' or job_id like '%clerk%')t
group by job_tag;


select * from 
(select department_id, job_id, count(job_id)COUNTED
from employees
where department_id=80
group by department_id,job_id)t1
cross join
(select count(*) from employees where department_id=80)t2;


-- Advanced aggregrate functions---------------------------------------------------------------

-- row_number() :
select * from
(select employee_id,first_name,salary,
row_number()over() 'S.No' from employees)temp
 where `S.No` between 10 and 20;

-- rank function() :

select employee_id,first_name,salary,
rank()over(order by salary desc) rnk
from employees;
# Dense rank:
select employee_id,first_name,salary,
rank()over(order by salary desc) rnk,
dense_rank()over(order by salary desc)dense_rnk
from employees;

-- 2nd top earner from every dept.
select * from
(select employee_id,department_id,salary,
dense_rank()over(partition by department_id order by salary desc) drnk
from employees)t 
where drnk=2;

-- Count distribution function () :

select employee_id,department_id,salary,
cume_dist()over(order by salary asc) c_dist
from employees;

#Higest salary in each department.
select * from
(select employee_id,department_id,salary,
dense_rank()over(partition by department_id order by salary desc) drnk
from employees)t 
where drnk=1;


# Organisation wise min max avg
select * from
(select employee_id,department_id,salary,
max(salary)over() max_sal,
min(salary)over() min_sal,
avg(salary)over() avg_sal
from employees)t;

select * from
(select employee_id,department_id,salary,
max(salary)over(partition by department_id) max_sal,
min(salary)over(partition by department_id) min_sal,
avg(salary)over(partition by department_id) avg_sal
from employees)t
where department_id=90;


# 2nd highest salary in each department.
select * from
(select employee_id,department_id,salary,
dense_rank()over(partition by department_id order by salary desc) drnk
from employees)t 
where drnk=2;

# List emp who joined the org recently.
select employee_id,department_id,hire_date from
(select employee_id,department_id,hire_date,
rank()over(partition by department_id order by hire_date desc)rnnk
from employees)t
where rnnk=1;


-- LEAD AND LAG FUNCTION :

select department_id,salary,lag(salary)over(partition by department_id) last_val
from employees;


select department_id,salary,lead(salary)over(partition by department_id) next_val
from employees;


select department_id,salary,lead(salary,2)over(partition by department_id) next_val
from employees;



select employee_id,first_job,promoted_job,job_id current_job
from employees left join
(select * from
(select employee_id,job_id first_job,lead(job_id)over(partition by employee_id order by start_date) promoted_job from job_history)t
where promoted_job is not null)job_details
using(employee_id);

select department_id,avg(dt_diff) from
(select *,datediff(next_hire,hire_date) dt_diff from
(select department_id,hire_date,lead(hire_date)over(partition by department_id by hire_date) next_hire
 from employees)t)tt
 group by department_id;











