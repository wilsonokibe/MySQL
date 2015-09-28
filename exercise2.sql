-- Exercise 2: Create a DB named "vtapp", create a db user named 'vtapp_user' and give him permissions to access vtappDB

CREATE DATABASE vtapp;
CREATE USER 'vtapp_user'@'localhost' IDENTIFIED BY 'password';
GRANT ALL ON vtapp.* TO 'vtapp_user'@'localhost'; 

