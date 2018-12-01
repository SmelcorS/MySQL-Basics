-- CREATE DATABASE `instagraph_db`;
-- USE instagraph_db;

CREATE TABLE `pictures`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    path VARCHAR(255) NOT NULL,
    size DECIMAL(10,2) NOT NULL
);


CREATE TABLE `users`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(30) NOT NULL UNIQUE,
    password VARCHAR(30) NOT NULL,
    profile_picture_id INT,
    CONSTRAINT `fk_users_pictures_picture_id` FOREIGN KEY (profile_picture_id) REFERENCES `pictures` (id)
);


CREATE TABLE `posts`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    caption VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    picture_id INT NOT NULL,
    CONSTRAINT `fk_posts_users_id` FOREIGN KEY (user_id) REFERENCES `users` (id),
    CONSTRAINT `fk_posts_users_pictures` FOREIGN KEY (picture_id) REFERENCES `pictures` (id)
);

CREATE TABLE `comments`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    CONSTRAINT `fk_comments_users_id` FOREIGN KEY (user_id) REFERENCES `users` (id),
    CONSTRAINT `fk_comments_posts_id` FOREIGN KEY (post_id) REFERENCES `posts` (id)
);

CREATE TABLE `users_followers`(
	user_id INT,
    follower_id INT,
    CONSTRAINT `fk_users_followers_users` FOREIGN KEY (user_id) REFERENCES `users` (id),
    CONSTRAINT `fk_users_followers_followers` FOREIGN KEY (follower_id) REFERENCES `users` (id)
);


-- Querying 
-- Querying 
-- Querying 
-- Querying 



SELECT id, username FROM `users`
ORDER BY id ASC;



-- Querying 
-- Querying 

SELECT id, username 
FROM `users` u
JOIN `users_followers` uf
ON uf.user_id = u.id AND uf.user_id = uf.follower_id
ORDER BY id ASC;


-- Querying 
-- Querying 


SELECT id, path, size FROM `pictures`
WHERE size > 50000 AND (path LIKE '%.png' OR path LIKE '%.jpeg')
ORDER BY size DESC;


-- Querying 
-- Querying


SELECT c.id, CONCAT(u.username, ' : ', c. content)
FROM `comments` c
JOIN `users` u
ON c.user_id = u.id
ORDER BY c.id DESC;


-- Querying 
-- Querying

SELECT u.id, u.username, CONCAT(p.size, 'KB') 
FROM `users` u
JOIN `pictures` p
ON u.profile_picture_id = p.id
JOIN
	(SELECT profile_picture_id, COUNT(id) AS `count`  FROM `users`
	GROUP BY profile_picture_id
	HAVING count > 1) AS `picture_count`
ON p.id = picture_count.profile_picture_id
ORDER BY u.id ASC;

-- Querying 
-- Querying


-- SELECT p.id, p.caption, c.count
-- FROM `posts` p
-- JOIN (SELECT post_id, COUNT(id) AS `count` FROM `comments` GROUP BY post_id ORDER BY `count` DESC) AS `c`
-- ON c.post_id = p.id
-- ORDER BY c.count DESC, p.id ASC
-- LIMIT 5;


					
-- Querying 
-- Querying

SELECT u.id, u.username, pc.posts, fc.followers
FROM `users` u
JOIN
	(SELECT user_id, COUNT(follower_id) AS `followers` FROM `users_followers` 
	GROUP BY user_id) AS fc
ON u.id = fc.user_id
JOIN 
	(SELECT user_id, COUNT(id) AS `posts` FROM `posts` 
	GROUP BY user_id) AS pc
ON u.id = pc.user_id
ORDER BY fc.followers DESC
LIMIT 1;


-- Querying 
-- Querying

SELECT u.id, u.username, COUNT(c.id) AS `my_comments`
FROM `users` u
JOIN `posts` p
ON u.id = p.user_id
LEFT JOIN `comments` c
ON c.post_id = p.id AND c.user_id = u.id
GROUP BY u.id
ORDER BY my_comments DESC, u.id ASC;



-- Querying 
-- Querying

-- SELECT tmp2.id, tmp2.username, tmp2.caption FROM
-- (SELECT u.id, u.username, p.caption, tmp.user_id, MAX(tmp.count_of_comments) 
-- FROM
-- 		(SELECT c.post_id, c.user_id, count(c.id) AS `count_of_comments` 
--         FROM `comments` c
-- 		GROUP BY c.post_id
-- 		ORDER BY c.user_id) AS `tmp`
-- JOIN `posts` p
-- ON tmp.post_id = p.id
-- JOIN `users` u
-- ON p.user_id = u.id
-- GROUP BY tmp.user_id
-- ORDER BY u.id ASC) AS `tmp2`;


-- Querying 
-- Querying

SELECT p.id, p.caption, COUNT(DISTINCT c.user_id) As `users`
FROM `posts` p
LEFT JOIN `comments` c 
ON p.id = c.post_id
GROUP BY p.id
ORDER BY users DESC, p.id ASC;


-- PROGRAMABILITY 
-- PROGRAMABILITY



DELIMITER $$
CREATE PROCEDURE udp_commit(username VARCHAR(30), password VARCHAR(30), caption VARCHAR(255), path VARCHAR(255))
BEGIN
	DECLARE user_id INT;
    DECLARE picture_id INT;
    
    
	IF ((SELECT u.password FROM `users` u WHERE u.username = username) NOT LIKE password)		
        THEN 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Password is incorrect';
    ELSEIF ((SELECT COUNT(p.id) FROM `pictures` p WHERE path = p.path) = 0 )
		THEN 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The picture does not exist!';
    ELSE 
		SET user_id := (SELECT id from `users` u  WHERE u.username = username);
		SET picture_id := (SELECT id from `pictures` p  WHERE p.path = path);
		INSERT INTO `posts` (caption, user_id, picture_id) VALUES (caption, user_id, picture_id);
		END IF;
    
END $$ DELIMITER ;

CALL udp_commit('UnderSinduxrein', '4l8nYGTKMW', 'newSEXXX', 'src/folders/resources/images/story/reformatted/img/hRI3TW31rC.img');



-- PROGRAMABILITY 
-- PROGRAMABILITY
-- PROGRAMABILITY

DELIMITER $$
CREATE PROCEDURE udp_filter (hashtag VARCHAR(50))
BEGIN
	SELECT p.id, p.caption, u.username 
    FROM `posts` p
    JOIN `users` u
    ON p.user_id = u.id
    WHERE caption LIKE CONCAT('%',CONCAT('#', hashtag),'%');
END $$ DELIMITER ;


CALL udp_filter('cool');

-- DML 
-- DML 
-- DML 
-- DML 


INSERT INTO comments(content, user_id, post_id) 
SELECT  
		(concat('Omg!', u.username, '!This is so cool!')) `content`, 
		(ceil(p.id * 3 / 2)) `user_id`, 
        p.id  `post_id`
FROM `posts` p
JOIN `users` u
ON p.user_id = u.id
WHERE p.id BETWEEN 1 AND 10;

-- DML 
-- DML 
-- DML 
-- DML 

UPDATE `users` u
JOIN
	(SELECT u.profile_picture_id, user_id, COUNT(follower_id) AS c 
	FROM `users_followers` uf
	JOIN `users` u
	ON u.id = uf.user_id
	WHERE u.profile_picture_id IS NULL
	GROUP BY user_id) as t1
ON u.id = t1.user_id
SET u.profile_picture_id = IF(t1.c = 0, t1.user_id, t1.c);


-- DML 
-- DML 
-- DML 
-- DML
DELETE FROM `users`
WHERE id IN
(SELECT t1.id FROM 
(SELECT u.id, count(follower_id) AS f_by 
FROM `users` u
LEFT JOIN `users_followers` uf
ON u.id = uf.user_id
GROUP BY u.id
HAVING f_by = 0) t1

JOIN 

(SELECT u.id, count(follower_id) AS f_s 
FROM `users` u
LEFT JOIN `users_followers` uf
ON u.id = uf.follower_id
GROUP BY u.id
HAVING f_s = 0) AS t2
ON t1.id = t2.id);



