--EXERCISE 1a:

CREATE TABLE Locations (
  lname VARCHAR(10) NOT NULL,
  phone VARCHAR(22),
  address VARCHAR(50),
  PRIMARY KEY (lname)
);

CREATE TABLE Sandwitches (
  location VARCHAR(10) NOT NULL,
  bread VARCHAR(10),
  filling VARCHAR(10),
  price FLOAT(4,2),
  FOREIGN KEY(location) REFERENCES Locations(lname)
);

CREATE TABLE Tastes (
  name VARCHAR(10),
  filling VARCHAR(10)
)

INSERT INTO Locations (lname, phone, address) 
VALUES ('Lincoln','683 4523','Lincoln Place'),
('O\'Neil\'s','674 2134','Pearse St'),
('Old Nag','767 8132','Dame St'),
('Buttery','702 3421','College St');

INSERT INTO Sandwitches (location, bread, filling, price) 
VALUES ('lincoln','Rye','Ham',1.25),
('O\'Neil\'s','White','Cheese',1.20),
('O\'Neil\'s','Whole','Ham',1.25),
('Old Nag','Rye','Beef',1.35),
('Buttery','White','Cheese',1.00),
('O\'Neil\'s','White','Turkey',1.35),
('Buttery','White','Ham',1.10),
('Lincoln','Rye','Beef',1.35),
('Lincoln','White','Ham',1.30),
('Old Nag','Rye','Ham',1.40);

INSERT INTO Tastes 
VALUES ('Brown','Turkey'),
('Brown','Beef'),
('Brown','Ham'),
('Jones','Cheese'),
('Green','Beef'),
('Green','Turkey'),
('Green','Cheese');


--(i) places where Jones can eat (using a nested subquery). 
SELECT location AS 'Where Jones can eat' 
FROM Sandwitches 
WHERE filling IN 
	(SELECT filling From Tastes WHERE name = 'Jones'); 

--Alternatively:
SELECT CONCAT(lname, ', ',address) AS 'Places Jones can eat' 
FROM Locations WHERE lname IN 
	(SELECT location FROM Sandwitches WHERE filling IN 
		(SELECT filling FROM Tastes WHERE Tastes.name = 'Jones'));


--(ii) places where Jones can eat (without using a nested subquery). 
SELECT location 
FROM Tastes INNER JOIN Sandwitches 
ON Tastes.filling = Sandwitches.filling 
WHERE name = 'Jones'; 


--(iii) for each location the number of people who can eat there. 
SELECT location, COUNT(DISTINCT(name)) as 'Customers'  
FROM Tastes INNER JOIN Sandwitches 
ON Tastes.filling = Sandwitches.filling 
GROUP BY location; 
























