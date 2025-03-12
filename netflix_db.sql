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


