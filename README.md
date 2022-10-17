# Project 2 - Team 3 - Movies Database
## Team Members: 
Dejan Savic, Jenish Rana, Carolyn Johnson, Mai Dang 

## Proposal:

We would like to create a database of movies to be able to determine whether there are factors that affect a movie’s box office numbers. To complete this analysis, we will use the ETL process to utilize two different datasets from the following sources:</br>

    https://www.kaggle.com/datasets/whenamancodes/popular-movies-datasets-58000-movies?resource=download

    https://www.omdbapi.com/

The Kaggle dataset includes a list of 58,099 movies with their Titles and Genres in one csv. The other 5 csvs all contain unique IDs for us to be able to merge them to bring in other information such as IMDb Tags, Ratings, Category Tags, etc. Using the Kaggle dataset, we will use the IMDb tags to request API information on Box Office numbers as well as other various information for each movie in the dataset.</br>

Once we have cleaned, merged, and identified the variables we are looking for, we will use a relational database in the form of SQLAlchemy to store all our information in relevant tables. We chose a relational database because our data comes with unique identifiers that are able to identify the pre-established relationships that already exist within the dataset.</br>

# Report

## √ Extract: 
 For our project, we searched for datasets of movies in relation to year of release, country, language, box office numbers, genres, IMDb rating, movie rating, and runtime. Specifically, our data consists of a Kaggle dataset that contained 6 csv's with the main dataset containing Titles and Genres of 58,099 different box office movies. We then used the other csv's within the Kaggle dataset that contained various factors like ratings and IMDb tags to request the necessary information such as Runtime and Box Office from our API source.</br>

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
  For the extraction of our API data, we utilized the Requests module to perform a for loop with calls for each IMDb id in our Kaggle dataset. We then appended each response to empty lists to store in a dataframe and transform for database upload. We spent some time fixing the errors in the dataset and transforming the data. However, we ultimately were able to clean the dataset, continue our analysis and load the data into Postgres.</br>

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
  During our transforming stage of cleaning, joining, filtering, and aggregating our csv datasets, we had a few steps to undertake. Our first steps in cleaning up the datasets involved figuring out which variables were not relevant. Pandas was used as the main tool in our Jupyter Notebook to load all three CSV files. Next was the filtering the files and joining them together into data frames. Removed the // column due to missing information which was not relevant to the focus of this study. The team identified nulls by performing an inner merge on the // columns across all datasets. One of our last steps were to create queries to provide evidence to that supports or dethrones the hypothesis by grouping the data by //.</br>
    
## √ Load: 
  The last step was to transfer our final output into a Database. We created a database using .csv file within the Kaggle dataset, API’s, and respective table to match the columns from the final Panda's Data Frame using Postgres database using PG admin to store our original clean data sets. We reconnected to the database and generated additional tables for the data frames.

 
