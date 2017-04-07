-- This script retrieves the indexes created on the current system.
-- Refer to an index using the index_name.
-- The "normal" index type is a B-tree; OracleXE 11g doesn't support bitmapped indexes.

SET AUTOTRACE ON; 
SET SERVEROUTPUT ON;
SET TIMING ON;


-- Kristofer Brink
-- lab09


-- Exercise 9.1

-- Build sample queries to test that:

-- a. there is a benefit to using either COUNT(1), COUNT(*) or SUM(1) 
--    for simple counting queries."

declare
	counter integer;
BEGIN
	FOR i IN 1..1000 LOOP
		select count(1) into counter
		from Movie;
	END LOOP;
END;
/
-- Elapsed: 00:00:05.43

declare
	counter integer;
BEGIN
	FOR i IN 1..1000 LOOP
		select count(*) into counter
		from Movie;
	END LOOP;
END;
/
-- Elapsed: 000:00:05:42

declare
	counter integer;
BEGIN
	FOR i IN 1..1000 LOOP
		select sum(1) into counter
		from Movie;
	END LOOP;
END;
/
-- 00:00:11.18


-- b. the order of the tables in the FROM clause affects the 
--    way Oracle executes a join query.


select count(*)
from actor a
join role r on a.id = r.actorId;

select count(*)
from role r 
join actor a on r.actorId = a.id;


-- The order of the join does not affect the way Oracle executes a join query.


-- c. the use of arithmetic expressions in join conditions 
-- (e.g., FROM Table1 JOIN Table2 ON Table1.id+0=Table2.id+0 ) 
-- affects a query’s efficiency.
declare
	counter integer;
BEGIN
	FOR i IN 1..10 LOOP
		select count(*) INTO counter
		from actor a
		join role r on a.id = r.actorId;
    END LOOP;
END;
/
--  00:00:00.55
declare
	counter integer;
BEGIN
	FOR i IN 1..10 LOOP
		select count(*) INTO counter
		from actor a
		join role r on a.id+0 = r.actorId+0;
    END LOOP;
END;
/
-- 00:00:05.90

-- Use of arithmetic slows the join down a lot.

-- d. running the same query more than once affects its performance.

select count(*)
from actor a
join role r on a.id = r.actorId
join movie m on r.movieId = m.id;

select count(*)
from actor a
join role r on a.id = r.actorId
join movie m on r.movieId = m.id;

-- Running query more than once does not change performance.



-- e. adding a concatenated index on a join table improves performance 
--    (see the create index command described above).

-- not concatenated index
select count(*) 
from Role r1 
join Role r2 on r1.actorId = r2.movieId;

-- concatenated index
create index role Index on Role(movieId, actorId);
select count(*) from Role r1 join Role r2 on 
r1.actorId = r2.movieId;

-- DOES NOT WORK. RUNS OUT OF MEMORY. 









