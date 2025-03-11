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

SELECT country, COUNT(show_id) as total_content FROM netflix GROUP BY 1;

SELECT STRING_TO_ARRAY(country, ',') as new_country FROM netflix

SELECT UNNEST(STRING_TO_ARRAY(country, ',')) as new_country,
	COUNT(show_id) as total_content
FROM netflix GROUP BY 1

