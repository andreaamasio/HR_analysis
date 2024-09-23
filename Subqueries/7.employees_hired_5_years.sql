/*7. Whose are the employees hired from more than 5 year 
(for benefits eligibility)?*/

SELECT *
FROM employees
WHERE CURRENT_DATE - hire_date > 365 *5
