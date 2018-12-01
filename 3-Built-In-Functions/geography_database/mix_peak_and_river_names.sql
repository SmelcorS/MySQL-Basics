SELECT `peak_name`, `river_name`, concat(LOWER(`peak_name`), SUBSTRING(LOWER(`river_name`), 2)) as `mix` FROM `peaks`, `rivers`
WHERE RIGHT(`peak_name`, 1) = LEFT(`river_name`, 1)
ORDER BY `mix`;