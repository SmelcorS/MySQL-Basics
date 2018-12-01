-- CReATE DATABASE buhtig;
--  use buhtig;

CREATE TABLE `users`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(30) NOT NULL UNIQUE,
	password VARCHAR(30) NOT NULL,
    email VARCHAR(50) NOT NULL
);

CREATE TABLE `repositories`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE `repositories_contributors`(
	repository_id INT,
    contributor_id INT, 
    CONSTRAINT `fk_users_many` FOREIGN KEY (contributor_id) REFERENCES `users`(id),
    CONSTRAINT `fk_repositories_many` FOREIGN KEY (repository_id) REFERENCES `repositories`(id)
);

CREATE TABLE `issues`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
	issue_status VARCHAR(6) NOT NULL,
    repository_id INT NOT NULL,
    assignee_id INT NOT NULL,
    CONSTRAINT `fk_users_issues` FOREIGN KEY (assignee_id) REFERENCES `users`(id),
	CONSTRAINT `fk_repositories_issues` FOREIGN KEY (repository_id) REFERENCES `repositories`(id)
);

CREATE TABLE `commits`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    message VARCHAR(255) NOT NULL,
	issue_id INT,
    repository_id INT NOT NULL,
    contributor_id INT NOT NULL,
    CONSTRAINT `fk_users` FOREIGN KEY (contributor_id) REFERENCES `users`(id),
    CONSTRAINT `fk_repositories` FOREIGN KEY (repository_id) REFERENCES `repositories`(id),
	CONSTRAINT `fk_issues` FOREIGN KEY (issue_id) REFERENCES `issues`(id)
);

CREATE TABLE `files`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
	size DECIMAL(10, 2) NOT NULL,
    parent_id INT,
    commit_id INT NOT NULL,
    CONSTRAINT `fk_commits` FOREIGN KEY (commit_id) REFERENCES `commits`(id),
    CONSTRAINT `fk_parents` FOREIGN KEY (parent_id) REFERENCES `files`(id)
);

SELECT COLUMN_KEY FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
AND COLUMN_NAME IN ('id', 'user_id', 'repository_id', 'contributor_id', 'commit_id', 'assignee_id', 'issue_id', 'parent_id')
ORDER BY TABLE_NAME;


