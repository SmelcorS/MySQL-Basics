CREATE DATABASE `movies`;

USE `movies`;

CREATE TABLE `directors` (
	id INT PRIMARY KEY AUTO_INCREMENT,
    director_name VARCHAR(40) NOT NULL,
    notes TEXT
);

INSERT INTO `directors` (`director_name`) VALUES 
('Wes Anderson'),
('Vasko Bamburski'), 
('George Lucas'),
('Peter Jackson'),
('Alan Rickman');


CREATE TABLE `genres` (
	id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(40) NOT NULL,
    notes TEXT
);

INSERT INTO `genres` (`genre_name`) VALUES 
('Drama'),
('Action'), 
('Comedy'),
('Fantasy'),
('Thriller');


CREATE TABLE `categories` (
	id INT PRIMARY KEY AUTO_INCREMENT,
    categories_name VARCHAR(40) NOT NULL,
    notes TEXT
);

INSERT INTO `categories` (`categories_name`) VALUES 
('G'),
('PG'), 
('PG-13'),
('R'),
('NC-17');



CREATE TABLE `movies` (
	id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(60) NOT NULL UNIQUE,
    director_id INT NOT NULL,
    copyright_year YEAR NOT NULL,
    length TIME NOT NULL,
    genre_id INT NOT NULL,
    category_id INT NOT NULL,
    rating DECIMAL,
    notes TEXT
);

ALTER TABLE `movies`
ADD CONSTRAINT FK_Director_id FOREIGN KEY (`director_id`) REFERENCES `directors`(`id`),
ADD CONSTRAINT FK_Genre_id FOREIGN KEY (`genre_id`) REFERENCES `genres`(`id`),
ADD CONSTRAINT FK_Category_id FOREIGN KEY (`category_id`) REFERENCES `categories`(`id`);

INSERT INTO `movies` (`title`, `director_id`, `copyright_year`, `length`, `genre_id`, `category_id`)
VALUES ('Alien', 1, '2050', '2.20', 2, 3), 
	('Predator', 4, '2050', '2.20', 4, 1),
	('Alien vs Predator', 1, '2050', '2.20', 2, 3),
	('Prometheus', 1, '2050', '2.20', 2, 3),
	('Covenant', 5, '2050', '2.20', 2, 3);
    






