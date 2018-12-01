CREATE TABLE `logs`(
	log_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    old_sum DECIMAL(19,4) NOT NULL,
    new_sum DECIMAL(19,4) NOT NULL
);

DELIMITER $$
CREATE TRIGGER `tr_balance_change`
AFTER UPDATE
ON `accounts`
FOR EACH ROW
BEGIN	
	INSERT INTO `logs`(`account_id`, `old_sum`, `new_sum`) VALUES (OLD.id, OLD.balance, NEW.balance);
END $$ DELIMITER ;

UPDATE accounts SET balance = balance + 10
WHERE id = 1;

UPDATE accounts SET balance = 1.1 * balance;
SELECT * FROM logs order by log_id, new_sum;


