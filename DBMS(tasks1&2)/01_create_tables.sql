
-- Table creation statements

CREATE TABLE author (
  author_id INTEGER PRIMARY KEY,
  author_name TEXT,
  published_books INTEGER
);

CREATE TABLE books (
  book_id INTEGER PRIMARY KEY,
  title TEXT,
  author_id INTEGER,
  genre TEXT,
  published_year DATE,
  FOREIGN KEY (author_id) REFERENCES author(author_id)
);

CREATE TABLE bookCopies (
  copy_id INTEGER PRIMARY KEY,
  book_id INTEGER,
  available BOOLEAN,
  FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE
);

CREATE TABLE members (
  member_id INTEGER PRIMARY KEY,
  name TEXT,
  email TEXT,
  joined_date DATE
);

CREATE TABLE borrowings (
  borrow_id INTEGER PRIMARY KEY,
  member_id INTEGER,
  copy_id INTEGER,
  borrow_date DATE,
  return_date DATE,
  FOREIGN KEY (member_id) REFERENCES members(member_id),
  FOREIGN KEY (copy_id) REFERENCES bookCopies(copy_id) ON DELETE CASCADE
);
