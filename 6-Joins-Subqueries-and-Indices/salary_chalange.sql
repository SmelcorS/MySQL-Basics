SELECT e.first_name, e.last_name, e.department_id
FROM `employees` as e
JOIN
(SELECT AVG(e.salary) AS `avg_salary`, e.department_id 
FROM `employees` e
GROUP BY e.department_id) AS `average_salary`
ON e.`department_id` = `average_salary`.department_id
WHERE e.salary > `average_salary`.avg_salary
ORDER BY e.department_id, e.employee_id
LIMIT 10;


