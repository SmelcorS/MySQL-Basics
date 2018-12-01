DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account(acount_id INT, interest_rate DECIMAL(19,4)) 
BEGIN 
	SELECT a.id, ah.first_name, ah.last_name, 
    SUM(a.balance) AS current_balance, 
    ufn_calculate_future_value(SUM(a.balance), interest_rate, 5) AS `balance_in_5_years`
    FROM `account_holders` AS ah
    JOIN `accounts` as a
    ON ah.id = a.account_holder_id
    WHERE a.id = acount_id
    GROUP BY a.account_holder_id;
END $$
DELIMITER ;



CALL usp_calculate_future_value_for_account(1, 0.1);