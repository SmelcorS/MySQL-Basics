DELIMITER $$
CREATE FUNCTION ufn_calculate_future_value(input_sum DOUBLE, input_interest_rate DECIMAL(19,4), input_num_years INT)
RETURNS DECIMAL(19,4)
	BEGIN
		DECLARE output DECIMAL(19,4);
        SET output := input_sum * POW((1 + input_interest_rate), input_num_years);
        RETURN output;
	
	END $$
DELIMITER ;
    
SELECT `ufn_calculate_future_value`(123.12, 0.1, 5);
   