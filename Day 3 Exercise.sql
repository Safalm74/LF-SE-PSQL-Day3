create schema day3exercise;

CREATE TABLE
    employees (
        emp_id SERIAL PRIMARY KEY,
        emp_name VARCHAR(100) NOT NULL,
        emp_salary DECIMAL(10, 2),
        emp_dept_id INT,
        emp_manager_id INT
    );

CREATE TABLE
    departments (
        dept_id SERIAL PRIMARY KEY,
        dept_name VARCHAR(100) NOT NULL,
        dept_head_id INT,
        location VARCHAR(100)
    );

CREATE TABLE
    projects (
        project_id SERIAL PRIMARY KEY,
        project_name VARCHAR(100) NOT NULL,
        project_budget DECIMAL(12, 2),
        start_date DATE,
        end_date DATE
    );

CREATE TABLE
    employee_projects (
        emp_id INT,
        project_id INT,
        PRIMARY KEY (emp_id, project_id),
        FOREIGN KEY (emp_id) REFERENCES employees (emp_id),
        FOREIGN KEY (project_id) REFERENCES projects (project_id)
    );

CREATE TABLE
    salaries (
        salary_id SERIAL PRIMARY KEY,
        emp_id INT,
        salary_amount DECIMAL(10, 2) NOT NULL,
        salary_date DATE NOT NULL,
        FOREIGN KEY (emp_id) REFERENCES employees (emp_id)
    );

INSERT INTO
    employees (emp_name, emp_salary, emp_dept_id, emp_manager_id)
VALUES
    ('John Doe', 60000.00, 1, NULL),
    ('Jane Smith', 70000.00, 1, 1),
    ('Michael Johnson', 65000.00, 2, NULL),
    ('Emily Davis', 62000.00, 2, 3),
    ('Robert Brown', 68000.00, 1, 1),
    ('Jessica Wilson', 64000.00, 2, 3),
    ('David Martinez', 61000.00, 3, NULL),
    ('Lisa Anderson', 69000.00, 3, 7),
    ('Daniel Taylor', 63000.00, 3, 7),
    ('Sarah Garcia', 66000.00, 1, 1);

INSERT INTO
    departments (dept_name, dept_head_id, location)
VALUES
    ('Sales', 1, 'New York'),
    ('Marketing', 3, 'San Francisco'),
    ('Finance', 7, 'Chicago'),
    ('HR', 10, 'Utah'),
    ('ADMIN', 11, 'California'),
    ('ACCOUNT', 12, 'texas');

INSERT INTO
    projects (
        project_name,
        project_budget,
        start_date,
        end_date
    )
VALUES
    (
        'Project A',
        100000.00,
        '2024-01-01',
        '2024-06-30'
    ),
    (
        'Project B',
        150000.00,
        '2024-02-15',
        '2024-07-31'
    ),
    (
        'Project C',
        120000.00,
        '2024-03-01',
        '2024-08-15'
    ),
    ('Project D', 90000.00, '2024-04-01', '2024-09-30'),
    (
        'Project E',
        110000.00,
        '2024-05-01',
        '2024-10-31'
    );

INSERT INTO
    employee_projects (emp_id, project_id)
VALUES
    (1, 1),
    (2, 1),
    (3, 2),
    (4, 2),
    (5, 1),
    (6, 3),
    (7, 3),
    (8, 2),
    (9, 1),
    (10, 3);

INSERT INTO
    salaries (emp_id, salary_amount, salary_date)
VALUES
    (1, 60000.00, '2024-06-01'),
    (2, 70000.00, '2024-06-01'),
    (3, 65000.00, '2024-06-01'),
    (4, 62000.00, '2024-06-01'),
    (5, 68000.00, '2024-06-01'),
    (6, 64000.00, '2024-06-01'),
    (7, 61000.00, '2024-06-01'),
    (8, 69000.00, '2024-06-01'),
    (9, 63000.00, '2024-06-01'),
    (10, 66000.00, '2024-06-01');

--Question: inner join: Retrieve employees along with their department names.
select
    e,
    d.dept_name
from
    employees e
    join departments d on d.dept_id = e.emp_dept_id;

--Question: Left join: Retrieve all employees and their department names, including employees without assigned departments.
select
    e,
    d.dept_name
from
    employees e
    left join departments d on d.dept_id = e.emp_dept_id;

--Question: Right Join: Retrieve all departments and the names of their department heads, including departments without assigned heads.
select
    * --d.dept_name  ,e.emp_name 
from
    employees e
    right join departments d on d.dept_head_id = e.emp_id;

--Question: full join:Retrieve all employees and their assigned projects, including employees without assigned projects and projects without assigned employees.
select
    e.emp_name,
    p.project_name
from
    employees e
    full join employee_projects ep on e.emp_id = ep.emp_id
    full join projects p on ep.project_id = p.project_id;

--Question: Self join: Retrieve pairs of employees who work in the same department.
select
    e2.emp_name,
    e.emp_name,
    e.emp_dept_id
from
    employees e
    join employees e2 on e2.emp_dept_id = e.emp_dept_id
    and e2.emp_id <> e.emp_id;

--Question: Retrieve all possible combinations of employees and projects.
select
    e.emp_name,
    p.project_name
from
    employees e
    cross join projects p;

--Question: Retrieve all records where there is a matching column name between employees and salaries.
select
    *
from
    employees e
    natural join salaries s