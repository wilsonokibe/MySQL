--Exercise: Alter Table - Create a table named "testing_table" with following fields:name (string)contact_name (string)roll_no (string). Now:Delete column name, rename contact_name to username. Add two fields first_name, last_name. Also change the type of roll_no to integer

CREATE DATABASE exercises; 

USE exercises; 

CREATE TABLE testing_table (
	name VARCHAR(10), 
	contact_name VARCHAR(20), 
	roll_no VARCHAR(10)
); 

ALTER TABLE testing_table DROP name; 

ALTER TABLE testing_table CHANGE contact_name username CHAR(20);

ALTER TABLE testing_table 
ADD first_name VARCHAR(10), 
ADD last_name VARCHAR(10); 

ALTER TABLE testing_table 
MODIFY roll_no INTEGER; 

