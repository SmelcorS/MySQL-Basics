CREATE DATABASE `car_rental`;

USE `car_rental`;

CREATE TABLE `categories` (
	id INT PRIMARY KEY AUTO_INCREMENT,
    category VARCHAR(30) NOT NULL,
    daily_rate DOUBLE(10, 2) NOT NULL,
    weekly_rate DOUBLE(10, 2) NOT NULL,
	monthly_rate DOUBLE(10, 2) NOT NULL,
    weekend_rate DOUBLE(10, 2) NOT NULL
);

CREATE TABLE `cars` (
	id INT PRIMARY KEY AUTO_INCREMENT,
    plate_number VARCHAR(30) NOT NULL,
    make VARCHAR(30) NOT NULL,
    model VARCHAR(30) NOT NULL,
    car_year YEAR,
	category_id INT NOT NULL,
    doors INT(1) NOT NULL,
    picture BLOB,
    car_condition TEXT,
    available bool
);


CREATE TABLE `employees` (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    title VARCHAR(30) NOT NULL,
    notes TEXT
);

CREATE TABLE `customers` (
	id INT PRIMARY KEY AUTO_INCREMENT,
    driver_licence_number INT NOT NULL,
    full_name VARCHAR(50) NOT NULL,
    address VARCHAR(50),
    city VARCHAR(50),
    zip_code INT,
    notes TEXT
);


CREATE TABLE `rental_orders` (
	id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    customer_id INT NOT NULL,
    car_id INT NOT NULL,
    car_condition TEXT,
    tank_level DOUBLE NOT NULL,
    kilometrage_start DOUBLE NOT NULL,
    kilometrage_end DOUBLE,
    total_kilometrage DOUBLE,
	start_date DATE NOT NULL,
    end_date DATE,
    total_days INT,
    rate_applied DOUBLE NOT NULL,
    tax_rate DOUBLE NOT NULL,
    order_status VARCHAR(40) NOT NULL,
    notes TEXT
);

INSERT INTO `categories` (`category`, `daily_rate`, `weekly_rate`, `monthly_rate`, `weekend_rate`)
VALUES ('sport', 800, 1, 2, 3), ('old', 200, 1, 2, 3), ('classic', 1200, 1, 2, 3);

INSERT INTO `cars` (`plate_number`, `make`, `model`, `car_year`,`category_id`, `doors`)
VALUES ('323AS', 'mercedes', 'CL63', 2009, 1,3), ('466SD', 'BMW', '720', 2005, 1,4), ('SD4949WE', 'lada', 'samara', 1972, 1,3);

INSERT INTO `employees` (`first_name`, `last_name`, `title`)
VALUES ('Canko', 'Stoikov', 'gay'), ('Goshko', 'Stavrev', 'junkie'), ('Ivan', 'Ionkov', 'applepie');

INSERT INTO `customers` (`driver_licence_number`, `full_name`)
VALUES (2312312, 'Ivanka Stainova'), (32333322, 'fani Stamatova'), (12312312, 'Peci Iotov');

INSERT INTO `rental_orders` (`employee_id`, `customer_id`, `car_id`, 
`tank_level`, `kilometrage_start`, `start_date`, `rate_applied`, `tax_rate`, 
`order_status`)
VALUES (1, 2, 3, 34, 55, '1999/06/05', 55.5, 12, 'pending'),
(2, 5, 6, 34, 55, '1999/06/05', 55.5, 12, 'crashed'),
(3, 4, 7, 34, 55, '1999/06/05', 55.5, 12, 'ill');





