--6. Which department have most women and which most males?
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