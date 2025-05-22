-- Create required tables
CREATE TABLE movies (
  movie_id INT PRIMARY KEY,
  title VARCHAR(100),
  genre VARCHAR(50),
  production_company VARCHAR(100)
);

CREATE TABLE ott_platform (
  platform_id INT PRIMARY KEY,
  movie_id INT,
  platform VARCHAR(50),
  director VARCHAR(50),
  imdb_rating DECIMAL(3,1)
);

-- Insert sample data
INSERT INTO movies VALUES
(1, 'Inception', 'Sci-Fi', 'Warner Bros'),
(2, 'Interstellar', 'Sci-Fi', 'Paramount');

INSERT INTO ott_platform VALUES
(1, 1, 'Netflix', 'Christopher Nolan', 8.8),
(2, 2, 'Amazon Prime', 'Christopher Nolan', 8.6);

-- Subquery: Select movies present in table
SELECT title, genre, production_company
FROM movies
WHERE movie_id IN (SELECT movie_id FROM movies);

-- INNER JOIN
SELECT m.title, o.platform
FROM movies m
INNER JOIN ott_platform o ON m.movie_id = o.movie_id;

-- LEFT JOIN
SELECT m.title, o.platform
FROM movies m
LEFT JOIN ott_platform o ON m.movie_id = o.movie_id;

-- RIGHT JOIN
SELECT m.title, o.platform
FROM movies m
RIGHT JOIN ott_platform o ON m.movie_id = o.movie_id;

