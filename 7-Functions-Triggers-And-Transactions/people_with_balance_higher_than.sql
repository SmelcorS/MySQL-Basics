DELIMITER $$
CREATE PROCEDURE usp_get_holders_with_balance_higher_than(number INT)
	BEGIN
		SELECT `first_name`, `last_name` FROM (
			SELECT a.`first_name`, a.`last_name`, SUM(`balance`) AS `sum` FROM `account_holders` as a
			JOIN `accounts` AS ac
            ON a.`id` = ac.`account_holder_id`	
            GROUP BY a.`id`
            HAVING number < `sum`
			ORDER BY ac.`id`, a.`first_name` ASC, a.`last_name` ASC) AS S;
END $$
DELIMITER ;
    
CALL `usp_get_holders_with_balance_higher_than`(7000);
   