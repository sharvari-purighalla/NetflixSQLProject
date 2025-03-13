-- Netflix SQL Project
-- Sharvari Purighalla 03/11/2025

DROP TABLE IF EXISTS netflix;

CREATE table netflix
(
	show_id varchar(6), type varchar(20), title varchar(150), director varchar(220), 
	casts varchar(1000), country varchar(150), date_added varchar(50), release_year int, 
	rating varchar(10), duration varchar(15), listed_in varchar(100), description varchar(250)
);
SELECT COUNT(*) as total_content from netflix;
-- total_content is 8807 records

SELECT DISTINCT type FROM netflix;
-- there's Movie and TV Show

SELECT * FROM netflix;


-- PROBLEM 1
-- count the number of movies vs tv shows

SELECT type, COUNT(*) as total_content FROM netflix GROUP BY type;
-- 6131 Movie, 2676 TV Show


-- PROBLEM 2
-- find the most common rating for movies and tv shows

SELECT type, rating FROM 
	(SELECT type, rating, COUNT(*), 
		RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) as ranking
		FROM netflix GROUP BY 1, 2) as t1 
WHERE ranking = 1;
-- 2062 TV-MA ratings for Movie, 1145 TV-MA ratings for TV Show


-- PROBLEM 3
-- list all movies released in 2020

SELECT * FROM netflix WHERE type = 'Movie' AND release_year = 2020;
-- there are 517 movies released in 2020


-- PROBLEM 4
-- find the top 5 countries with the most content on netflix

SELECT TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) as new_country,
	COUNT(show_id) as total_content
FROM netflix GROUP BY 1 
ORDER BY 2 DESC LIMIT 5; 
-- US, India, UK, Canada, France


-- PROBLEM 5
-- identify the longest movie duration

SELECT * FROM netflix WHERE
	type = 'Movie' AND duration = (SELECT MAX(duration) FROM netflix)
-- 99 min is the longest movie duration


-- PROBLEM 6
-- find all content added in the last 5 years

SELECT * FROM netflix WHERE
	TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years'
-- 3006 movies and tv shows added in the last 5 years


-- PROBLEM 7
-- find all movies/tv shows by director 'Rajiv Chilaka'

SELECT * FROM netflix WHERE director ILIKE '%Rajiv Chilaka%' --ILIKE makes it not case sensitive
-- 22 movies directed by Rajiv Chilaka


-- PROBLEM 8
-- list all tv shows with more than 5 seasons

SELECT * FROM netflix WHERE
	type = 'TV Show' AND SPLIT_PART(duration, ' ', 1) >= '5'
-- there are 82 tv shows with 5+ seasons


-- PROBLEM 9
-- count the number of content items in each genre

SELECT 
	TRIM(UNNEST(STRING_TO_ARRAY(listed_in, ','))) as genre,
	COUNT(show_id) as total_content
FROM netflix GROUP BY 1
-- there's 42 different genres


-- PROBLEM 10
-- find average amount of content released by India on netflix. return the top 5 years with highest average content released

SELECT EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) as date, 
	COUNT(*), ROUND((COUNT(*)::numeric)/((SELECT COUNT(*) FROM netflix WHERE country = 'India')::numeric) * 100, 2) as avg_content_per_year
FROM netflix
WHERE country ILIKE '%India%' GROUP BY 1
-- (2018: 349, 35.91%)  (2019: 218, 22.43%)  (2020: 199, 20.47%)  (2017: 162, 16.67%)  (2021: 105, 10.80%) 


-- PROBLEM 11
-- list all movies that are documentaries

SELECT * FROM netflix WHERE listed_in ILIKE '%documentaries%'
-- 869 movies that are documentaries


-- PROBLEM 12
-- find all content without a director

SELECT * FROM netflix where director IS null
-- 2634 movies and tv shows with no directors


-- PROBLEM 13
-- find how many movies the actor 'Salman Khan' appeared in the last 10 years

SELECT * FROM netflix WHERE 
	casts ILIKE '%Salman Khan%' 
	AND release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10
-- 2 movies


-- PROBLEM 14
-- find the top 10 actors who appeared in the highest number of movies produced in india

SELECT
	TRIM(UNNEST(STRING_TO_ARRAY(casts, ','))) as actors,
	COUNT(*) as total_content
FROM netflix WHERE country ILIKE '%India%' GROUP BY 1 ORDER BY 2 DESC LIMIT 10
-- Anupam Kher, Shah Rukh Khan, Naseeruddin Shah, Om Puri, Akshay Kumar, Amitabh Bachchan, Paresh Rawal, Boman Irani, Kareena Kapoor, Ajay Devgn


-- PROBLEM 15
-- categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field. 
-- label content containing these keywords as 'bad' and all other content as 'good'
-- count how many items fall into each category

WITH new_table AS (
SELECT *, CASE 
	WHEN 
		description ILIKE '%kill%' 
		OR description ILIKE '%violen%'
		THEN 'bad_content'
		ELSE 'good_content'
	END category
FROM netflix
)
SELECT category, COUNT(*) as total_content FROM new_table GROUP BY 1
-- 409 'bad' and 8398 'good'