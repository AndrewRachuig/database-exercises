use employees;

show tables;

describe employees;

-- Which table(s) do you think contain a numeric type column? dept_emp, dept_manager, employees, salaries, titles

-- Which table(s) do you think contain a string type column? departments, dept_emp, dept_manager, employees, titles

-- Which table(s) do you think contain a date type column? dept_emp, dept_manager, employees, salaries, titles

-- What is the relationship between the employees and the departments tables?  There is no obvious relationship connecting the tables directly to one another but they are both referenced in a third table called dept_emp.

show create table dept_manager;
