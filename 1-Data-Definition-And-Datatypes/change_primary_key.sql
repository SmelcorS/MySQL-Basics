ALTER TABLE `users`
MODIFY id INT,
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users PRIMARY KEY (`id`, `username`);