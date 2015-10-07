
CREATE DATABASE exercise3;

USE exercise3;

CREATE TABLE Categories (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT, 
  category VARCHAR(50),
  PRIMARY KEY (id)
);

CREATE TABLE Users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  type ENUM('normal', 'admin') NOT NULL DEFAULT 'normal',
  name VARCHAR(40),
  PRIMARY KEY (id)
);

CREATE TABLE Comments (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED NOT NULL,
  comment TEXT,
  article_id INT UNSIGNED NOT NULL,
  FOREIGN KEY (user_id) REFERENCES Users (id),
  FOREIGN KEY (article_id) REFERENCES Articles (id)
);

CREATE TABLE Articles (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED NOT NULL,
  category_id INT UNSIGNED NOT NULL,
  FOREIGN KEY (user_id) REFERENCES Users (id),
  FOREIGN KEY (category_id) REFERENCES Categories (id),
  PRIMARY KEY(id)
);

INSERT INTO Users (type, name) VALUES 
('normal', 'Segun'), 
('normal', 'Wilson'),
('admin', 'Osifo'),
('normal', 'Daniel'),
('normal', 'Manish'),
('normal', 'Ayo'),
('normal', 'Remy'),
('normal', 'Ugo'),
('normal', 'Neima'),
('normal', 'Henry');

INSERT INTO Categories (category) VALUES
('Arts and Entertainment'),
('Sports'),
('Travel and Tour'),
('Philosophy and Religion'),
('Finance and Business'),
('Education and Communication'),
('Health'),
('Family'),
('Personal Care and Craft'),
('Youth');

INSERT INTO Articles (user_id, category_id, title) VALUES
(9, 5, 'An Ambush at Noon'),
(2, 4, 'My American Dream is Happiness in Marriage'),
(5, 10, 'Empowering the African Woman'),
(10, 8, 'Oce Upon A Beginning'),
(7, 6, 'Stop Living in Fool\'s Paradise'),
(1, 6, 'A Literary Window on Economists'),
(6, 2, 'Rangers Fight Back to Beat Kwara United 2-1 in Enugu'),
(3, 2,  '4 Great Arsenal Champions League Moments vs. Greek Sides'),
(4, 2, 'Arsene Wenger Responds to Jose Mourinho\'s Claims About Treatment from FA'),
(8, 2, 'Barca star Neymar accused of evading taxes');

INSERT INTO Comments (user_id, comment, article_id) VALUES 
(2, 'comment 1', 1),
(2, 'comment 2', 3), 
(2, 'comment 2', 4), 
(3, 'comment 3', 9), 
(5, 'comment 5', 5), 
(5, 'comment 6', 10), 
(5, 'comment 6', 8), 
(9, 'comment 6', 8), 
(4, 'comment 6', 8), 
(1, 'comment', 10 ), 
(7, 'comment', 10 ), 
(10, 'comment', 10 ), 
(10, 'comment', 10 ), 
(3, 'comment', 10 );

--(i)select all articles whose author's name is user3 (Do this exercise using variable also).
SELECT title 
FROM Articles INNER JOIN Users 
ON user_id = Users.id 
WHERE name = 'User3' 
ORDER BY title DESC;

--Using variable:
SET @user_id = (
  SELECT id
  FROM Users 
  WHERE name = 'User3'
);

SELECT title 
FROM Articles 
WHERE Articles.user_id = @user_id;


--(ii) For all the articles being selected above, select all the articles and also the comments associated with those articles in a single query (Do this using subquery also)
--Without SubQuery--
SELECT a.title AS 'Article', c.comment AS 'Comments'  
FROM Articles a INNER JOIN Users u 
ON a.user_id = u.id INNER JOIN Comments c 
ON c.article_id = a.id WHERE u.name = 'User3';

--Using SubQuery--
SELECT a.title AS 'Article', c.comment AS 'Comments'   
FROM Articles a INNER JOIN Users u  
ON a.user_id = u.id 
INNER JOIN Comments c  
ON c.article_id = a.id 
WHERE a.user_id = (   
  SELECT id    
  FROM Users   
  WHERE name = 'User3'   
);


--(iii) Write a query to select all articles which do not have any comments (Do using subquery also)
SELECT title 
FROM Comments RIGHT JOIN  Articles 
ON article_id = id 
WHERE Comments.comment IS NULL;

--Using subquery
SELECT title  
FROM Articles 
WHERE id NOT 
IN (
  SELECT article_id 
  FROM Comments
  );

--(iv) Write a query to select article which has maximum comments
SELECT title, MAX(article_id) AS comments 
FROM Comments c RIGHT JOIN Articles a 
ON c.article_id = a.id 
GROUP BY article_id 
HAVING comments 
IN (
  SELECT MAX(article_id) AS comments2 
  FROM Comments c1 RIGHT JOIN Articles a1 
  ON c1.article_id = a1.id
);

--(v) Write a query to select article which does not have more than one comment by the same user ( do this using left join and group by )
SELECT title 
FROM Articles LEFT JOIN Comments 
ON id = article_id 
GROUP BY id 
HAVING COUNT(Comments.user_id) <= 1;
