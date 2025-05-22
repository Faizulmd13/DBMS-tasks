
-- Trigger to set return_date when a copy is returned

CREATE TRIGGER set_return_date
AFTER UPDATE ON bookCopies
FOR EACH ROW
WHEN NEW.available = 1
BEGIN
  UPDATE borrowings
  SET return_date = DATE('now')
  WHERE copy_id = NEW.copy_id AND return_date IS NULL;
END;

-- Trigger to set availability to false after borrowing

CREATE TRIGGER set_unavailable
AFTER INSERT ON borrowings
FOR EACH ROW
BEGIN
  UPDATE bookCopies
  SET available = 0
  WHERE copy_id = NEW.copy_id;
END;
