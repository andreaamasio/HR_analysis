# Introduction
We have 3 tables, employees (1000 employees), positions (24 positions), and departments(8 departments). A position can be shared by several employees and the same for a department; therefore the tables are connected with unique id betweem them. The data is finctional and created by me. I will use PostgreSQL as DBMS and Visual Studio Code to explore interesting facts about the employees that may be helpful for HR usage. SQL queries are visible here: [employee](/Subqueries/)

## Questions to answer:
0. Check for null values and fill the values.
1. How many males and females are hired in the organization?
2. What is the average pay for each role grouped by gender?
3. Which positions earn the most money?
4. Do manager have higher salaries of non manager?
5. Which department is more costly (employees' salary wise)?
6. Which department have most women and which most males?
7. Whose are the employees hired from more than 5 year (for benefits eligibility)?
8. Which are the employees eligible for retirement? (67 years old for males and 65 for women)
9. Which is the bigger department?


## 0. Check for null values and fill the values.
I will first check for null values and fill the missing values. "table" IS NOT NULL returns all rows that have no nulls at all (already breaking null logic), so NOT ( table IS NOT NULL) returns the rows that have at least one NULL.

```sql
SELECT * 
FROM employees 
WHERE NOT (employees IS NOT NULL);

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
```

## 1. How many males and females are hired in the organization?
I will use the the aggregated function count to answer, groupyng by the gender.

```sql
SELECT gender, count(gender) as Count_of_gender
from employees
GROUP BY gender
```
The output indicate that the majority of our employees are males:
```markdown
| Gender | Count of Gender |
|--------|-----------------|
| M      | 529             |
| F      | 471             |
```

## 2. What is the average pay for each role grouped by gender?
We can check the discrepancies in salary between genders for same positions.
```sql
SELECT p.name,gender, floor(avg(salary)) as Avg_salary
from employees e
JOIN positions p on p.position_id=e.position_id
GROUP BY p.name, gender
ORDER BY p.name, gender
```
Results are:
```markdown
| Name                | Gender | Avg Salary |
|---------------------|--------|------------|
| Accountant          | F      | 27415      |
| Accountant          | M      | 28803      |
| Analyst             | F      | 33151      |
| Analyst             | M      | 32636      |
| Business Developer  | F      | 31431      |
| Business Developer  | M      | 28514      |
| Compliance          | F      | 32129      |
| Compliance          | M      | 32628      |
| Data Expert         | F      | 26462      |
| Data Expert         | M      | 33525      |
| Driver              | F      | 33076      |
| Driver              | M      | 33002      |
| Field Analyst       | F      | 32349      |
| Field Analyst       | M      | 30385      |
| Financial Lawyer    | F      | 28637      |
| Financial Lawyer    | M      | 32614      |
| HR Specialist       | F      | 37097      |
| HR Specialist       | M      | 34682      |
| Inbound Seller      | F      | 34544      |
| Inbound Seller      | M      | 29287      |
| Lawyer              | F      | 28222      |
| Lawyer              | M      | 32349      |
| Magazine            | F      | 32070      |
| Magazine            | M      | 32273      |
| Marketer            | F      | 36009      |
| Marketer            | M      | 22914      |
| Medical Lawyer      | F      | 27751      |
| Medical Lawyer      | M      | 30660      |
| Medical Liaison     | F      | 33074      |
| Medical Liaison     | M      | 31292      |
| Online Marketer     | F      | 32853      |
| Online Marketer     | M      | 30444      |
| Outbound Seller     | F      | 39800      |
| Outbound Seller     | M      | 31389      |
| Payroll Specialist  | F      | 29847      |
| Payroll Specialist  | M      | 32564      |
| Procurement Analyst | F      | 32532      |
| Procurement Analyst | M      | 37307      |
| Product Specialist  | F      | 32686      |
| Product Specialist  | M      | 32315      |
| Recruiter           | F      | 34761      |
| Recruiter           | M      | 25718      |
| Risk Controller     | F      | 33055      |
| Risk Controller     | M      | 29949      |
| Social Media Expert | F      | 29453      |
| Social Media Expert | M      | 29601      |
| Treasury            | F      | 32334      |
| Treasury            | M      | 27322      |
```
## 3. Which positions earn the most money?
We can check which are the most costly positions for our organization.
```sql
SELECT p.name,  salary
FROM employees e 
JOIN positions p ON p.position_id=e.position_id
ORDER BY salary DESC
LIMIT 5
```
The top 5 are as below, with Lawyer as the most expensive.
```markdown
| Name             | Salary |
|------------------|--------|
| Lawyer           | 49969  |
| Data Expert      | 49922  |
| Financial Lawyer | 49910  |
| Treasury         | 49839  |
| Magazine         | 49829  |
```
## 4. Do manager have higher salaries of non manager?
To answer this questions I calculate the average salary for manager and non managers:

```sql
SELECT manager as Is_a_manager, floor(avg(salary)) as Avg_salary
FROM employees
GROUP BY manager
```
Managers have on average higher salaries as shown by the output:
```markdown
| Is a Manager | Avg Salary |
|--------------|------------|
| False        | 26,486     |
| True         | 44,839     |

```

## 5. Which department is more costly (employees' salary wise)?
I first join the table departments to extract the department name, then I group by the name department to calculate the sum of employee salaries for each department:
```sql
SELECT d.name, floor(sum(salary)) as cost
FROM employees e
JOIN departments d on d.department_id=e.department_id
GROUP BY d.name
ORDER BY cost DESC
```
The Legal department is the most expensive:
```markdown
| Name        | Cost    |
|-------------|---------|
| Legal       | 4481091 |
| Logistics   | 4157680 |
| Finance     | 4010546 |
| HR          | 3949938 |
| Field       | 3781914 |
| Sales       | 3739331 |
| Operations  | 3738427 |
| Marketing   | 3601264 |


```
## 6. Which department have most women and which most males?
I use 2 queries to answer these 2 questions, where I count for each department name each gender, then I order by the ones with the higher counts and filter for gender "M" to check which have most males, and "F" to check which have most females:
```sql
--most males:
SELECT * FROM
(SELECT e.gender, count(gender), d.name
FROM employees e
JOIN departments d on d.department_id=e.department_id
GROUP BY d.name, e.gender
ORDER BY d.name, e.gender)
WHERE gender='M'
ORDER BY count DESC
LIMIT 1
-- most women:
SELECT * FROM
(SELECT e.gender, count(gender), d.name
FROM employees e
JOIN departments d on d.department_id=e.department_id
GROUP BY d.name, e.gender
ORDER BY d.name, e.gender)
WHERE gender='F'
ORDER BY count DESC
LIMIT 1
```

Legal department has the highest number of men:
```markdown
| Gender | Count | Name  |
|--------|-------|-------|
| M      | 88    | Legal |
```
While Logistics have the highest number of women:
```markdown
| Gender | Count | Name      |
|--------|-------|-----------|
| F      | 69    | Logistics |
```
## 7. Who are the employees hired from more than 5 year (for benefits eligibility)?
Here I calculate the time the employee is hired subtracting the hire_date from today date. If the result in days (multipled by the number of years, in this case 5) is lower, it means the employee is employeed from more than 5 years:
```sql
SELECT *
FROM employees
WHERE CURRENT_DATE - hire_date > 365 *5 --365*5 it is 5 years in days
```
The query results in 832 employees hired more than 5 years ago.

## 8. Which are the employees eligible for retirement? (62 years old for males and 60 for women)

```sql
SELECT *, (CURRENT_DATE-date_of_birth)/365 as age
FROM employees
WHERE (CURRENT_DATE-date_of_birth)/365 >= 64 AND
gender = 'M'
UNION
SELECT *, (CURRENT_DATE-date_of_birth)/365 as age
FROM employees
WHERE (CURRENT_DATE-date_of_birth)/365 >= 62 AND
gender = 'F'
```
The query Results in 42 employees with retirement condition.

## 9. Which is the bigger department?
To answer this I count how many employees are in each department using the aggregation function 'count'. To get the name of the department I join with the respective table.
```sql
SELECT d.name, count(e.employee_id) as num_of_employees
FROM employees e
JOIN departments d ON d.department_id=e.department_id
GROUP BY d.name
ORDER BY num_of_employees DESC
```
Legal have the most employees:
```markdown
| Department   | Number of Employees |
|--------------|---------------------|
| Legal        | 147                 |
| Logistics    | 134                 |
| Finance      | 127                 |
| Field        | 124                 |
| Operations   | 118                 |
| HR           | 118                 |
| Sales        | 117                 |
| Marketing    | 115                 |
```

# Conclusions:
This analysis helped me practicing databases creations and manipulation, and to answer HR business related questions for a large dataset of 1000 employees.
