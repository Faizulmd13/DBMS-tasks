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

-- NATURAL JOIN
SELECT * FROM movies NATURAL JOIN ott_platform;

-- EQUI JOIN
SELECT *
FROM movies
JOIN ott_platform ON movies.movie_id = ott_platform.movie_id;

-- LEFT OUTER JOIN
SELECT *
FROM movies
LEFT OUTER JOIN ott_platform ON movies.movie_id = ott_platform.movie_id;

-- RIGHT OUTER JOIN (MySQL/MariaDB only)
SELECT *
FROM movies
RIGHT OUTER JOIN ott_platform ON movies.movie_id = ott_platform.movie_id;

-- FULL OUTER JOIN (not supported in MySQL directly — use UNION)
SELECT *
FROM movies
LEFT JOIN ott_platform ON movies.movie_id = ott_platform.movie_id
UNION
SELECT *
FROM movies
RIGHT JOIN ott_platform ON movies.movie_id = ott_platform.movie_id;

