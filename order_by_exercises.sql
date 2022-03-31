use employees;

-- 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. 
SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;

-- In your comments, answer: What was the first and last name in the first row of the results? 
-- Irena Reutenauer
-- What was the first and last name of the last person in the table?
-- Vidya Simmen

-- 3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. 
SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Irena' , 'Vidya', 'Maya')
ORDER BY first_name, last_name;

-- In your comments, answer: What was the first and last name in the first row of the results? 
-- Irena Acton
-- What was the first and last name of the last person in the table?
-- Vidya Zweizig

-- 4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. 
SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Irena' , 'Vidya', 'Maya')
ORDER BY last_name, first_name;

-- In your comments, answer: What was the first and last name in the first row of the results? 
-- Irena Acton
-- What was the first and last name of the last person in the table?
-- Maya Zyda

-- 5. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. 
SELECT 
    *
FROM
    employees
WHERE
    last_name LIKE 'E%e'
ORDER BY emp_no;

-- Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.
-- 899 employees, first employee number 10021 with first and last name Ramzi Erde, last employee number 499648 with first and last name Tadahiro Erde

-- 6. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. 
SELECT 
    *
FROM
    employees
WHERE
    last_name LIKE 'E%e'
ORDER BY hire_date DESC;

-- Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.
-- 899 employees, newest employee is Teiji Eldridge and oldest employee is Sergi Erde

-- 7. Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. 
SELECT 
    *
FROM
    employees
WHERE
    birth_date LIKE '____-12-25'
        AND (hire_date >= '1990-01-01'
        AND hire_date < '2000-01-01')
ORDER BY birth_date ASC , hire_date DESC; 

-- Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first.
-- 362 employees, Khun Bernini oldest employee hired last, Douadi Pettis youngest employee hired first


 

