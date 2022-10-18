# Project 2 - Team 3 - Movies Database
## Team Members: 
Dejan Savic, Jenish Rana, Carolyn Johnson, Mai Dang 

## √ Proposal:

We would like to create a database of movies to be able to determine whether there are factors that affect a movie’s box office numbers. To complete this analysis, we will use the ETL process to utilize two different datasets from the following sources:</br>

    https://www.kaggle.com/datasets/whenamancodes/popular-movies-datasets-58000-movies?resource=download

    https://www.omdbapi.com/

The Kaggle dataset includes a list of 58,099 movies with their Titles and Genres in one csv. The other 5 csvs all contain unique IDs for us to be able to merge them to bring in other information such as IMDb Tags, Ratings, Category Tags, etc. Using the Kaggle dataset, we will use the IMDb tags to request API information on Box Office numbers as well as other various information for each movie in the dataset.</br>

Once we have cleaned, merged, and identified the variables we are looking for, we will use a relational database in the form of SQLAlchemy to store all our information in relevant tables. We chose a relational database because our data comes with unique identifiers that are able to identify the pre-established relationships that already exist within the dataset.</br>

## √ Extract: 
 For our project, we searched for datasets of movies in relation to year of release, country, language, box office numbers, genres, IMDb rating, movie rating, and runtime. Specifically, our data consists of a Kaggle dataset that contained 6 csv's with the main dataset containing Titles and Genres of 58,099 different box office movies. We then used the other csv's within the Kaggle dataset that contained various factors like ratings and IMDb tags to request the necessary information such as Runtime and Box Office from our API source:</br>

  ```Python
  # Path to resources
  movies_path = "Resources/movies.csv"
  links_path = "Resources/links.csv"

  # Read the csvs
  movies_df = pd.read_csv(movies_path)
  links_df = pd.read_csv(links_path)

  # Merge the two csvs into one Pandas Dataframe
  merge_df = pd.merge(movies_df, links_df, on = "movieId", how = "outer")
  ```
  For the extraction of our API data, we utilized the Requests module to perform a for loop with calls for each IMDb id in our Kaggle dataset. We then appended each response to empty lists to store in a dataframe and transform for database upload. We spent some time fixing the errors in the dataset and transforming the data. However, we ultimately were able to clean the dataset, continue our analysis and load the data into Postgres:</br>

  ```Python
  # Empty lists to hold response info
  box_office = []
  imdb_id = []
  title = []
  year = []
  runtime = []
  genre = []
  rated = []
  language = []
  country = []
  metascore = []
  imdb_rating = []
  type = []

  counter = 0

  # For loop to append response results for each movie in our csv file
  for id in merged_movies['imdbId']:
      try:
          response = requests.get(url + id + api_key).json()
          box_office.append(response['BoxOffice'])
          imdb_id.append(response['imdbID'])
          title.append(response['Title'])
          year.append(response['Year'])
          runtime.append(response['Runtime'])
          genre.append(response['Genre'])
          rated.append(response['Rated'])
          language.append(response['Language'])
          country.append(response['Country'])
          metascore.append(response['Metascore'])
          imdb_rating.append(response['imdbRating'])
          type.append(response['Type'])
          counter += 1
          print(f'Processed record: {id}')
      except KeyError:
          print(f'Record {id} missing key information. Skipping...')
      
  print(f'The total number of records found was: {counter} out of {merged_movies.imdbId.count()}')
  ```

## √ Transform: 
  During our transforming stage of cleaning, joining, filtering, and aggregating our csv datasets, we had a few steps to undertake. Our first steps in cleaning up the datasets involved figuring out which variables were not relevant. Pandas was used as the main tool in our Jupyter Notebook to load all three CSV files. Next was filtering the files and joining them together into data frames. We removed the genres and tmdbId columns as they were not relevant to the focus of this study. The team identified nulls by performing an outer merge on the movieId column across all datasets. The key to being able to request the information from the API was in the imdbId tag in the csv's. To match the IDs to the parameters the API was requesting, we had to transform the imdbId column using pandas: </br>
  
  ```Python
  # Drop N/As
  cleaned_df = merge_df.dropna()

  # Add 'tt' to the IMDb IDs for the API response
  cleaned_df.imdbId = cleaned_df.imdbId.astype(str)
  cleaned_df.imdbId = 'tt' + cleaned_df.imdbId.str.zfill(7)

  # Remove unnecessary columns
  del cleaned_df['genres']
  del cleaned_df['tmdbId']

  # Set index to movieID
  cleaned_df = cleaned_df.set_index('movieId')
  ```

  Once the csv data was transformed and ready for API use, we ran the API for loop pictured in the Extract block. Then, the responses were loaded into empty lists and a DataFrame was created so that we could transform the dataset we acquired through the API. We changed some data types and replaced some columns with necessary changes so that it could load cleaner into our Postgres database:</br>

  ```Python
  # Remove unnecessary columns and N/A data
  del df["Unnamed: 0"]
  reduced = df.dropna()

  # Fix columns for cleaner data
  reduced['Runtime'] = reduced['Runtime'].str.extract('(\d+)').astype(int)
  reduced['Box_Office'] = reduced['Box_Office'].str.replace("$", "")
  reduced['Box_Office'] = reduced['Box_Office'].str.replace(",", "")
  reduced['Box_Office'] = reduced['Box_Office'].astype(int)
  reduced.set_index('IMDbID', inplace=True)
  ```
    
## √ Load: 
  The last step in the project was to load the data into a database for storage and use. We chose to utilize PostgreSQL using pgAdmin as our management tool. Since much of our transformation and cleaning of data was done previous to loading into our database, our database will be pretty straightforward. We created a Database using pgAdmin and then used a SQL statement to create a table named movies in the Database:</br>

  ```SQL
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
  ```

  After creating the table, we imported the csv file of our clean_api_data using the management tool. From the 58,099 movies we extracted from Kaggle when we began the ETL process, 10,774 movies made the cut into the database with clean API data. From there we were able to conduct a handful of SQL queries that may provide interesting points for further analysis in future projects:

  ```SQL
  -- Query title, box_office, country from only US showing movies and sort by descending order of box_office
SELECT title, box_office, country 
FROM movies 
WHERE country = 'United States' 
ORDER BY box_office DESC; -- 5654 movies with only US showings with Star Wars VII the highest domestic box_office number

-- Query the Top 10 movies by imdb_rating and box_office shown in the US 
SELECT title, box_office, metascore, imdb_rating 
FROM movies 
WHERE country LIKE '%United States%' 
ORDER BY imdb_rating DESC, box_office DESC 
LIMIT 10; -- The Shawshank Redemption is the top rated movie in our database by imdb_rating, yet it does not have the highest box_office number

-- Query the Top 10 movies by metascore and box_office shown in the US 
SELECT title, box_office, metascore, imdb_rating 
FROM movies 
WHERE country LIKE '%United States%' 
ORDER BY metascore DESC, box_office DESC 
LIMIT 10; -- Casablanca is the top rated movie in our database by metascore, with the highest box_office number of the max metascore

-- Query the best performing year on average in our database
SELECT year, ROUND(AVG(box_office), 2) AS "AverageBoxOffice" 
FROM movies 
GROUP BY year 
ORDER BY "AverageBoxOffice" DESC; -- 2019 seems to be the best performing year on average of all movies in our database

-- Query the worst performing year on average in our database
SELECT year, ROUND(AVG(box_office), 2) AS "AverageBoxOffice" 
FROM movies 
GROUP BY year 
ORDER BY "AverageBoxOffice" ASC; -- 1945 seems to be the worst performing year on average of all movies in our database

-- Query the best performing movie rating on average in our database
SELECT rated, ROUND(AVG(box_office), 2) AS "AverageBoxOffice" 
FROM movies 
GROUP BY rated 
ORDER BY "AverageBoxOffice" DESC; -- G rating seems to be the highest grossing rating category on average
  ```

 

 
