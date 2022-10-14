# Project2_Team3
## Team Members: 
Dejan Savic, Jenish Rana, Carolyn Johnson, Mai Dang 

## Proposal:

We would like to analyze a dataset of movies to determine whether there are factors that affect a movie’s box office numbers. To complete this analysis, we will use the ETL process to utilize two different datasets from the following sources:</br>

https://www.kaggle.com/datasets/whenamancodes/popular-movies-datasets-58000-movies?resource=download

https://www.omdbapi.com/

The Kaggle dataset includes a list of 58,099 movies with their Titles and Genres in one csv. The other 5 csvs all contain unique IDs for us to be able to merge them to bring in other information such as IMDb Tags, Ratings, Category Tags, etc. Using the Kaggle dataset, we will use the IMDb tags to request API information on Runtime and Box Office numbers for each movie in the dataset.

Once we have cleaned, merged, and identified the variables we are looking for, we will use a relational database in the form of SQLAlchemy to store all our information in relevant tables.
