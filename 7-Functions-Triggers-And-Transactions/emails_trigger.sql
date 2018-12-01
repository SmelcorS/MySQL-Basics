CREATE TABLE `notification_emails`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    recipient INT NOT NULL,
    subject VARCHAR(200) NOT NULL,
    body VARCHAR(200) NOT NULL
);

DELIMITER $$
CREATE TRIGGER `tr_logs_insert_entry`
AFTER INSERT
ON `logs`
FOR EACH ROW
BEGIN	
	INSERT INTO `notification_emails`(`recipient`, `subject`, `body`)
    VALUES (NEW.account_id, 
			CONCAT('Balance change for account: ', NEW.account_id), 
			CONCAT('On ', DATE_FORMAT(NOW(), '%b %d %Y at %r'), ' your balance was changed from ', NEW.old_sum, ' to ', NEW.new_sum));
END $$ DELIMITER ;

DROP TRIGGER IF EXISTS tr_logs_insert_entry;


UPDATE accounts SET balance = balance + 10
WHERE id = 1;

UPDATE accounts SET balance = 1.1 * balance;
SELECT * FROM logs order by log_id, new_sum;


