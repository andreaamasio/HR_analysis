--1. How many males and females are hired in the organization?

SELECT gender, count(gender) as Count_of_gender
from employees
GROUP BY gender

