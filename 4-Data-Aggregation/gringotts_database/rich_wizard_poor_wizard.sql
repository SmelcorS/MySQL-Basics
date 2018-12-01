SELECT SUM(`difference`) AS `sum_difference` FROM (SELECT `wd1`.`first_name` AS `host_wizzard`, `wd1`.`deposit_amount` AS `host_wizzard_deposit`, 
		`wd2`.`first_name` AS `guest_wizzard`, `wd2`.`deposit_amount` AS `guest_wizzard_deposit`,
        `wd1`.`deposit_amount` - `wd2`.`deposit_amount` AS `difference`
FROM `wizzard_deposits` AS `wd1`,  `wizzard_deposits` AS `wd2`
WHERE `wd1`.`id` + 1 = `wd2`.`id`) AS `full_record`;