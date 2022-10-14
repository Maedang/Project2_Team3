-- Create a new table
CREATE TABLE movies (
  imdb_id VARCHAR(30) NOT NULL,
  title VARCHAR(255) NOT NULL,
  year INT,
  runtime INT,
  genre CHAR(255) NOT NULL,
  rated VARCHAR(30) NOT NULL,
  language CHAR(255) NOT NULL,
  country CHAR(255) NOT NULL,
  metascore INT,
  imdb_rating REAL,
  box_office INT
);
