SELECT `c`.`country_code`, COUNT(`m`.`mountain_range`) AS `mountain_range`
	FROM `countries` AS `c`
    LEFT OUTER JOIN `mountains_countries` AS `nc`
    ON `c`.`country_code` = `nc`.`country_code`
	LEFT OUTER JOIN `mountains` AS `m`
    ON `nc`.`mountain_id` = `m`.`id`
WHERE `c`.`country_code` IN ('BG', 'RU', 'US')
GROUP BY `country_code`
ORDER BY `mountain_range` DESC;


