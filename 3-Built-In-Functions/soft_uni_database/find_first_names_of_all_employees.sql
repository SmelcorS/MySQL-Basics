SELECT `first_name` FROM `employees`
WHERE `department_id` IN(3, 10) AND extract(year FROM `hire_date`) BETWEEN 1995 AND 2005;