USE mysql;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
UPDATE user SET password=PASSWORD("root") WHERE user='root';
FLUSH PRIVILEGES;

CREATE DATABASE wordpress;

CREATE USER wordpressuser@localhost IDENTIFIED BY 'password';

GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost IDENTIFIED BY 'password';

FLUSH PRIVILEGES;

