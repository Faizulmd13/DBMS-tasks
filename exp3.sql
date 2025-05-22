-- Create the movie table
CREATE TABLE movie (
  movie_id INT PRIMARY KEY,
  title VARCHAR(100),
  platform_id INT,
  release_year INT,
  running_time INT,
  imdb_rating DECIMAL(3,1)
);

-- Insert sample data
INSERT INTO movie VALUES (1, 'Inception', 1, 2021, 148, 8.8);
INSERT INTO movie VALUES (2, 'Interstellar', 2, 2014, 169, 8.6);

-- WHERE clause examples
SELECT * FROM movie WHERE release_year = 2021;
SELECT * FROM movie WHERE running_time <= 158;
SELECT * FROM movie WHERE imdb_rating > 8;

-- ORDER BY example (sorting movies by IMDb rating descending)
SELECT * FROM movie ORDER BY imdb_rating DESC;

-- GROUP BY example (count number of movies grouped by release year)
SELECT release_year, COUNT(*) AS movie_count
FROM movie
GROUP BY release_year;

-- Aggregate functions
SELECT platform_id, COUNT(*) FROM movie GROUP BY platform_id;
SELECT platform_id, SUM(running_time) FROM movie GROUP BY platform_id;
SELECT MAX(imdb_rating), MIN(imdb_rating), AVG(running_time) FROM movie;

