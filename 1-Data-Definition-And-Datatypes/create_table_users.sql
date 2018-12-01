CREATE TABLE `users`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    username  CHAR(30) UNIQUE NOT NULL,
    password CHAR(26) NOT NULL,
    profile_picture BLOB,
    last_login_time TIMESTAMP,
    is_deleted BOOL
);

INSERT INTO `users`(`username`, `password`) VALUES
('goshko90', '1234'),
('ganka03020', '1232dd34'),
('stoman_12', 'qwerty'),
('kiflichka_13', 'asdasdas'),
('Vasko_31', '111333');