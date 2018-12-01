DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above (salary DECIMAl(19,2))
BEGIN 
	SELECT e.first_name, e.last_name FROM `employees` AS e
    WHERE e.salary >= salary
    ORDER BY e.first_name ASC, e.last_name ASC, e.employee_id ASC;
END $$
DELIMITER ;
    
CALL `usp_get_employees_salary_above`(48100);