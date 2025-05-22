CREATE TABLE movies (
  movie_id INT PRIMARY KEY,
  title VARCHAR(100) NOT NULL UNIQUE,
  genre VARCHAR(50),
  release_year INT CHECK (release_year >= 1900),
  imdb_rating DECIMAL(3,1)
);

INSERT INTO movies VALUES (1, 'Inception', 'Sci-Fi', 2010, 8.8);

UPDATE movies SET genre = 'Action', imdb_rating = 9.0 WHERE movie_id = 1;

DELETE FROM movies WHERE movie_id = 1;

