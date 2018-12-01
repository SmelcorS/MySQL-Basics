SELECT `deposit_group` FROM (
	SELECT `deposit_group`, AVG(`magic_wand_size`) as `mws` FROM `wizzard_deposits`
	GROUP BY `deposit_group`
    ORDER BY `mws`
    LIMIT 1
    ) AS `mws` ;

SELECT `deposit_group` FROM `wizzard_deposits`
GROUP BY `deposit_group`
HAVING AVG(`magic_wand_size`) = (
		SELECT AVG(`magic_wand_size`)
		FROM `wizzard_deposits`
		GROUP BY `deposit_group`
		ORDER BY AVG(`magic_wand_size`)
		LIMIT 1
);