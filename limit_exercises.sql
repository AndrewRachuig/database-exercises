use employees;

-- 2. List the first 10 distinct last name sorted in descending order.

SELECT DISTINCT
    last_name
FROM
    employees
ORDER BY last_name DESC
LIMIT 10;

-- 3. Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. 
SELECT 
    *
FROM
    employees
WHERE
    birth_date LIKE '____-12-25'
        AND (hire_date >= '1990-01-01'
        AND hire_date < '2000-01-01')
ORDER BY hire_date
LIMIT 5;

-- Write a comment in your code that lists the five names of the employees returned.
-- Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, Petter Stroustrup

-- 4. Update the query (from 3) to find the tenth page of results.

SELECT 
    *
FROM
    employees
WHERE
    birth_date LIKE '____-12-25'
        AND (hire_date >= '1990-01-01'
        AND hire_date < '2000-01-01')
ORDER BY hire_date
LIMIT 5 OFFSET 45;

-- What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?

-- Offset = (page - 1) * limit