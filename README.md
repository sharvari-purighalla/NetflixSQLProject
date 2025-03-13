# NetflixSQLProject
This project explores the Netflix dataset using SQL queries to extract insights about the platform's content, such as trends in movie releases, TV show distribution, genre popularity, and more. The dataset contains 8,807 records and includes information like title, director, cast, country, release year, duration, genre, and description. 

[link to dataset: https://www.kaggle.com/datasets/shivamb/netflix-shows]

## Guiding questions:

- PROBLEM 1: count the number of movies vs tv shows
- PROBLEM 2: find the most common rating for movies and tv shows
- PROBLEM 3: list all movies released in 2020
- PROBLEM 4: find the top 5 countries with the most content on netflix
- PROBLEM 5: identify the longest movie duration
- PROBLEM 6: find all content added in the last 5 years
- PROBLEM 7: find all movies/tv shows by director 'Rajiv Chilaka'
- PROBLEM 8: list all tv shows with more than 5 seasons
- PROBLEM 9: count the number of content items in each genre
- PROBLEM 10: find average amount of content released by India on netflix. return the top 5 years with highest average content released
- PROBLEM 11: list all movies that are documentaries
- PROBLEM 12: find all content without a director
- PROBLEM 13: find how many movies the actor 'Salman Khan' appeared in the last 10 years
- PROBLEM 14: find the top 10 actors who appeared in the highest number of movies produced in india
- PROBLEM 15: categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field. label content containing these keywords as 'bad' and all other content as 'good'. count how many items fall into each category

### Key takeaways
- Netflix has more Movies than TV Shows (6,131 vs. 2,676).
- TV-MA is the most common rating with 2,062 Movies and 1,145 TV Shows falling under this category.
- The United States, India, UK, Canada, and France produce the most content on Netflix.
- 517 Movies were released in 2020, showcasing an increase in new content during that year.
- The longest movie duration on Netflix is 99 minutes.
- Around 3,006 new content pieces have been added in the last five years.
- 22 Movies and TV Shows were directed by Rajiv Chilaka.
- 82 TV Shows have five or more seasons.
- There are 42 different genres on Netflix.
- India released the highest average content in 2018, contributing 35.91% of its total content.
- There are 869 Movies classified as Documentaries.
- 2,634 Movies and TV Shows have no director listed.
- Salman Khan appeared in 2 Movies on Netflix in the last 10 years.
- Anupam Kher, Shah Rukh Khan, Naseeruddin Shah, and Om Puri are among the top 10 actors in Indian Netflix movies.
- 8398 pieces of content are categorized as 'Good,' while 409 are classified as 'Bad' based on keywords in descriptions.

### Technologies used
- **SQL (PostgreSQL)** for querying and data manipulation
- **pgAdmin** for database management
- **Google Sheets** for gaining an estimate of number of records per category and identifying data types.

CREATE table netflix
(
  show_id varchar(6), 
  type varchar(20), 
  title varchar(150), 
  director varchar(220), 
  casts varchar(1000), 
  country varchar(150), 
  date_added varchar(50), 
  release_year int, 
	rating varchar(10), 
  duration varchar(15), 
  listed_in varchar(100), 
  description varchar(250)
);

### Future improvements
- Visualizing content trends using Python, Matplotlib, or Tableau.
- Performing predictive modeling on content release patterns.
- Analyzing Netflix’s content trends compared to competitors (Amazon Prime, Disney+).


This project was created by **Sharvari Purighalla**. You may connect with me on linkedin @sharvari-purighalla for discussions, collaborations, or improvements!
Date: 03/11/2025
