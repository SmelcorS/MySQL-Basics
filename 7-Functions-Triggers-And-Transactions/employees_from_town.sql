DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(40))
BEGIN
	SELECT e.`first_name`, e.`last_name`
	FROM `employees` AS e
    JOIN `addresses` AS a
    ON e.`address_id` = a.`address_id`
    JOIN `towns` AS t
    ON a.`town_id` = t.`town_id`
	WHERE t.`name` LIKE town_name
	ORDER BY e.`first_name` ASC, e.`last_name` ASC;
END $$ DELIMITER ;

CALL usp_get_employees_from_town('Sofia');
