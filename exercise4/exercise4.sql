--Exercise 4 BackUp and Restore: Take back up of the db you created for practice/exercise and send it to me.Now create a new database named "restored" and restore that backup into this DB.

mysqldump -h localhost -u root -p exercises > exercises_backup.sql 

CREATE DATABASE restored;

mysql -h localhost -u root -p restored < exercises_backup.sql


