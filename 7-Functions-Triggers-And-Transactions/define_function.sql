DELIMITER $$

CREATE FUNCTION ufn_is_word_comprised(set_of_letters VARCHAR(50), word VARCHAR(50))
RETURNS BIT
	BEGIN
        DECLARE word_length INT;
		DECLARE idx INT;
        
        SET  idx := 1;
        SET word_length = length(word);
        
        WHILE (idx <= length(word)) DO
			IF LOCATE(SUBSTRING(LOWER(word), idx, 1), LOWER(set_of_letters)) < 1
				THEN RETURN 0;
			END IF;
            SET idx := idx + 1;
		END WHILE;
        RETURN 1;
	END $$
    DELIMITER ;
    
SELECT ufn_is_word_comprised('oistmiahf', 'Sofia')
            
			
        
		
		
		
	