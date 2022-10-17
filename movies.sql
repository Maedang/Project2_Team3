-- Drop table if it already exists
DROP TABLE movies;

-- Create table with columns and data types
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
  box_office INT,
  type VARCHAR(10) NOT NULL
);

-- Query all data
SELECT * FROM movies; -- 10774 records of movies

-- Query title, box_office, country from only US showing movies and sort by descending order of box_office
SELECT title, box_office, country FROM movies WHERE country = 'United States' ORDER BY box_office DESC; -- 5654 movies with only US showings with Star Wars VII the highest domestic box_office number

-- Query the Top 10 movies by imdb_rating and box_office shown in the US 
SELECT title, box_office, metascore, imdb_rating FROM movies WHERE country LIKE '%United States%' ORDER BY imdb_rating DESC, box_office DESC LIMIT 10; -- The Shawshank Redemption is the top rated movie in our database by imdb_rating, yet it does not have the highest box_office number

-- Query the Top 10 movies by metascore and box_office shown in the US 
SELECT title, box_office, metascore, imdb_rating FROM movies WHERE country LIKE '%United States%' ORDER BY metascore DESC, box_office DESC LIMIT 10; -- Casablanca is the top rated movie in our database by metascore, with the highest box_office number of the max metascore

-- Query the best performing year on average in our database
SELECT year, ROUND(AVG(box_office), 2) AS "AverageBoxOffice" FROM movies GROUP BY year ORDER BY "AverageBoxOffice" DESC; -- 2019 seems to be the best performing year on average of all movies in our database

-- Query the worst performing year on average in our database
SELECT year, ROUND(AVG(box_office), 2) AS "AverageBoxOffice" FROM movies GROUP BY year ORDER BY "AverageBoxOffice" ASC; -- 1945 seems to be the worst performing year on average of all movies in our database

-- Query the best performing movie rating on average in our database
SELECT rated, ROUND(AVG(box_office), 2) AS "AverageBoxOffice" FROM movies GROUP BY rated ORDER BY "AverageBoxOffice" DESC; -- G rating proves to be the highest grossing rating category on average

-- From here, the project can continue past the project parameters into the analysis stage by using the database as a source for any data required and available.