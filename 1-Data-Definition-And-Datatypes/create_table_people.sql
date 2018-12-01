CREATE TABLE `people`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    picture BLOB,
    height FLOAT(2),
    weight FLOAT(2),
    gender ENUM('f', 'm') NOT NULL, 
    birthdate DATE NOT NULL,
    biography TEXT(65365)
);

INSERT INTO `people`(`name`, `gender`, `birthdate`) VALUES
('Conko', 'm', '2000-06-06'),
('Ganka', 'f', '1998-03-11'),
('Iovka', 'f', '2001-06-06'),
('Minko', 'm', '2002-03-16'),
('Dancho', 'm', '1989-11-26');