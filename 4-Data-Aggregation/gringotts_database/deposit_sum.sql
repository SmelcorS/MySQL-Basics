SELECT `deposit_group`, SUM(`deposit_amount`) as `total_sum` FROM `wizzard_deposits`
GROUP BY `deposit_group`
ORDER BY `total_sum` ASC;