-- Sample version of the Movies database for guide 5
--
-- CS 342, Spring, 2017
-- kvlinden

-- Drop current database
DROP TABLE Casting;
DROP TABLE Movie;
DROP TABLE Performer;

-- Create database schema
CREATE TABLE Movie (
	id integer,
	title varchar(70) NOT NULL,
	year decimal(4),
	score float,
	votes integer,
	PRIMARY KEY (id),
	CHECK (year > 1900)
	);

CREATE TABLE Performer (
	id integer,
	firstName varchar(20),
	lastName varchar(25),
	PRIMARY KEY (id)
	);

CREATE TABLE Casting (
	movieId integer,
	performerId integer,
	status varchar(6),
	FOREIGN KEY (movieId) REFERENCES Movie(Id) ON DELETE CASCADE,
	FOREIGN KEY (performerId) REFERENCES Performer(Id) ON DELETE SET NULL,
	CHECK (status in ('star', 'costar', 'extra'))
	);

-- Load sample data
INSERT INTO Movie VALUES (1,'Star Wars',1977,8.9, 2000);
INSERT INTO Movie VALUES (2,'Blade Runner',1982,8.6, 1500);

INSERT INTO Performer VALUES (1,'Harrison', 'Ford');
INSERT INTO Performer VALUES (2,'Rutger', 'Hauer');
INSERT INTO Performer VALUES (3,'Chewbacca', NULL);
INSERT INTO Performer VALUES (4,'Rachael', NULL);
INSERT INTO Performer VALUES (5,'Rex', 'Harrison');

INSERT INTO Casting VALUES (1,1,'star');
INSERT INTO Casting VALUES (1,3,'extra');
INSERT INTO Casting VALUES (2,1,'star');
INSERT INTO Casting VALUES (2,2,'costar');
INSERT INTO Casting VALUES (2,4,'costar');


-- 1.1. Use one or more tuple variables (Section 6.3.2).
select C.status, P.firstName
from Casting C, Performer P
where C.performerId = 1;


-- 1.2. Use one or more of the set operations, e.g., UNION, EXCEPT, INTERSECT.
select C.movieId from Casting C
UNION ALL 
select P.id from Performer P
UNION
select M.id from Movie M;


-- 2.1 Select based on a NULL field value
select * 
from Performer P
where P.lastName is NULL;

-- 2.2 Implement a nested sub-query, using [NOT] EXISTS, IN, ANY, or ALL
select id, firstName, lastName
from Performer P
where P.id IN (select C.PerformerId
                    from Casting C);

-- 2.3 Implement a correlated sub-query
select id, firstName, lastName,
    (select count(*) 
    from Casting C
    where C.performerId = P.id) MOVIECOUNT
from Performer P;
                    
                    





