--9. Which is the bigger department?

SELECT d.name, count(e.employee_id) as num_of_employees
FROM employees e
JOIN departments d ON d.department_id=e.department_id
GROUP BY d.name
ORDER BY num_of_employees DESC