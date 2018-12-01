SELECT `first_name`, `last_name` FROM `employees`
WHERE lower(`first_name`) LIKE 'Sa%'
ORDER BY `employee_id` ASC;