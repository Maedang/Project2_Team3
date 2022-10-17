# Project2_Team3
## Team Members: 
Dejan Savic, Jenish Rana, Carolyn Johnson, Mai Dang 

## Proposal:

We would like to analyze a dataset of movies to determine whether there are factors that affect a movie’s box office numbers. To complete this analysis, we will use the ETL process to utilize two different datasets from the following sources:</br>

    https://www.kaggle.com/datasets/whenamancodes/popular-movies-datasets-58000-movies?resource=download

    https://www.omdbapi.com/

The Kaggle dataset includes a list of 58,099 movies with their Titles and Genres in one csv. The other 5 csvs all contain unique IDs for us to be able to merge them to bring in other information such as IMDb Tags, Ratings, Category Tags, etc. Using the Kaggle dataset, we will use the IMDb tags to request API information on Runtime and Box Office numbers for each movie in the dataset.

Once we have cleaned, merged, and identified the variables we are looking for, we will use a relational database in the form of SQLAlchemy to store all our information in relevant tables.

# Report

## √ Extract: 
   For our project, we searched for datasets of movies in relation to box office numbers, genres, and runtime. Specifically, our data consists of a Kaggle  dataset that contained 6 csv's with the main dataset containing Titles and Genres of 58,099 different box office movies. We then used the other csv's within the Kaggle dataset that contained various factors like ratings and IMDb tags to request API's and access resource certain information like Runtime and Box Office numbers. The data was inputted into Juypter Notebook and ran into some errors. We spent some time fixing the errors in the dataset and transforming the data. However, we ultimately were able to clean the dataset, continue our analysis and load the data into Postgres.

## √ Transform: 
    During our transforming stage of cleaning, joining, filtering, and aggregating our csv datasets, we had a few steps to undertake. Our first steps in cleaning up the datasets involved figuring out which variables were not relevant. Pandas was used as the main function in our Jupyter Notebook to load all three CSV files. Next was the filtering the files and joining them together into data frames. Removed the     column due to missing information which was not relevant to the focus of this study. The team identified nulls by performing an inner merge on the     columns across all datasets. One of our last steps were to create queries to provide evidence to that supports or dethrones the hypothesis by grouping the data by    . 
    
## √ Load: 
