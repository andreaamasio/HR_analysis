--4. Do manager have higher salaries of non manager?

SELECT manager as Is_a_manager, floor(avg(salary)) as Avg_salary
FROM employees
GROUP BY manager