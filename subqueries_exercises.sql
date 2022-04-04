use employees;

-- 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.
SELECT 
    *
FROM
    employees
WHERE
    hire_date = (SELECT 
            hire_date
        FROM
            employees
        WHERE
            emp_no = 101010);
            
-- 2. Find all the titles ever held by all current employees with the first name Aamod.
SELECT DISTINCT
    title
FROM
    titles
        JOIN
    (SELECT 
        *
    FROM
        employees
    WHERE
        first_name = 'Aamod') AS aamods ON titles.emp_no = aamods.emp_no;
        
-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

SELECT 
    count(emp_no)
FROM
    (SELECT 
        emp_no, MAX(to_date) AS last_working_date
    FROM
        salaries
    GROUP BY emp_no) AS inner_query
WHERE
    last_working_date < NOW();
-- 59900 employees are no longer working for the company.alter

-- 4.Find all the current department managers that are female. List their names in a comment in your code.

SELECT 
    CONCAT(first_name, ' ', last_name), gender
FROM
    employees
        JOIN
    (SELECT 
        emp_no
    FROM
        dept_manager) AS managers on managers.emp_no = employees.emp_no
WHERE
    employees.gender = 'F';
    
-- 'Isamu Legleitner'
-- 'Shirish Ossenbruggen'
-- 'Karsten Sigstam'
-- 'Krassimir Wegerle'
-- 'Rosine Cools'
-- 'Leon DasSarma'
-- 'Peternela Onuegbe'
-- 'Rutger Hofmeyr'
-- 'Sanjoy Quadeer'
-- 'Hilary Kambil'
-- 'Tonny Butterworth'
-- 'Marjo Giarratana'
-- 'Xiaobin Spinelli'


-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.

SELECT DISTINCT
    CONCAT(first_name, ' ', last_name)
FROM
    employees AS e
        JOIN
    salaries AS s USING (emp_no)
WHERE
    s.salary > (SELECT 
            AVG(salary)
        FROM
            salaries)
            AND s.to_date > NOW();
            
-- 6. How many current salaries are within 1 standard deviation of the current highest salary?
SELECT MAX(salary) FROM salaries;

SELECT STDDEV(salary) FROM salaries;

SELECT 
    COUNT(salary)
FROM
    salaries
WHERE
    salary > ((SELECT 
            MAX(salary)
        FROM
            salaries) - (SELECT 
            STDDEV(salary)
        FROM
            salaries));
            
-- 211 salaries are within 1 SD of the max salary

-- BONUS
-- 1. Find all the department names that currently have female managers.

SELECT DISTINCT
    dept_name
FROM
    departments AS d
        JOIN
    dept_emp AS de ON de.dept_no = d.dept_no
        JOIN
    (SELECT 
        e.emp_no
    FROM
        employees AS e
    JOIN (SELECT 
        emp_no
    FROM
        dept_manager) AS managers ON managers.emp_no = e.emp_no
    WHERE
        e.gender = 'F') AS female_managers ON female_managers.emp_no = de.emp_no;
        
-- 2. Find the first and last name of the employee with the highest salary.
SELECT 
    CONCAT(first_name, ' ', last_name) AS highest_earning_employee
FROM
    employees AS e
        JOIN
    (SELECT 
        salary, emp_no
    FROM
        salaries
    ORDER BY salary DESC
    LIMIT 1) AS s ON e.emp_no = s.emp_no;
    
-- 3. Find the department name that the employee with the highest salary works in.
SELECT 
    d.dept_name
FROM
    departments AS d
        JOIN
    dept_emp AS de ON de.dept_no = d.dept_no
WHERE
    de.emp_no = (SELECT 
            emp_no
        FROM
            salaries
        ORDER BY salary DESC
        LIMIT 1);