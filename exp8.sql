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

-- Trigger to validate salary before insertion
DELIMITER //
CREATE TRIGGER before_insert_employee
BEFORE INSERT ON Employees
FOR EACH ROW
BEGIN
  IF NEW.Salary < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Salary must be positive';
  END IF;
END;
//
DELIMITER ;

-- Trigger to prevent deletion of HR employees
DELIMITER //
CREATE TRIGGER before_delete_employee
BEFORE DELETE ON Employees
FOR EACH ROW
BEGIN
  IF OLD.Department = 'HR' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Deletion of HR employees not allowed';
  END IF;
END;
//
DELIMITER ;

-- Trigger to prevent employee name updates
DELIMITER //
CREATE TRIGGER before_update_employee
BEFORE UPDATE ON Employees
FOR EACH ROW
BEGIN
  IF NEW.EmployeeName <> OLD.EmployeeName THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee name cannot be changed';
  END IF;
END;
//
DELIMITER ;

