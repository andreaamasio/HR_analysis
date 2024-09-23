--2.What is the average pay for each role grouped by gender?

SELECT p.name,gender, floor(avg(salary)) as Avg_salary
from employees e
JOIN positions p on p.position_id=e.position_id
GROUP BY p.name, gender
ORDER BY p.name, gender
