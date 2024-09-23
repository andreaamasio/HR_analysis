--3. Which positions earn the most money?

SELECT p.name,  salary
FROM employees e 
JOIN positions p ON p.position_id=e.position_id
ORDER BY salary DESC
LIMIT 5