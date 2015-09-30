
CREATE DATABASE exercise3;

USE exercise3;

CREATE TABLE Categories (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT, 
  category VARCHAR(50),
  PRIMARY KEY (id)
);

CREATE TABLE Users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  type VARCHAR(20) DEFAULT 'normal',
  name VARCHAR(40),
  PRIMARY KEY (id)
);

CREATE TABLE Comments (
  user_id INT UNSIGNED NOT NULL,
  comment TEXT,
  FOREIGN KEY (user_id) REFERENCES Users (id)
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
(NULL, 'normal', 'Segun'), 
(NULL, 'normal', 'Wilson'),
(NULL, 'admin', 'Osifo'),
(NULL, 'normal', 'Daniel'),
(NULL, 'normal', 'Manish'),
(NULL, 'normal', 'Ayo'),
(NULL, 'normal', 'Remy'),
(NULL, 'normal', 'Ugo'),
(NULL, 'normal', 'Neima'),
(NULL, 'normal', 'Henry');

INSERT INTO Categories (id, category) VALUES
(NULL, 'Arts and Entertainment'),
(NULL, 'Sports'),
(NULL, 'Travel and Tour'),
(NULL, 'Philosophy and Religion'),
(NULL, 'Finance and Business'),
(NULL, 'Education and Communication'),
(NULL, 'Health'),
(NULL, 'Family'),
(NULL, 'Personal Care and Craft'),
(NULL, 'Youth');

INSERT INTO Articles (id, user_id, category_id, title) VALUES
(NULL, 9, 5, 'An Ambush at Noon'),
(NULL, 2, 4, 'My American Dream is Happiness in Marriage'),
(NULL, 5, 10, 'Empowering the African Woman'),
(NULL, 10, 8, 'Oce Upon A Beginning'),
(NULL, 7, 6, 'Stop Living in Fool\'s Paradise'),
(NULL, 1, 6, 'A Literary Window on Economists'),
(NULL, 6, 2, 'Rangers Fight Back to Beat Kwara United 2-1 in Enugu'),
(NULL, 3, 2,  '4 Great Arsenal Champions League Moments vs. Greek Sides'),
(NULL, 4, 2, 'Arsene Wenger Responds to Jose Mourinho\'s Claims About Treatment from FA'),
(NULL, 8, 2, 'Barca star Neymar accused of evading taxes');

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

--select all articles whose author's name is user3 (Do this exercise using variable also).
SELECT title 
FROM Articles INNER JOIN Users 
ON user_id = Users.id 
WHERE name = 'User3' 
ORDER BY title DESC;

--Using variable:
SET @user = 'User3';
SELECT title 
FROM Articles INNER JOIN Users 
ON user_id = Users.id 
WHERE name = @user 
ORDER BY title DESC;


--For all the articles being selected above, select all the articles and also the comments associated with those articles in a single query (Do this using subquery also)
SELECT title AS 'Article', comment AS 'Comments' 
FROM Articles INNER JOIN Comments 
ON Articles.id = article_id 
ORDER BY title;

-- query with Users name = 'User3'
SET @user = 'User3';
SELECT title AS 'Article', comment AS 'Comments'  
FROM Articles LEFT JOIN Comments  
ON Articles.id = article_id  
WHERE Articles.user_id  
IN (SELECT id FROM Users WHERE name = @user)  
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

--Write a query to select all articles which do not have any comments (Do using subquery also)
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

--Write a query to select article which has maximum comments
SELECT title, COUNT(article_id) AS 'comments' 
FROM Comments RIGHT JOIN Articles 
ON article_id=id 
GROUP BY article_id 
ORDER BY comments DESC 
LIMIT 1;


--Write a query to select article which does not have more than one comment by the same user ( do this using left join and group by )
SELECT title 
FROM Articles LEFT JOIN Comments 
ON id = article_id 
GROUP BY id 
HAVING COUNT(Comments.user_id) <= 1;


































