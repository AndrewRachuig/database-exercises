use albums_db;


SELECT 
    *
FROM
    albums;


-- a. How many rows are in the albums table?
SELECT 
    COUNT(*)
FROM
    albums;
-- 	  31 rows


-- b. How many unique artist names are in the albums table?
SELECT 
    COUNT(DISTINCT artist)
FROM
    albums;
-- 	  23 unique artist names


-- c. What is the primary key for the albums table?
SHOW KEYS FROM albums WHERE Key_name = 'PRIMARY';
-- 	  The id column is the primary key


-- d. What is the oldest release date for any album in the albums table? What is the most recent release date?
SELECT 
    name, release_date
FROM
    albums
ORDER BY release_date ASC
LIMIT 1;

SELECT 
    name, release_date
FROM
    albums
ORDER BY release_date DESC
LIMIT 1;
--    Oldest release date is  'Sgt. Pepper''s Lonely Hearts Club Band' and the most recent is '21'



-- Write queries to find the following information:

-- a. The name of all albums by Pink Floyd
SELECT 
    name
FROM
    albums
WHERE
    artist = 'Pink Floyd';


-- b. The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT 
    release_date
FROM
    albums
WHERE
    name = 'Sgt. Pepper\'s Lonely Hearts Club Band';


-- c. The genre for the album Nevermind
SELECT 
    genre
FROM
    albums
WHERE
    name = 'Nevermind';


-- d. Which albums were released in the 1990s
SELECT 
    name, release_date
FROM
    albums
WHERE
    release_date > 1989
        AND release_date < 2000;


-- e. Which albums had less than 20 million certified sales
SELECT 
    name, sales
FROM
    albums
WHERE
    sales < 20;


-- f. All the albums with a genre of "Rock". 

SELECT 
    name, genre
FROM
    albums
WHERE
    genre = 'Rock'; 
-- This is too constraining.


SELECT
	name, genre
FROM
	albums;
-- We see here there are multiple others which have 'Rock' in the genre but alongside other genres.


SELECT 
    name, genre
FROM
    albums
WHERE
    genre LIKE '%Rock%';
-- Now the results are too broad.
        
SELECT 
    name, genre
FROM
    albums
WHERE
    genre = 'Rock'
		or genre LIKE 'Rock%'
        or genre LIKE '%, Rock%';
-- Here it's appropriately limited.        
        
-- Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?

/* I'm assuming you mean why does the query 

SELECT 
    name, genre
FROM
    albums
WHERE
    genre = 'Rock'; 

not return those rows with albums of genre "Hard rock" or "Progressive rock", 
that would be because they don't match the searched for term "Rock" exactly, but my query doesn't contain them as I exclude them explicitly. */
