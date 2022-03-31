use employees;
SELECT database();

-- 2. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.
SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Irena', 'Vidya', 'Maya');

SELECT 
    COUNT(*)
FROM
    employees
WHERE
    first_name IN ('Irena' , 'Vidya', 'Maya');

-- 709 entries


-- 3. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Irena'
        OR first_name = 'Vidya'
        OR first_name = 'Maya';
-- There are 709 entries returned, it does match the previous 


-- 4. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.
SELECT 
    *
FROM
    employees
WHERE
    gender = 'm'
        AND (first_name = 'Irena'
        OR first_name = 'Vidya'
        OR first_name = 'Maya');
-- 441 entries returned

-- 5. Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.
SELECT 
    *
FROM
    employees
WHERE
    last_name LIKE 'E%';
    

-- 6. Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. How many employees have a last name that ends with E, but does not start with E?
SELECT 
    *
FROM
    employees
WHERE
    last_name LIKE 'E%'
        OR last_name LIKE '%e';

-- 30723 entries start or end with e.  

SELECT 
    *
FROM
    employees
WHERE
    last_name LIKE '%e'
    AND NOT last_name LIKE 'E%';
    
-- 23393 entries end with e and don't start with e.

-- 7. Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. How many employees' last names end with E, regardless of whether they start with E?
SELECT 
    *
FROM
    employees
WHERE
    last_name LIKE 'E%e';
-- 899 entries start and end with e.

SELECT 
    *
FROM
    employees
WHERE
    last_name LIKE '%e';
-- 24292 entries end with e

-- 8. Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.
SELECT 
    *
FROM
    employees
WHERE
    hire_date >= '1990-01-01'
        AND hire_date < '2000-01-01';
        
-- 135214 entries for employees hired in the 90s

-- 9. Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.
SELECT 
    *
FROM
    employees
WHERE
    birth_date LIKE '____-12-25';
 -- 842 entries for employees born on Christmas
 
 -- 10. Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.

SELECT 
    *
FROM
    employees
WHERE
    birth_date LIKE '____-12-25'
        AND (hire_date >= '1990-01-01'
        AND hire_date < '2000-01-01');
 -- 362 entries for employees born on Christmas
 
 -- 11.Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.

SELECT 
    *
FROM
    employees
WHERE
    last_name LIKE '%q%';
-- 1873 entries for employees with a 'q' in the last name.

-- 12. Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?

SELECT 
    *
FROM
    employees
WHERE
    last_name LIKE '%q%'
        AND NOT last_name LIKE '%qu%';
    
-- 547 entries for employees with a 'q' but not 'qu' in the last name.





