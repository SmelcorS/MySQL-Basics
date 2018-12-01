DELIMITER $$

CREATE PROCEDURE usp_get_holders_full_name()
	BEGIN
		SELECT CONCAT(a.`first_name`, ' ', a.`last_name`) AS `full_name` FROM `account_holders` as a
        ORDER BY `full_name` ASC, `id` ASC;
	END $$
DELIMITER ;

CALL usp_get_holders_full_name;