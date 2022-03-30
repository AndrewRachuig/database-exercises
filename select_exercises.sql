use albums_db;

select * from albums;

-- a. How many rows are in the albums table?
-- 	  31 rows
-- b. How many unique artist names are in the albums table?
-- 	  23 unique artist names
-- c. What is the primary key for the albums table?
-- 	  The id column is the primary key
-- d. What is the oldest release date for any album in the albums table? What is the most recent release date?
--    Oldest release date is  'Sgt. Pepper''s Lonely Hearts Club Band' and the most recent is '21'

-- Write queries to find the following information:

-- a. The name of all albums by Pink Floyd
SELECT name FROM albums WHERE artist = 'Pink Floyd';

-- b. The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date FROM albums WHERE name = 'Sgt. Pepper''s Lonely Hearts Club Band';

-- c. The genre for the album Nevermind
SELECT genre FROM albums WHERE name = 'Nevermind';

-- d. Which albums were released in the 1990s
SELECT name, release_date FROM albums WHERE release_date > 1989 and release_date < 2000;

-- e. Which albums had less than 20 million certified sales
SELECT name, sales FROM albums WHERE sales < 20;

-- f. All the albums with a genre of "Rock". 
SELECT name, genre FROM albums WHERE genre LIKE '%Rock%';
-- Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
-- Because "Hard rock" and "Progressive rock" are separate 