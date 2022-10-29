# Store wants to release some offers on the products that was not sold not even once.Generate product list to release offer.

select * from products where productcode not in
(select distinct productCode from orderdetails);



# The company is planing on realising offers to convert the inactive customers to active.

select * 
from customers where customerNumber not in
(select distinct customernumber from orders);

# Generate the list top 10 customers who have done maximum payments to the store.

select * 
from customers join
(select distinct customernumber,
sum(amount)over(partition by customernumber )max_pay
from payments)t
using(customernumber)
order by max_pay desc
limit 10;


-- OR

select * 
from customers join 
(select customernumber from payments
group by customernumber
order by sum(amount) desc limit 10) temp
on customers.customernumber=temp.customernumber;

# List of emp who assisted the customers to place orders that were shipped within a span of one day of order getting placed.

select * from employees join
(select distinct salesrepemployeenumber from customers where customerNumber in
(select customernumber from orders where datediff(shippeddate,orderdate)<=1))temp
on employees.employeeNumber=temp.salesrepemployeenumber;


# Generate list of productlines which are always ordered in bulk of more than 50 nos.






-- First value(), Last value() :

select department_id,employee_id,salary,
last_value(salary)over(order by salary desc
rows between unbounded preceding and unbounded following)val
from employees
where department_id=80;

select department_id,salary,
sum(salary)over(partition by department_id rows between unbounded preceding and current row)sum_val
from employees;


select department_id,salary,
sum(salary)over(rows between current row and unbounded following)sum_val
from employees;

select department_id,salary,
sum(salary)over(rows between 1 preceding and 1 following)sum_val
from employees;

# Accumilative avg :
select department_id,salary,
avg(salary)over(partition by department_id rows between unbounded preceding and current row) sum_vall
from employees
where department_id in (80,90);



-- ntile :

select employee_id,salary,ntile(5)over() sal_tag
from employees;


# Calculate the dept on which the org is spending more in terms of salary.


select d.department_id,department_name,sum_sal
from departments d join
(select department_id,sum(salary)over(partition by department_id) sum_sal
from employees)t
using(department_id)
order by sum_sal desc
limit 1;

# Find out how many 'IT-PROG' are moderately paid.

select *,
case
when sal_tag like 1 then 'High'
when sal_tag like 2 then 'Moderate'
when sal_tag like 3 then 'Low'
end tag
from
(select *,ntile(3)over() sal_tag
from employees
where job_id='IT_prog')t
where sal_tag=2;

# Find the 3 worst performers
select *,rank()over(order by employee_rating) rnk
from employee_details;


-- ------------------------------------------------------------------------------------------------------------------------
create database trans;
use trans;

create table parent
(
	id int primary key,
    name varchar(10)
);

create table child
(
	id int,
	dept varchar(10),
    salary int,
    foreign key(id) references parent(id)
    
);

insert into parent values
(103,'CCC'),
(104,'DDD');

insert into child values
(101,'MKT',5000),
(102,'MKT',6000),
(102,'sales',5500),
(102,'sales',5500),
(103,'IT',5000);

select * from child;

-- Restrict / No Action :
delete from parent where id=102;

drop table child;

create table child
(
	id int,
	dept varchar(10),
    salary int,
    foreign key(id) references parent(id)
    on delete cascade on update cascade
);

insert into child values
(101,'MKT',5000),
(102,'MKT',6000),
(102,'sales',5500),
(102,'sales',5500),
(103,'IT',5000);


delete from parent where id=102;

update parent set id=200 where id=103;

select * from parent;

select * from child;

-- set null :

create table child
( id int,
  dept varchar(10),
  salary int,
  foreign key(id) references parent(id)
  on delete set null on update set null);

insert into child values
(101,'MKT',5000),
(102,'MKT',6000),
(102,'sales',5500),
(102,'sales',5500),
(103,'IT',5000);2






































