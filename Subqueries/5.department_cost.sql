--5. Which department is more costly (employees' salary wise)?

SELECT d.name, floor(avg(salary)) as cost
FROM employees e
JOIN departments d on d.department_id=e.department_id
GROUP BY d.name
ORDER BY cost DESC