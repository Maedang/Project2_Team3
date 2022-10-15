DROP TABLE movies;

CREATE TABLE movies (
  imdb_id VARCHAR(30) NOT NULL,
  title VARCHAR(255) NOT NULL,
  year INT,
  runtime INT,
  genre CHAR(255) NOT NULL,
  rated VARCHAR(30) NOT NULL,
  language CHAR(255) NOT NULL,
  country CHAR(255) NOT NULL,
  metascore REAL,
  imdb_rating REAL,
  box_office INT
);

SELECT * FROM movies;

SELECT title, runtime, box_office FROM movies WHERE country = 'United States';