
-- Insert data into tables

INSERT INTO author (author_id, author_name, published_books) VALUES
(1, 'J.K. Rowling', 7),
(2, 'George Orwell', 4),
(3, 'Jane Austen', 6);

INSERT INTO books (book_id, title, author_id, genre, published_year) VALUES
(102, '1984', 2, 'Dystopian', '1949-06-08'),
(103, 'Pride and Prejudice', 3, 'Romance', '1813-01-28');

INSERT INTO bookCopies (copy_id, book_id, available) VALUES
(1003, 102, 1),
(1004, 103, 1),
(1005, 103, 1);

INSERT INTO members (member_id, name, email, joined_date) VALUES
(201, 'Alice', 'alice@example.com', '2023-01-01'),
(202, 'Bob', 'bob@example.com', '2022-09-15'),
(203, 'Charlie', 'charlie@example.com', '2023-05-20');

INSERT INTO borrowings (borrow_id, member_id, copy_id, borrow_date, return_date) VALUES
(302, 202, 1003, '2024-04-05', '2025-04-14');
