--4. Do manager have higher salaries of non manager?

SELECT manager as Is_a_manager, floor(avg(salary))
FROM employees
GROUP BY manager