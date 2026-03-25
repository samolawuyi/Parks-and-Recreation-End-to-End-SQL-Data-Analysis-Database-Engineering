SELECT * 
FROM parks_and_recreation.employee_demographics;

SELECT first_name, 
last_name,
birth_date,
age,
(age + 10) * 10 + 10
FROM parks_and_recreation.employee_demographics;
#pemdas

SELECT distinct first_name, gender
FROM parks_and_recreation.employee_demographics;

-- where clause
SELECT * 
FROM parks_and_recreation.employee_salary
WHERE first_name = 'Leslie';

SELECT * 
FROM parks_and_recreation.employee_salary
where salary >= 50000
;

SELECT * 
FROM parks_and_recreation.employee_salary
where salary <= 50000
;

SELECT * 
FROM parks_and_recreation.employee_demographics
where gender ='female'
;

SELECT * 
FROM parks_and_recreation.employee_demographics
where gender !='female'
;

SELECT * 
FROM parks_and_recreation.employee_demographics
where birth_date > '1985-01-01'
;

-- and or not -- logical operators
SELECT * 
FROM parks_and_recreation.employee_demographics
where birth_date > '1985-01-01'
and gender = 'male'
;

SELECT * 
FROM parks_and_recreation.employee_demographics
where birth_date > '1985-01-01'
or gender = 'male'
;

SELECT * 
FROM parks_and_recreation.employee_demographics
where birth_date > '1985-01-01'
or not gender = 'male'
;

SELECT * 
FROM parks_and_recreation.employee_demographics
where first_name = ('Leslie' and age = '44') or age > 55
;

-- like statement
-- % and _
SELECT * 
FROM parks_and_recreation.employee_demographics
where first_name like 'a%'
;

SELECT * 
FROM parks_and_recreation.employee_demographics
where first_name like 'a___%'
;

SELECT * 
FROM parks_and_recreation.employee_demographics
where birth_date like '1989%'
;

-- Group by

select gender, avg (age)
from employee_demographics
group by gender
;

select occupation, salary
from employee_salary
group by occupation,salary
;

select gender, avg(age), max(age), min(age), count(age)
from employee_demographics
group by gender
;

-- order by
select *
from employee_demographics
order by gender, age
;

-- having vs where

select gender, avg(age)
from employee_demographics
group by gender
having avg(age) > 40
;

select occupation, avg(salary)
from employee_salary
where occupation like'%manager%'
group by occupation
having avg(salary) > 75000
;

-- limit & aliasing

select *
from employee_demographics
order by age desc 
limit 2, 1
;

-- aliasing

select gender, avg (age) avg_age
from employee_demographics
group by gender
having avg (age) > 40
;

-- joins

select *
from employee_demographics;

select *
from employee_salary;

select *
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

select dem.employee_id,age, occupation
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

-- Outer joins

select *
from employee_demographics as dem
left join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

select *
from employee_demographics as dem
right join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

-- self join

select *
from employee_salary emp1
join employee_salary emp2
	on emp1.employee_id + 1 = emp2.employee_id
;

select emp1.employee_id as emp_santa,
emp1.first_name as first_name_santa,
emp1.last_name as last_name_santa,
emp2.employee_id as emp_name,
emp2.first_name as first_name_emp,
emp2.last_name as last_name_emp
from employee_salary emp1
join employee_salary emp2
	on emp1.employee_id + 1 = emp2.employee_id
;

-- joining multiple tables together

select *
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id
inner join parks_departments pd
	on sal.dept_id = pd.department_id
;

select *
from parks_departments;

-- unions

select first_name, last_name
from employee_demographics
union distinct
select first_name, last_name
from employee_salary
;

select first_name, last_name
from employee_demographics
union all
select first_name, last_name
from employee_salary
;

select first_name, last_name, 'old man' as label
from employee_demographics
where age> 40 and gender = 'male'
union
select first_name, last_name, 'old lady' as label
from employee_demographics
where age> 40 and gender = 'female'
union
select first_name, last_name, 'highly paid employee' as label
from employee_salary
where salary > 70000
order by first_name, last_name
;

-- strings functions

select length('skyfall');

select first_name, length(first_name)
from employee_demographics
order by 2;

select upper('sky');
select lower ('sky');

select first_name, upper (first_name)
from employee_demographics;

select rtrim('       sky       ');

select first_name, 
left(first_name, 4),
right(first_name, 4),
substring(first_name,3,2),
birth_date,
substring(birth_date, 6,2) as birth_month
from employee_demographics;

select first_name, replace(first_name,'a', 'z')
from employee_demographics;

select locate('x', 'Alexander');

select first_name, locate('an', first_name)
from employee_demographics;

select first_name, last_name,
concat(first_name,' ', last_name)
from employee_demographics;

-- case statements

select first_name,
last_name,
age,
case
	when age <= 30 then 'young'
    when age between 31 and 50 then 'old'
    when age >= 50 then "on death's door"
end as age_bracket
from employee_demographics;

-- pay increase and bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- finance = 10% bonus


select first_name, last_name, salary,
case
	when salary < 50000 then salary * 1.05
    when salary > 50000 then salary * 1.07
    end as new_salary,
case
    when dept_id = 6 then salary * .10
end as bonus
from employee_salary;

select *
from employee_salary;
select *
from parks_departments;

-- subqueries

select *
from employee_demographics
where employee_id in 
				( select employee_id
					from	employee_salary
                    where dept_id = 1)
;

select first_name, salary,
(select avg (salary)
from employee_salary)
from employee_salary;

select gender, avg(age), max(age), min(age), count(age)
from employee_demographics
group by gender;

select gender, avg(`max(age)`)
from 
(select gender, avg(age), max(age), min(age), count(age)
from employee_demographics
group by gender) as agg_table
group by gender;

select avg(max_age)
from 
(select gender, avg(age) as avg_age, 
max(age) as max_age, 
min(age) as min_age, 
count(age)
from employee_demographics
group by gender) as agg_table
;

-- window functions

select *
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id;

select gender, avg(salary) as avg_salary
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender;

select gender, avg(salary) over(partition by gender)
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
;

select dem.first_name, dem.last_name, gender, avg(salary) over(partition by gender)
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
;

select dem.first_name, dem.last_name, gender, avg(salary) as avg_salary
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by dem.first_name, dem.last_name, gender
;

select dem.first_name, dem.last_name, gender, salary,
sum(salary) over(partition by gender order by dem.employee_id) as rolling_total
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
;

select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() over(partition by gender order by salary desc) as row_num,
rank () over(partition by gender order by salary desc) as rank_num,
dense_rank () over(partition by gender order by salary desc) as dense_rank_num
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
;
																																	

-- CTEs


with CTE_Example as 
(
select gender, avg(salary) avg_sal, max(salary) max_sal, min(salary) min_sal, count(salary) count_sal
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender
)
select avg(avg_sal)
from CTE_Example
;

select avg (avg_sal)
from (
select gender, avg(salary) avg_sal, max(salary) max_sal, min(salary) min_sal, count(salary) count_sal
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender
) example_subquery
;


with CTE_Example as 
(
select gender, avg(salary) avg_sal, max(salary) max_sal, min(salary) min_sal, count(salary) count_sal
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender
)
select avg(avg_sal)
from CTE_Example
;

select avg(avg_sal)
from CTE_Example;


with CTE_Example as 
(
select employee_id, gender, birth_date
from employee_demographics
where birth_date > '1985-01-01'
),
CTE_Example2 as 
(
select employee_id, salary
from employee_salary
where salary > 50000
)
select *
from CTE_Example
join CTE_Example2
	on CTE_Example.employee_id = CTE_Example2.employee_id
;


with CTE_Example (gender, avg_sal, max_sal, min_sal, count_sal)as 
(
select gender, avg(salary) avg_sal, max(salary) max_sal, min(salary) min_sal, count(salary) count_sal
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender
)
select *
from CTE_Example
;


-- Temporary Tables

create temporary table temp_table
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);

select *
from temp_table;

insert into temp_table
values('Samuel', 'Olawuyi', 'Vampire Diaries');

select *
from temp_table;


select *
from employee_salary;


create temporary table salary_over_50k
select *
from employee_salary
where salary > 50000;

select*
from salary_over_50k;


-- Stored Procedures

select *
from employee_salary
where salary >=50000;

create procedure large_salaries()
select *
from employee_salary
where salary >=50000;

call large_salaries();

delimiter $$
create procedure large_salaries3()
begin
	select *
	from employee_salary
	where salary >=50000;
	select *
	from employee_salary
	where salary >=10000;
end $$
delimiter ;

call large_salaries3()


delimiter $$
create procedure large_salaries4(p_employee_id int)
begin
	select salary
	from employee_salary
	where employee_id = p_employee_id
	;
end $$
delimiter ;

call large_salaries4(1)
;


-- Triggers and Events		

select *
from employee_demographics;

select *
from employee_salary;

delimiter $$
create trigger employee_insert
	after insert on employee_salary
	for each row 
begin
	insert into employee_demographics (employee_id, first_name, last_name)
    values (new.employee_id, new.first_name, new.last_name);
end$$
delimiter ;

insert into employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
values (13, 'jean ralphio', 'saperstein', 'entertainment 720 ceo', 1000000, null);



-- Events

select *
from employee_demographics;

delimiter $$
create event delete_retirees
on schedule every 30 second
do
begin
	delete
	from employee_demographics
	where age >= 60;
end $$

show variables like 'event%';