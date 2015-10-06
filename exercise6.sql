--Exercise 6: Email campaign Data exerciseWe ran a campaign on a website, asking people to submit their email address, their city and phone number.The data was collected in a csv format - The file is here... http://dl.dropbox.com/u/628209/exercises/mysql/email_subscribers.txtFirst import this csv data into a mysql datbase.

CREATE TABLE Email_data(
  id INT UNSIGNED NOT NULL AUTO_INCREMENT, 
  email VARCHAR(40) NOT NULL, 
  phone VARCHAR(20) NOT NULL, 
  city VARCHAR(20) NOT NULL, 
  PRIMARY KEY (id)
); 

LOAD DATA LOCAL INFILE 'table1.csv' 
INTO TABLE Email_data FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' (email, phone, city); 

--From the database, we need to find the following information by writing a single sql statement for each
--(i) What all cities did people respond from
SELECT DISTINCT city 
FROM Email_data;

--(ii) How many people responded from each city
SELECT city, COUNT(city) 
FROM Email_data 
GROUP BY city;  

--(iii) Which city were the maximum respondents from?
SELECT city, COUNT(city) AS counter1 
FROM Email_data 
GROUP BY city 
HAVING counter1 = (
  SELECT COUNT(city) AS counter2 
  FROM Email_data 
  GROUP BY city 
  ORDER BY counter2 DESC 
  LIMIT 1
);

--(iv) What all email domains did people respond from ?
SELECT DISTINCT (SUBSTRING_INDEX(SUBSTR(email, INSTR(email, '@') + 1),'.',1)) AS 'Email Domains' 
FROM Email_data; 

--Alternative:
SELECT DISTINCT SUBSTRING_INDEX (SUBSTRING_INDEX(email, '@', -1), '.', 1) 
FROM Email_data;


--(v) Which is the most popular email domain among the respondents ?
SELECT (SUBSTRING_INDEX(SUBSTR(email, INSTR(email, '@') + 1),'.',1)) AS 'domain', COUNT(*) as counter
FROM Email_data
GROUP BY (SUBSTRING_INDEX(SUBSTR(email, INSTR(email, '@') + 1),'.',1))
HAVING counter = (
  SELECT COUNT(*) AS counter2
  FROM Email_data
  GROUP BY (SUBSTRING_INDEX(SUBSTR(email, INSTR(email, '@') + 1),'.',1))
  ORDER BY counter2 DESC
  LIMIT 1
);
