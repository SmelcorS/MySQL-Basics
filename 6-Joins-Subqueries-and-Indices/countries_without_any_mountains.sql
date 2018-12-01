SELECT COUNT(c.`country_code`), mc.`mountain_id` 
FROM `countries` c
LEFT JOIN `mountains_countries` mc
ON c.country_code = mc.country_code
WHERE `mountain_id` IS NULL;