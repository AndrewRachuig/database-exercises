use employees;

-- 1. Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
SELECT CONCAT(first_name, ' ', last_name) as full_name, dept_no, hire_date as start_date, to_date, to_date = '9999-01-01' AS is_current_employee
FROM
employees
join dept_emp USING (emp_no)
ORDER BY emp_no ASC, to_date DESC
;


-- 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
CREATE TEMPORARY TABLE jemison_1747.name_groupings AS
(SELECT CONCAT(first_name, ' ', last_name) as full_name, last_name FROM employees.employees GROUP BY emp_no);

USE jemison_1747;
SELECT 
    full_name,
    CASE
        WHEN last_name REGEXP '^[a-h]' THEN 'A-H'
        WHEN last_name REGEXP '^[i-q]' THEN 'I-Q'
        WHEN last_name REGEXP '^[r-z]' THEN 'R-Z'
    END AS alpha_group
FROM
    name_groupings;

-- 3. How many employees (current or previous) were born in each decade?

USE employees;
SELECT * FROM employees;
SELECT Max(birth_date) FROM employees;
SELECT MIN(birth_date) FROM employees;

-- Answer as a CASE statement
SELECT 
    COUNT(emp_no),
    CASE
        WHEN birth_date >= '1960-01-01' THEN 'Sixties'
        WHEN birth_date < '1960-01-01' THEN 'Fifties'
    END AS decade
FROM
    employees
GROUP BY decade;

-- Answer as an IF statement
SELECT count(emp_no),
IF (birth_date >= '1960-01-01', 'Sixties', 'Fifties') AS decade
FROM employees
GROUP BY decade;

-- 4. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
SELECT dept_name FROM departments;

SELECT CASE
	WHEN dept_name IN ('Research', 'Development') THEN 'R&D'
    WHEN dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
    WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
    WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
    ELSE dept_name
    END AS dept_group,
    avg(salary)
FROM departments
JOIN dept_emp USING(dept_no)
JOIN salaries USING(emp_no)
WHERE salaries.to_date > NOW()
GROUP BY dept_group;