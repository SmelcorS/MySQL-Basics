SELECT `country_name`, `iso_code` FROM `countries`
WHERE  length(`country_name`) - length(REPLACE(LOWER(`country_name`), 'a', '')) >= 3
ORDER BY `iso_code`;

SELECT `country_name`, `iso_code` FROM `countries`
WHERE  LOWER(`country_name`) LIKE '%a%a%a'
ORDER BY `iso_code`;