SELECT `c`.`country_name`, `r`.`river_name` AS `river_name`
	FROM `countries` AS `c`
    JOIN `continents` as `c1`
    ON `c`.`continent_code` = `c1`.`continent_code`
    LEFT JOIN `countries_rivers` AS `rc`
    ON `c`.`country_code` = `rc`.`country_code`
	LEFT JOIN `rivers` AS `r`
    ON `rc`.`river_id` = `r`.`id`
    WHERE `c`.`continent_code` = 'AF'
ORDER BY `c`.`country_name` ASC
LIMIT 5;


