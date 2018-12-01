DELIMITER $$
CREATE PROCEDURE usp_transfer_money(account_id_1 INT, account_id_2 INT, money_amount DECIMAL(19,4))
BEGIN
	START TRANSACTION;
		UPDATE `accounts` AS a
		SET a.balance = a.`balance` + `money_amount`
		WHERE a.id = `account_id_2`;
        
        UPDATE `accounts` AS a
		SET a.balance = a.`balance` - `money_amount`
		WHERE a.id = `account_id_1`;
        
        
		IF account_id_1 NOT IN (SELECT a.id FROM accounts AS a)
			OR account_id_2 NOT IN (SELECT a.id FROM accounts AS a)
        THEN 
			ROLLBACK;
		ELSEIF (SELECT `balance` FROM `accounts` AS a WHERE a.id = `account_id_1`) - `money_amount` < 0
		THEN
			ROLLBACK;
        ELSEIF  `account_id_1` = `account_id_2` 
        THEN 
			ROLLBACK;
        ELSEIF `money_amount` < 0
        THEN 
			ROLLBACK;
		ELSE
			COMMIT;
		END IF;
END $$
DELIMITER ;

CALL usp_withdraw_money(1, 10);

SELECT * FROM accounts AS a WHERE a.id = 1;



