--Implement the following SQL queries on the IMDBLarge, optimize them using physical database and SQL tuning.

-- 1. Get the movies directed by Clint Eastwood.
select m.*
from Movie m
join MovieDirector md on m.id = md.movieId
join Director d on d.id = md.directorId
and d.firstName = 'Clint' and d.lastName = 'Eastwood';
-- I could have used a subselect but joining is faster.

-- 2. Get the number of movies directed by each director who’s directed more than 200 movies.
SELECT d.*, COUNT(1) AS numMovies
	from Director d
    join MovieDirector md on d.id = md.directorId
	having count(*) > 200
	group by d.id, d.firstName, d.lastName
	order by count(*) asc;
-- I could have joined using select instead of joins. The performance is the same.

-- 3. Get the most popular actors, where actors are designated
--  as popular if their movies have an average rank greater than 8.5 with a movie count of at least 10 movies.

select a.id, a.firstName, a.lastName, trunc(avg(m.rank), 1) as average_rank, count(*) as number_movies
from Actor a
join Role r on r.actorId = a.id
join Movie m on m.id = r.movieId
having avg(m.rank) > 8.5 and count(*) >= 10
group by a.id, a.firstName, a.lastName
order by avg(m.rank) asc;

-- I could have used a sub select instead but group by is faster.
