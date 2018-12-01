DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with(string VARCHAR(30))
BEGIN
	SELECT t.`name`
	FROM `towns` AS t
	WHERE t.`name` LIKE CONCAT(string, '', '%')
	ORDER BY t.`name` ASC;
END $$
DELIMITER ;

CALL usp_get_towns_starting_with('b');