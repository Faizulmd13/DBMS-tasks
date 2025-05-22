-- Create tables
CREATE TABLE departments (
  dept_no INT PRIMARY KEY,
  dept_name VARCHAR(100),
  dept_location VARCHAR(100)
);

CREATE TABLE employees (
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(100),
  emp_salary INT,
  dept_no INT,
  FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- Insert sample data
INSERT INTO departments VALUES
(1, 'HR', 'Building A'),
(2, 'IT', 'Building B');

INSERT INTO employees VALUES
(101, 'Alice', 30000, 1),
(102, 'Bob', 35000, 2);

-- TCL Commands

-- Begin transaction
START TRANSACTION;

-- Update salary of one employee
UPDATE employees SET emp_salary = emp_salary + 1000 WHERE emp_id = 101;

-- Create a savepoint
SAVEPOINT sp1;

-- Another update
UPDATE employees SET emp_salary = emp_salary + 2000 WHERE emp_id = 102;

-- Rollback to savepoint (undoes only the second update)
ROLLBACK TO sp1;

-- Finalize the transaction
COMMIT;

-- DCL Commands (Only works with appropriate user privileges)
-- Run these as a privileged user (e.g., root)
-- Example assumes user 'abcde' exists

-- GRANT
GRANT SELECT, INSERT, UPDATE ON employees;

-- REVOKE
REVOKE INSERT, UPDATE ON employees;

