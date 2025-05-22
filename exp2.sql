CREATE TABLE ott_platforms (
  platform_id INT PRIMARY KEY,
  name VARCHAR(100)
);

CREATE TABLE movie (
  movie_id INT PRIMARY KEY,
  title VARCHAR(100),
  platform_id INT,
  FOREIGN KEY (platform_id) REFERENCES ott_platforms(platform_id)
    ON UPDATE CASCADE ON DELETE SET NULL
);

INSERT INTO ott_platforms VALUES (1, 'Netflix');
INSERT INTO movie VALUES (1, 'Stranger Things', 1);

