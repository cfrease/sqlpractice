--https://cs50.harvard.edu/x/2020/psets/7/movies/

--write a SQL query to list the titles of all movies released in 2008.
SELECT title
FROM movies
WHERE year == 2008

--write a SQL query to determine the birth year of Emma Stone.
SELECT birth
FROM people
WHERE name = 'Emma Stone'

--write a SQL query to list the titles of all movies with a release date on or after 2018, in alphabetical order.
SELECT title
FROM movies
WHERE year>= 2018
ORDER BY title

--write a SQL query to determine the number of movies with an IMDb rating of 10.0.
SELECT COUNT(movie_id)
FROM ratings
WHERE rating =10.0

--write a SQL query to list the titles and release years of all Harry Potter movies, in chronological order.
SELECT title, year
FROM movies
WHERE title LIKE 'Harry Potter%'

--write a SQL query to determine the average rating of all movies released in 2012.
SELECT AVG(r.rating) AS mov_avg
FROM ratings AS r
JOIN movies AS m
ON r.movie_id = m.id
WHERE year = 2012

--write a SQL query to list all movies released in 2010 and their ratings, in descending order by rating. For movies with the same rating, order them alphabetically by title.
SELECT m.title, r.rating
FROM ratings AS r
JOIN movies AS m
ON r.movie_id = m.id
WHERE m.year = 2010
ORDER BY r.rating DESC, m.title

--write a SQL query to list the names of all people who starred in Toy Story.
SELECT p.name
FROM movies AS m
JOIN stars AS s
ON m.id = s.movie_id
JOIN people AS p
ON s.person_id = p.id
WHERE m.title = 'Toy Story'

SELECT name
FROM people
WHERE id IN (SELECT person_id
FROM stars
WHERE movie_id IN (SELECT id
FROM movies
WHERE title ='Toy Story'))

--write a SQL query to list the names of all people who starred in a movie released in 2004, ordered by birth year.
SELECT p.name
FROM people AS p
JOIN stars AS s
ON p.id = s.person_id
JOIN movies AS m
ON m.id = s.movie_id
WHERE m.year =2004
GROUP BY p.id
ORDER BY p.birth

SELECT name
FROM people
WHERE id IN (SELECT DISTINCT(person_id)
FROM stars
WHERE movie_id IN (SELECT id
FROM movies
WHERE year = 2004))
ORDER BY birth

--write a SQL query to list the names of all people who have directed a movie that received a rating of at least 9.0.
SELECT DISTINCT(p.name)
FROM people AS p
JOIN directors AS d
ON p.id = d.person_id
JOIN ratings AS r
ON d.movie_id = r.movie_id
WHERE r.rating >= 9

SELECT DISTINCT(name)
FROM people
WHERE  id IN (SELECT person_id
FROM directors
WHERE movie_id IN (SELECT movie_id
FROM ratings
WHERE rating >=9))

--write a SQL query to list the titles of the five highest rated movies (in order) that Chadwick Boseman starred in, starting with the highest rated.
SELECT m.title
FROM movies AS m
JOIN stars AS s
ON m.id = s.movie_id
JOIN people AS p
ON s.person_id = p.id
JOIN ratings AS r
ON m.id = r.movie_id
WHERE p.name = 'Chadwick Boseman'
ORDER BY rating DESC
LIMIT 5

SELECT title
FROM movies
WHERE id IN (SELECT movie_id
FROM ratings
WHERE movie_id IN (SELECT movie_id
FROM stars
WHERE person_id IN (SELECT id
FROM people
WHERE name =  'Chadwick Boseman'))
ORDER BY rating DESC)
LIMIT 5 

--write a SQL query to list the titles of all movies in which both Johnny Depp and Helena Bonham Carter starred.
SELECT m.title
FROM movies AS m
JOIN stars AS s
ON s.movie_id = m.id
JOIN people AS p
ON s.person_id = p.id
WHERE p.name = 'Johnny Depp' 
INTERSECT
SELECT m.title
FROM movies AS m
JOIN stars AS s
ON s.movie_id = m.id
JOIN people AS p
ON s.person_id = p.id
WHERE p.name = 'Helena Bonham Carter' 

SELECT m.title
FROM movies AS m
JOIN stars AS s
ON s.movie_id = m.id
JOIN people AS p
ON s.person_id = p.id
WHERE p.name = 'Johnny Depp'  AND m.id IN (SELECT m.id
FROM movies AS m
JOIN stars AS s
ON s.movie_id = m.id
JOIN people AS p
ON s.person_id = p.id
WHERE p.name = 'Helena Bonham Carter' )

SELECT m.title
FROM movies AS m
JOIN stars AS s
ON m.id = s.movie_id
JOIN people AS p
ON s.person_id = p.id
WHERE p.name IN ('Johnny Depp' , 'Helena Bonham Carter')
GROUP BY m.title
HAVING COUNT(m.title) > 1


--write a SQL query to list the names of all people who starred in a movie in which Kevin Bacon also starred
SELECT DISTINCT(p.name)
FROM people AS p
JOIN stars AS s
ON p.id = s.person_id
WHERE s.movie_id IN (SELECT m.id
FROM movies AS m
JOIN stars AS s
ON m.id =s.movie_id
JOIN people AS p
ON s.person_id = p.id
WHERE p.name = 'Kevin Bacon' AND p.birth = 1958) AND p.name != 'Kevin Bacon' 