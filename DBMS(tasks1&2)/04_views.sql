
-- Create view for available books

CREATE VIEW available_books AS
SELECT b.book_id, b.title, COUNT(bc.copy_id) AS available_copies
FROM books b
JOIN bookCopies bc ON b.book_id = bc.book_id
WHERE bc.available = 1
GROUP BY b.book_id, b.title;
