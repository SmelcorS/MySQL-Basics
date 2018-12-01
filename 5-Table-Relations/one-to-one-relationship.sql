

CREATE TABLE `persons` (
	`person_id` INT,
    `first_name` VARCHAR(30),
    `salary` DECIMAL(10,2),
    `passport_id` INT UNIQUE
);

CREATE TABLE `passports` (
	`passport_id` INT PRIMARY KEY AUTO_INCREMENT,
    `passport_number` VARCHAR(30) UNIQUE
);

ALTER TABLE `persons`
ADD CONSTRAINT `pk_persons` PRIMARY KEY (`person_id`),
MODIFY `person_id` INT AUTO_INCREMENT,
ADD CONSTRAINT `fk_persons_passports` FOREIGN KEY (`passport_id`)
REFERENCES `passports` (`passport_id`);


INSERT INTO `passports` (`passport_id`, `passport_number`)
VALUES (101, 'N34FG21B'), (102, 'K65LO4R7'), (103, 'ZE657QP2');

INSERT INTO `persons` (`first_name`, `salary`, `passport_id`)
VALUES ('Roberto', '43300.00', '102'), ('Tom', '56100.00', '103'), ('Yana', '60200.00', '101');