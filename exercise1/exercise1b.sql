--Exercise 1b
CREATE TABLE Branch (
  bcode VARCHAR(2) NOT NULL,
  librarian VARCHAR(20),
  address VARCHAR(20),
  PRIMARY KEY (bcode)
);

CREATE TABLE Holdings (
  branch VARCHAR(2) NOT NULL,
  title VARCHAR(20) NOT NULL,
  copies int(11),
  FOREIGN KEY (title) REFERENCES Titles (title),
  FOREIGN KEY (branch) REFERENCES Branch (bcode)
);

CREATE TABLE Titles (
  title VARCHAR(20) NOT NULL,
  author VARCHAR(20),
  publisher VARCHAR(20)
);

INSERT INTO Branch 
VALUES ('B1','John Smith','2 Anglesea Rd'),
('B2','Mary Jones','34 Pearse St'),
('B3','Francis Owens','Grange X');

INSERT INTO Holdings 
VALUES ('B1','Susannah',3),
('B1','How to Fish',2),
('B1','A History of Dublin',1),
('B2','How to Fish',4),
('B2','Computers',2),
('B2','The Wife',3),
('B3','A History of Dublin',1),
('B3','Computers',4),
('B3','Susannah',3),
('B3','The Wife',1);

INSERT INTO Titles 
VALUES ('Susannah','Ann Brown','Macmillan'),
('How to Fish','Amy Fly','Stop Press'),
('A History of Dublin','David Little','Wiley'),
('Computers','Blaise Pascal','Applewoods'),
('The Wife','Ann Brown','Macmillan');

--(i) the names of all library books published by Macmillan. 
SELECT title as 'Books published by Macmillan' 
FROM Titles  
WHERE publisher = 'Macmillan'; 


--(ii) branches that hold any books by Ann Brown (using a nested subquery). 
SELECT bcode as 'branch-code'
FROM Branch 
WHERE bcode IN (
  SELECT branch  
  FROM Holdings  
  WHERE title IN ( 
    SELECT title  
    FROM Titles 
    WHERE author = 'Ann Brown')
); 

--(iii) branches that hold any books by Ann Brown (without using a nested subquery). 
SELECT bcode as 'branch-code', librarian, address 
FROM Branch INNER JOIN Holdings INNER JOIN Titles 
ON bcode = branch 
AND Holdings.title = Titles.title 
AND Titles.author = 'Ann Brown'; 

--Alternatively:
SELECT bcode as 'branch-code', librarian, address  
FROM Branch INNER JOIN Holdings INNER JOIN Titles 
ON bcode = branch 
AND Holdings.title = Titles.title 
AND Titles.author = 'Ann Brown' 
GROUP BY bcode; 

--(iv) the total number of books held at each branch. 
SELECT branch, SUM(copies) AS 'Number of Books'
FROM Holdings
GROUP BY branch;
























