SELECT `user_name`, substring_index(`email`, '@', -1) as `Email Provider` FROM `users`
ORDER BY `Email Provider`, `user_name`;

SELECT `user_name`, SUBSTRING(`email`, LOCATE("@", `email`) + 1) as `Email Provider`
FROM `users`
ORDER BY `Email Provider` ASC, `user_name` ASC;