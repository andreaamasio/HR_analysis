--0. Check for null values and fill the values.

SELECT *
FROM employees
where salary is NULL

--update employee_id 489,627,685 first_names and gender
update employees
set first_name = 'Paul', gender = 'M'
where employee_id=489;
update employees
set first_name = 'Tom', gender = 'M'
where employee_id=627;
update employees
set first_name = 'Lucy', gender = 'F'
where employee_id=685;