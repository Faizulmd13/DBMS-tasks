-- Create the Employees table
CREATE TABLE Employees (
  EmployeeID INT PRIMARY KEY,
  EmployeeName VARCHAR(100),
  Department VARCHAR(50),
  Salary DECIMAL(10,2)
);

-- Insert initial data
INSERT INTO Employees (EmployeeID, EmployeeName, Department, Salary) VALUES
(1, 'John Doe', 'HR', 5000.00),
(2, 'Jane Smith', 'IT', 6000.00),
(3, 'Mike Johnson', 'Finance', 5500.00);

CREATE VIEW emp AS
SELECT employeeid, employeeName, department FROM employees WHERE employeeid <= 10;

SELECT * FROM emp;

CREATE INDEX idx_name ON employees(employeeName);
SHOW INDEX FROM employees;

