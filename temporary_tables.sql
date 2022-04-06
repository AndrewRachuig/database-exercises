-- 1. Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. 
USE employees;

CREATE TEMPORARY TABLE jemison_1747.employees_with_departments AS 
SELECT first_name, last_name, dept_name 
FROM employees
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no);

use jemison_1747;

SELECT * FROM employees_with_departments;
describe employees_with_departments;

-- a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
ALTER TABLE employees_with_departments 
ADD full_name VARCHAR(31);

-- b. Update the table so that full name column contains the correct data
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

-- c. Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name, DROP COLUMN last_name;

-- d. What is another way you could have ended up with this same table?
CREATE TEMPORARY TABLE jemison_1747.employees_with_departments AS 
SELECT CONCAT(first_name, ' ', last_name) as full_name, dept_name 
FROM employees
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no);

-- 2. Create a temporary table based on the payment table from the sakila database.

CREATE TEMPORARY TABLE sakila_payment AS
SELECT *
FROM sakila.payment;

SELECT * FROM sakila_payment;

-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
ALTER TABLE sakila_payment MODIFY COLUMN amount decimal(6,2);
UPDATE sakila_payment SET amount = amount * 100;
ALTER TABLE sakila_payment MODIFY COLUMN amount INT(4);

-- 3. Find out how the current average pay in each department compares to the overall, historical average pay.
USE employees;

CREATE TEMPORARY TABLE jemison_1747.department_pay AS
SELECT 
    ROUND(AVG(salary), 2) AS current_avg_salary, dept_name
FROM employees.employees
JOIN employees.dept_emp USING (emp_no)
JOIN employees.departments USING (dept_no)
JOIN employees.salaries USING (emp_no)
WHERE
    salaries.to_date > NOW()
GROUP BY dept_name;

USE jemison_1747;

Alter TABLE department_pay ADD COLUMN historical_avg_pay decimal(7,2), ADD COLUMN historical_stddev varchar(10);
SELECT * FROM department_pay;

UPDATE department_pay 
SET 
    historical_avg_pay = (SELECT 
            ROUND(avg(salary), 2)
        FROM
            employees.salaries),
    historical_stddev = (SELECT 
            ROUND(std(salary), 2)
        FROM
            employees.salaries);

SELECT 
    dept_name, current_avg_salary, historical_avg_pay, (current_avg_salary - historical_avg_pay) AS difference_in_dollars, round(((current_avg_salary - historical_avg_pay) / historical_stddev), 3) as zscore
FROM
    department_pay
ORDER BY dept_name;


-- In terms of salary, what is the best department right now to work for?
SELECT 
    dept_name, current_avg_salary, historical_avg_pay, (current_avg_salary - historical_avg_pay) AS difference_in_dollars, round(((current_avg_salary - historical_avg_pay) / historical_stddev), 3) as zscore
FROM
    department_pay
ORDER BY current_avg_salary DESC
LIMIT 1;

--  The worst?
SELECT 
    dept_name, current_avg_salary, historical_avg_pay, (current_avg_salary - historical_avg_pay) AS difference_in_dollars, round(((current_avg_salary - historical_avg_pay) / historical_stddev), 3) as zscore
FROM
    department_pay
ORDER BY current_avg_salary ASC
LIMIT 1;