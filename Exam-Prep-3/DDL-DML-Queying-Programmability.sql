-- CREATE DATABASE `colonial_journey_management_system_db`;
-- USE `colonial_journey_management_system_db`;

CREATE TABLE `planets`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL
);

CREATE TABLE `spaceports`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    planet_id INT,
    CONSTRAINT `fk_spaceports_planets` FOREIGN KEY (planet_id) REFERENCES `planets` (id)
);

CREATE TABLE `spaceships`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    manufacturer VARCHAR(30) NOT NULL,
    light_speed_rate INT DEFAULT 0
);

CREATE TABLE `colonists`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    ucn CHAR(10) NOT NULL UNIQUE,
    birth_date DATE NOT NULL
);

CREATE TABLE `journeys`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    journey_start DATETIME NOT NULL,
    journey_end DATETIME NOT NULL,
    purpose ENUM('Medical', 'Technical', 'Educational', 'Military'),
    destination_spaceport_id INT,
    spaceship_id INT,
    CONSTRAINT `fk_journeys_spaceports` FOREIGN KEY (destination_spaceport_id) REFERENCES `spaceports` (id),
    CONSTRAINT `fk_journeys_spaceships` FOREIGN KEY (spaceship_id) REFERENCES `spaceships` (id)
);

CREATE TABLE `travel_cards`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    card_number CHAR(10) NOT NULL UNIQUE,
    job_during_journey ENUM('Pilot', 'Engineer', 'Trooper', 'Cleaner', 'Cook'),
    colonist_id INT,
    journey_id INT,
    CONSTRAINT `fk_travel_cards_colonists` FOREIGN KEY (colonist_id) REFERENCES `colonists` (id),
    CONSTRAINT `fk_travel_cards_journeys` FOREIGN KEY (journey_id) REFERENCES `journeys` (id)
);


-- Quering
-- Quering
-- Quering
-- Quering
-- Quering


SELECT card_number, job_during_journey FROM `travel_cards`
ORDER BY card_number ASC;



-- Quering
-- Quering
-- Quering
-- Quering
-- Quering


SELECT id, concat(first_name, ' ', last_name) AS full_name, ucn FROM `colonists`
ORDER BY first_name ASC, last_name ASC, id ASC;

-- Quering
-- Quering
-- Quering
-- Quering
-- Quering

SELECT id, journey_start, journey_end FROM `journeys`
WHERE purpose LIKE 'Military'
ORDER BY journey_start ASC;

-- Quering
-- Quering
-- Quering
-- Quering
-- Quering


SELECT c.id, concat(c.first_name, ' ', c.last_name) AS full_name 
FROM `colonists` c
JOIN `travel_cards` tc
ON c.id = tc.colonist_id
WHERE tc.job_during_journey = 'Pilot'
ORDER BY c.id ASC;

-- Quering
-- Quering
-- Quering
-- Quering
-- Quering

SELECT count(c.id) AS count 
FROM `colonists` c
JOIN `travel_cards` tc
ON c.id = tc.colonist_id
JOIN `journeys` j
ON tc.journey_id = j.id
WHERE  j.purpose = 'Technical';

-- Quering
-- Quering
-- Quering
-- Quering
-- Quering

SELECT s.name, sp.name 
FROM `spaceships` s
JOIN `journeys` j
ON j.spaceship_id = s.id
JOIN `spaceports` sp
ON j.destination_spaceport_id = sp.id
WHERE light_speed_rate = (SELECT MAX(light_speed_rate) FROM `spaceships`);

-- Quering
-- Quering
-- Quering
-- Quering
-- Quering


SELECT s.name, s.manufacturer 
FROM `spaceships` s
JOIN `journeys` j
ON j.spaceship_id = s.id
JOIN `travel_cards` tc
ON j.id = tc.journey_id
JOIN `colonists` c
ON c.id = tc.colonist_id
WHERE tc.job_during_journey LIKE 'Pilot' AND YEAR('2019/01/01') - YEAR(c.birth_date) < 30
ORDER BY s.name ASC;


-- Quering
-- Quering
-- Quering
-- Quering
-- Quering

SELECT p.name, s.name 
FROM `planets` p
JOIN `spaceports` s
ON p.id = s.planet_id
JOIN `journeys` j
ON s.id = j.destination_spaceport_id
WHERE j.purpose LIKE 'Educational'
ORDER BY s.name DESC;


-- Quering
-- Quering
-- Quering
-- Quering
-- Quering
 
SELECT p.name, count(j.id) AS `journeys_count`
FROM `planets` p
JOIN `spaceports` s
ON p.id = s.planet_id
JOIN `journeys` j
ON s.id = j.destination_spaceport_id
GROUP BY p.id
ORDER BY journeys_count DESC, p.name ASC;

-- Quering
-- Quering
-- Quering
-- Quering
-- Quering

SELECT j.id, p.name, sp.name, j.purpose
FROM `journeys` j
JOIN `spaceports` sp
ON j.destination_spaceport_id = sp.id
JOIN `planets` p
ON p.id = sp.planet_id
ORDER BY TIMESTAMPDIFF(SECOND, j.journey_start, j.journey_end)
LIMIT 1;


-- Quering
-- Quering
-- Quering
-- Quering
-- Quering


SELECT tc.job_during_journey
FROM `colonists` c
JOIN `travel_cards` tc
ON c.id = tc.colonist_id
JOIN `journeys` j
ON j.id = tc.journey_id
WHERE j.id = (SELECT j.id
FROM `journeys` j
ORDER BY TIMESTAMPDIFF(SECOND, j.journey_start, j.journey_end) DESC
LIMIT 1)
GROUP BY tc.job_during_journey
ORDER BY  count(c.id) ASC
LIMIT 1;


-- Programability
-- Programability
-- Programability
-- Programability
-- Programability




DELIMITER $$
CREATE FUNCTION udf_count_colonists_by_destination_planet(planet_name VARCHAR(30))
RETURNS VARCHAR(10)
BEGIN
	DECLARE colonists_count INT; 
    SET colonists_count := 
		(SELECT count(c.id) 
		FROM `planets` p
		JOIN `spaceports` s
		ON p.id = s.planet_id
		JOIN `journeys` j
		ON s.id = j.destination_spaceport_id
		JOIN `travel_cards` tc
		ON tc.journey_id = j.id
		RIGHT JOIN `colonists` c
		ON c.id = tc.colonist_id
		WHERE p.name =  planet_name 
		GROUP BY p.id);
    
		IF colonists_count IS NULL THEN RETURN 0; END IF;
        
    RETURN colonists_count;
END $$
DELIMITER ;

-- Programability
-- Programability
-- Programability
-- Programability
-- Programability


DELIMITER $$
CREATE PROCEDURE udp_modify_spaceship_light_speed_rate(spaceship_name VARCHAR(50), light_speed_rate_increse INT(11))
BEGIN
		START TRANSACTION;
        UPDATE `spaceships` s
        SET s.light_speed_rate = s.light_speed_rate + light_speed_rate_increse
        WHERE s.name = spaceship_name;
        
		IF ((SELECT count(id) FROM `spaceships` s WHERE s.name = spaceship_name) = 0) 
			THEN 
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Spaceship you are trying to modify does not exists.';
			ROLLBACK; 
        END IF;
   
END $$ DELIMITER ;


CALL udp_modify_spaceship_light_speed_rate ('USS Templar', 5);


-- DML
-- DML
-- DML
-- DML

INSERT INTO travel_cards(card_number, job_during_journey, colonist_id, journey_id) 
SELECT  
		(if (c.birth_date > '1980-01-01', concat(YEAR(c.birth_date), DAY(c.birth_date), LEFT(c.ucn, 4)), concat(YEAR(c.birth_date), MONTH(c.birth_date), RIGHT(c.ucn, 4)))) `card_number`, 
		(if (c.id % 2 = 0, 'Pilot', if(c.id % 3 = 0, 'Cook', 'Engineer'))) `job_during_journey`, 
        c.id `colonist id`,
        (LEFT(c.ucn, 1))  `journey_id`
FROM `colonists` c
WHERE c.id BETWEEN 96 AND 100;



-- DML
-- DML
-- DML
-- DML


UPDATE `journeys` j
SET j.purpose = 'Medical'
WHERE j.id % 2 = 0;

UPDATE `journeys` j
SET j.purpose = 'Technical'
WHERE j.id % 3 = 0;

UPDATE `journeys` j
SET j.purpose = 'Educational'
WHERE j.id % 5 = 0;

UPDATE `journeys` j
SET j.purpose = 'Military'
WHERE j.id % 7 = 0;


UPDATE `journeys` j
SET j.purpose = (if (j.id % 2 = 0, 'Medical', if(j.id % 3 = 0, 'Technical', if(j.id % 5 = 0, 'Educational', if(j.id % 7 = 0, 'Military', j.purpose)))));
 
-- DML
-- DML
-- DML
-- DML

DELETE FROM `colonists`
WHERE id IN (SELECT * FROM (
				SELECT c.id
				FROM `colonists` c
                LEFT JOIN `travel_cards` tc
                ON c.id = tc.colonist_id
				WHERE tc.journey_id IS NULL) AS t1);



