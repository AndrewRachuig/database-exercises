-- JOIN Example Database

use join_example_db;

-- 1. Use the join_example_db. Select all the records from both the users and roles tables.

SELECT * FROM users;
SELECT * FROM roles;

-- 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
-- Join guess is 4 results since 2 of the 6 users have a null role_id.

SELECT 
    *
FROM
    users
        JOIN
    roles ON users.role_id = roles.id;

-- Left Join guess is 6 results since it'll show all from the users table.

SELECT 
    *
FROM
    users
        LEFT JOIN
    roles ON users.role_id = roles.id;
    
-- Right Join guess is 5 results since there are 4 roles in the roles table but one of those roles will be represented 2 times by the users table which has two users with the same role_id.

SELECT 
    *
FROM
    users
        RIGHT JOIN
    roles ON users.role_id = roles.id;
    
-- 3. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.

SELECT 
    r.name, COUNT(*)
FROM
    roles AS r
        JOIN
    users AS u ON r.id = u.role_id
GROUP BY r.name;


-- Employees Database
use employees;

-- 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

SELECT 
    d.dept_name AS Department_Name,
    CONCAT(e.first_name, ' ', e.last_name) AS Manager_Name
FROM
    dept_manager AS dm
        JOIN
    employees AS e ON dm.emp_no = e.emp_no
        JOIN
    departments AS d using(dept_no)
WHERE
    dm.to_date > NOW()
ORDER BY d.dept_name;
    
-- 3. Find the name of all departments currently managed by women.

SELECT 
    d.dept_name AS Department_Name,
    CONCAT(e.first_name, ' ', e.last_name) AS Manager_Name
FROM
    dept_manager AS dm
        JOIN
    employees AS e ON dm.emp_no = e.emp_no
        JOIN
    departments AS d ON d.dept_no = dm.dept_no
WHERE
    dm.to_date > NOW() AND e.gender = 'F'
ORDER BY d.dept_name
;

-- 4. Find the current titles of employees currently working in the Customer Service department.

SELECT 
    t.title AS Title, COUNT(*) AS Count
FROM
    titles AS t
        JOIN
    dept_emp AS de ON de.emp_no = t.emp_no
        JOIN
    departments AS d ON d.dept_no = de.dept_no
WHERE
    d.dept_name = 'Customer Service'
        AND de.to_date > CURDATE()
        AND t.to_date > CURDATE()
GROUP BY Title
ORDER BY Title;

-- 5. Find the current salary of all current managers.

SELECT 
    d.dept_name AS Department_Name,
    CONCAT(e.first_name, ' ', e.last_name) AS Manager_Name,
    s.salary
FROM
    dept_manager AS dm
        JOIN
    employees AS e ON dm.emp_no = e.emp_no
        JOIN
    departments AS d ON d.dept_no = dm.dept_no
        JOIN
    salaries AS s ON s.emp_no = e.emp_no
WHERE
    dm.to_date > NOW() AND s.to_date > NOW()
ORDER BY d.dept_name;


-- 6. Find the number of current employees in each department.

SELECT 
    d.dept_no, d.dept_name, COUNT(*) as number_of_employees
FROM
    departments AS d
        JOIN
    dept_emp AS de ON d.dept_no = de.dept_no
        JOIN
    employees AS e ON e.emp_no = de.emp_no
    WHERE de.to_date > NOW()
GROUP BY d.dept_no
ORDER BY d.dept_no;

-- 7. Which department has the highest average salary? Hint: Use current not historic information.

SELECT 
    d.dept_name, AVG(s.salary) AS avg_salary
FROM
    departments AS d
        JOIN
    dept_emp AS de ON d.dept_no = de.dept_no
        JOIN
    employees AS e ON e.emp_no = de.emp_no
        JOIN
    salaries AS s ON s.emp_no = e.emp_no
WHERE
    s.to_date > NOW() and de.to_date > NOW()
GROUP BY d.dept_no
ORDER BY avg_salary DESC
LIMIT 1;

-- 8. Who is the highest paid employee in the Marketing department?

SELECT 
    first_name, last_name
FROM
    (SELECT 
        e.first_name, e.last_name, MAX(s.salary) AS highest_salary
    FROM
        employees AS e
    JOIN salaries AS s ON e.emp_no = s.emp_no
    JOIN dept_emp AS de ON de.emp_no = e.emp_no
    JOIN departments AS d ON d.dept_no = de.dept_no
    WHERE
        d.dept_name = 'Marketing' and s.to_date > NOW()
    GROUP BY e.first_name , e.last_name
    ORDER BY highest_salary DESC
    LIMIT 1) AS inner_select;


-- 9. Which current department manager has the highest salary?

SELECT 
    e.first_name,
    e.last_name,
    MAX(s.salary) AS salary,
    d.dept_name
FROM
    employees AS e
        JOIN
    salaries AS s ON e.emp_no = s.emp_no
        JOIN
    dept_emp AS de ON de.emp_no = e.emp_no
        JOIN
    departments AS d ON d.dept_no = de.dept_no
        JOIN
    dept_manager AS dm ON dm.emp_no = e.emp_no
WHERE
    dm.to_date > NOW() AND s.to_date > NOW()
GROUP BY e.first_name , e.last_name , d.dept_name
ORDER BY salary DESC
LIMIT 1;


-- 10. Determine the average salary for each department. Use all salary information and round your results.

SELECT 
    d.dept_name, round(AVG(s.salary)) AS avg_salary
FROM
    departments AS d
        JOIN
    dept_emp AS de ON d.dept_no = de.dept_no
        JOIN
    employees AS e ON e.emp_no = de.emp_no
        JOIN
    salaries AS s ON s.emp_no = e.emp_no
    GROUP BY d.dept_no;

-- This is a solution that is seemingly more complex with more steps but it works and returns results in around half the time
    
SELECT d_name, round(avg(salary)) as avg_salary 
FROM(

SELECT 
    d.dept_name as d_name, s.salary as salary
FROM
    employees AS e
        JOIN
    salaries AS s ON e.emp_no = s.emp_no
        JOIN
    dept_emp AS de ON de.emp_no = e.emp_no
        JOIN
    departments AS d ON d.dept_no = de.dept_no

    ) inner_select
    GROUP BY d_name
    ORDER BY avg_salary DESC
;

-- 11. Bonus Find the names of all current employees, their department name, and their current manager's name.

SELECT 
    CONCAT(self.first_name, ' ', self.last_name) as 'full_name',
    d.dept_name as department_name,
--     dm.emp_no AS 'department_manager_number',
    CONCAT(manager.first_name, ' ', manager.last_name) as 'manager_name'
FROM
    employees AS self 
        JOIN
    dept_emp AS de ON self.emp_no = de.emp_no
        JOIN
    departments AS d ON d.dept_no = de.dept_no
        JOIN
    dept_manager AS dm ON d.dept_no = dm.dept_no
		JOIN
	employees AS manager ON manager.emp_no = dm.emp_no
WHERE de.to_date > NOW() AND dm.to_date > NOW()
ORDER BY full_name
;
    
     
-- 12. Bonus Who is the highest paid employee within each department.

SELECT 
    salary, 
    dept_name, 
    CONCAT(first_name, ' ', last_name) as full_name
FROM
    employees e
        JOIN
    salaries sa USING (emp_no)
        JOIN
    dept_emp USING (emp_no)
        JOIN
    departments USING (dept_no)
WHERE
    (salary, dept_name) 
    IN (
		SELECT 
            MAX(salary), 
            dept_name
        FROM
            salaries s
                JOIN
            employees e USING (emp_no)
                JOIN
            dept_emp de USING (emp_no)
                JOIN
            departments USING (dept_no)
        WHERE
            s.to_date > NOW() AND de.to_date > NOW()
        GROUP BY dept_name);