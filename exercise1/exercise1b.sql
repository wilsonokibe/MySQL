--Exercise 1b
CREATE TABLE Branches (
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
  FOREIGN KEY (branch) REFERENCES Branches (bcode)
);

CREATE TABLE Titles (
  title VARCHAR(20) NOT NULL,
  author VARCHAR(20),
  publisher VARCHAR(20)
);

INSERT INTO Branches
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
SELECT DISTINCT branch 
FROM Holdings 
WHERE title IN (
  SELECT title 
  FROM Titles 
  WHERE author = 'Ann Brown'
);

--(iii) branches that hold any books by Ann Brown (without using a nested subquery). 
SELECT DISTINCT bcode as 'branch-code', librarian, address   
FROM Branches b INNER JOIN Holdings h 
ON b.bcode = h.branch 
INNER JOIN Titles t 
ON h.title = t.title 
AND t.author = 'Ann Brown';

--Selecting only branch
SELECT DISTINCT branch 
FROM Holdings h INNER JOIN Titles t 
ON h.title = t.title
AND t.author = 'Ann Brown'

--(iv) the total number of books held at each branch. 
SELECT branch, SUM(copies) AS 'Number of Books'
FROM Holdings
GROUP BY branch;

SELECT bcode as 'branch-code', librarian, address  
FROM Branches INNER JOIN Holdings INNER JOIN Titles 
ON bcode = branch 
AND Holdings.title = Titles.title 
AND Titles.author = 'Ann Brown' 
GROUP BY bcode; 
