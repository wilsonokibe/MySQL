
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

INSERT INTO Users (id, type, name) VALUES 
(DEFAULT, 'normal', 'Segun'), 
(DEFAULT, 'normal', 'Wilson'),
(DEFAULT, 'admin', 'Osifo'),
(DEFAULT, 'normal', 'Daniel'),
(DEFAULT, 'normal', 'Manish'),
(DEFAULT, 'normal', 'Ayo'),
(DEFAULT, 'normal', 'Remy'),
(DEFAULT, 'normal', 'Ugo'),
(DEFAULT, 'normal', 'Neima'),
(DEFAULT, 'normal', 'Henry');

INSERT INTO Categories (id, category) VALUES
(DEFAULT, 'Arts and Entertainment'),
(DEFAULT, 'Sports'),
(DEFAULT, 'Travel and Tour'),
(DEFAULT, 'Philosophy and Religion'),
(DEFAULT, 'Finance and Business'),
(DEFAULT, 'Education and Communication'),
(DEFAULT, 'Health'),
(DEFAULT, 'Family'),
(DEFAULT, 'Personal Care and Craft'),
(DEFAULT, 'Youth');

INSERT INTO Articles (id, user_id, category_id, title) VALUES
(DEFAULT, 9, 5, 'An Ambush at Noon'),
(DEFAULT, 2, 4, 'My American Dream is Happiness in Marriage'),
(DEFAULT, 5, 10, 'Empowering the African Woman'),
(DEFAULT, 10, 8, 'Oce Upon A Beginning'),
(DEFAULT, 7, 6, 'Stop Living in Fool\'s Paradise'),
(DEFAULT, 1, 6, 'A Literary Window on Economists'),
(DEFAULT, 6, 2, 'Rangers Fight Back to Beat Kwara United 2-1 in Enugu'),
(DEFAULT, 3, 2,  '4 Great Arsenal Champions League Moments vs. Greek Sides'),
(DEFAULT, 4, 2, 'Arsene Wenger Responds to Jose Mourinho\'s Claims About Treatment from FA'),
(DEFAULT, 8, 2, 'Barca star Neymar accused of evading taxes');

INSERT INTO Comments (id, user_id, comment, article_id) VALUES 
(DEFAULT, 2, 'comment 1', 1),
(DEFAULT, 2, 'comment 2', 3), 
(DEFAULT, 2, 'comment 2', 4), 
(DEFAULT, 3, 'comment 3', 9), 
(DEFAULT, 5, 'comment 5', 5), 
(DEFAULT, 5, 'comment 6', 10), 
(DEFAULT, 5, 'comment 6', 8), 
(DEFAULT, 9, 'comment 6', 8), 
(DEFAULT, 4, 'comment 6', 8), 
(DEFAULT, 1, 'comment', 10 ), 
(DEFAULT, 7, 'comment', 10 ), 
(DEFAULT, 10, 'comment', 10 ), 
(DEFAULT, 10, 'comment', 10 ), 
(DEFAULT, 3, 'comment', 10 );

--(i)select all articles whose author's name is user3 (Do this exercise using variable also).
SELECT title 
FROM Articles INNER JOIN Users 
ON user_id = Users.id 
WHERE name = 'User3' 
ORDER BY title DESC;

--Using variable:
SELECT title 
FROM Articles INNER JOIN Users 
ON user_id = Users.id 
WHERE name = (
    SELECT name 
    FROM Users 
    WHERE name = 'User3'
    )
ORDER BY title DESC;


--(ii) For all the articles being selected above, select all the articles and also the comments associated with those articles in a single query (Do this using subquery also)
SELECT title AS 'Article', comment AS 'Comments' 
FROM Articles INNER JOIN Comments 
ON Articles.id = article_id 
ORDER BY title;

-- query with Users name = 'User3'
SELECT title AS 'Article', comment AS 'Comments'  
FROM Articles LEFT JOIN Comments  
ON Articles.id = article_id  
WHERE Articles.user_id  
IN (
  SELECT id 
  FROM Users 
  WHERE name = (
    SELECT name 
    FROM Users 
    WHERE name = 'User3'
    )
  )
ORDER BY title;

--using subquery
SELECT title AS 'Article', comment AS 'Comments' 
FROM (SELECT * FROM Articles) A LEFT JOIN (SELECT * FROM Comments ) C
ON C.article_id = A.id
ORDER BY title;

-- query with Users name = 'User3'
SELECT title AS 'Article', comment AS 'Comments'  
FROM (
  SELECT * 
  FROM Articles
  ) A 
  LEFT JOIN (
    SELECT * 
    FROM Comments 
    ) C 
ON C.article_id = A.id 
WHERE A.user_id 
IN (
  SELECT id 
  FROM Users 
  WHERE name = 'User3'
  ) 
ORDER BY title;

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
SELECT title, COUNT(article_id) AS 'comments' 
FROM Comments RIGHT JOIN Articles 
ON article_id=id 
GROUP BY article_id 
ORDER BY comments DESC 
LIMIT 1;

--ALternativeley
SELECT title, MAX(comments) 
FROM (
  SELECT title, COUNT(article_id) AS 'comments' 
  FROM Comments RIGHT JOIN Articles 
  ON article_id=Comments.id 
  GROUP BY article_id 
  ORDER BY comments DESC 
  ) 
AS COUNTER;

--(v) Write a query to select article which does not have more than one comment by the same user ( do this using left join and group by )
SELECT title 
FROM Articles LEFT JOIN Comments 
ON id = article_id 
GROUP BY id 
HAVING COUNT(Comments.user_id) <= 1;
