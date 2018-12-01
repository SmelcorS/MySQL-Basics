SELECT `name` FROM `towns`
WHERE length(`name`) IN (5,6)
ORDER BY `name` ASC;