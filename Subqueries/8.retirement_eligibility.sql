/*8. Which are the employees eligible for retirement? 
(62 years old for males and 60 for women)*/

SELECT *, (CURRENT_DATE-date_of_birth)/365 as age
FROM employees
WHERE (CURRENT_DATE-date_of_birth)/365 >= 64 AND
gender = 'M'
UNION
SELECT *, (CURRENT_DATE-date_of_birth)/365 as age
FROM employees
WHERE (CURRENT_DATE-date_of_birth)/365 >= 62 AND
gender = 'F'

