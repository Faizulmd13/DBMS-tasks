
-- Testing SELECT queries
SELECT * FROM author;
SELECT * FROM books;
SELECT * FROM bookCopies;
SELECT * FROM members;
SELECT * FROM borrowings;
SELECT * FROM available_books;

-- Test joining tables
SELECT b.title, a.author_name
FROM books b
JOIN author a ON b.author_id = a.author_id;

-- Insert new member
INSERT INTO members (member_id, name, email, joined_date)
VALUES (204, 'David', 'david@example.com', '2025-01-01');

-- Borrow a book and check trigger effect
INSERT INTO borrowings (borrow_id, member_id, copy_id, borrow_date)
VALUES (303, 204, 1004, '2025-05-22');

-- Check if bookCopies updated
SELECT * FROM bookCopies WHERE copy_id = 1004;

-- Return a book and check trigger effect
UPDATE bookCopies SET available = 1 WHERE copy_id = 1004;

-- Check if borrowings return_date updated
SELECT * FROM borrowings WHERE copy_id = 1004;
