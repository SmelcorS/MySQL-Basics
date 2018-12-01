SELECT `name`, case
				  when extract(hour FROM `start`) >= 0 AND extract(hour FROM `start`) < 12 THEN 'Morning'
                  when extract(hour FROM `start`) >= 12 AND extract(hour FROM `start`) < 18 THEN 'Afternoon'
                  when extract(hour FROM `start`) >= 18 AND extract(hour FROM `start`) < 24 THEN 'Evening' end
                  AS `Part of the Day`,
				
			   case
				  when `duration` <= 3 THEN 'Extra Short'
                  when `duration` > 3 AND `duration` <= 6 THEN 'Short'
                  when `duration` > 6 AND `duration` <= 10 THEN 'Long'
                  when `duration` > 10 OR `duration`IS NULL THEN 'Extra Long' end
                  As `Duration`
                  
FROM `games`
ORDER BY `name` ASC;