use employees;

-- 2. In your script, use DISTINCT to find the unique titles in the titles table. 

SELECT DISTINCT
    title
FROM
    titles;

-- How many unique titles have there ever been? Answer that in a comment in your SQL file.

-- There have been 7 unique titles


-- 3. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.

SELECT 
    last_name
FROM
    employees
WHERE
    last_name LIKE 'E%E'
GROUP BY last_name;


-- 4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.

SELECT 
    first_name, last_name
FROM
    employees
WHERE
    last_name LIKE 'E%E'
GROUP BY last_name , first_name
ORDER BY last_name , first_name;


-- 5. Write a query to find the unique last names with a 'q' but not 'qu'. 

SELECT 
    last_name
FROM
    employees
WHERE
    last_name LIKE '%q%'
        AND NOT last_name LIKE '%qu%'
GROUP BY last_name;

-- Include those names in a comment in your sql code.
-- Chleq, Lindqvist, Qiwen

-- 6. Add a COUNT() to your results (the query above) to find the number of employees with the same last name.

SELECT 
    last_name, count(last_name)
FROM
    employees
WHERE
    last_name LIKE '%q%'
        AND NOT last_name LIKE '%qu%'
GROUP BY last_name;


-- 7. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. 

SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Irena' , 'Vidya', 'Maya');

-- Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

SELECT 
    first_name, gender, COUNT(*)
FROM
    employees
WHERE
    first_name IN ('Irena' , 'Vidya', 'Maya')
GROUP BY gender , first_name
ORDER BY first_name;


-- 8. Using your query that generates a username for all of the employees, generate a count employees for each unique username.
SELECT 
    LOWER(CONCAT(SUBSTR(first_name, 1, 1),
                    SUBSTR(last_name, 1, 4),
                    '_',
                    SUBSTR(birth_date, 6, 2),
                    SUBSTR(birth_date, 3, 2))) AS 'username',
    count(*) AS total
FROM
    employees
GROUP BY username
ORDER BY total DESC;

-- Are there any duplicate usernames? 
-- Yes there are duplicates

-- BONUS: How many duplicate usernames are there?
SELECT 
    COUNT(*)
FROM
    (SELECT 
		LOWER(CONCAT(SUBSTR(first_name, 1, 1),
                    SUBSTR(last_name, 1, 4),
                    '_',
                    SUBSTR(birth_date, 6, 2),
                    SUBSTR(birth_date, 3, 2))) AS 'username',
		count(*) AS total
	FROM
        employees
    GROUP BY username
    ORDER BY total DESC) sub
WHERE
    total > 1;

-- 13251 usernames have duplicates

-- Personal Bonus: The following code shows that there are 27403 total users using the same username as another user.
SELECT SUM(total) FROM (
SELECT 
    LOWER(CONCAT(SUBSTR(first_name, 1, 1),
                    SUBSTR(last_name, 1, 4),
                    '_',
                    SUBSTR(birth_date, 6, 2),
                    SUBSTR(birth_date, 3, 2))) AS 'username',
    count(*) AS total
FROM
    employees
GROUP BY username
ORDER BY total DESC) sub
WHERE total > 1;


-- 9. Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.

SELECT 
    emp_no, round(avg(salary), 2)
FROM
    salaries
GROUP BY emp_no;

-- Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.

SELECT 
    dept_no, COUNT(*)
FROM
    dept_emp
GROUP BY dept_no;

-- Determine how many different salaries each employee has had. This includes both historic and current.

SELECT 
    emp_no, COUNT(salary)
FROM
    salaries
GROUP BY emp_no;

-- Find the maximum salary for each employee.

SELECT 
    emp_no, MAX(salary)
FROM
    salaries
GROUP BY emp_no;

-- Find the minimum salary for each employee.

SELECT 
    emp_no, MIN(salary)
FROM
    salaries
GROUP BY emp_no;

-- Find the standard deviation of salaries for each employee.

SELECT 
    emp_no, ROUND(STDDEV(salary), 2)
FROM
    salaries
GROUP BY emp_no;

-- Now find the max salary for each employee where that max salary is greater than $150,000.

SELECT 
    emp_no, MAX(salary) AS Max_Salary
FROM
    salaries
GROUP BY emp_no
HAVING Max_Salary > 150000;

-- Find the average salary for each employee where that average salary is between $80k and $90k.

SELECT 
    emp_no, ROUND(AVG(salary), 2) AS Avg_Salary
FROM
    salaries
GROUP BY emp_no
HAVING Avg_Salary BETWEEN 80000 AND 90000;
