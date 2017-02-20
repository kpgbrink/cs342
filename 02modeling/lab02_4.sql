-- This command file loads a simple movies database, dropping any existing tables
-- with the same names, rebuilding the schema and loading the data fresh.
--
-- CS 342, Spring, 2015
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
	PRIMARY KEY (id),
	CHECK (year > 1900)
	);

CREATE TABLE Performer (
	id integer,
	name varchar(35),
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
CREATE SEQUENCE movie_seq
START WITH 1
INCREMENT BY 1;

INSERT INTO Movie VALUES (movie_seq.nextval, 'Star Wars',1977,8.9);
INSERT INTO Movie VALUES (movie_seq.nextval, 'Blade Runner',1982,8.6);

CREATE SEQUENCE performer_seq
START WITH 1
INCREMENT BY 1;

INSERT INTO Performer VALUES (performer_seq.nextval,'Harrison Ford');
INSERT INTO Performer VALUES (performer_seq.nextval,'Rutger Hauer');
INSERT INTO Performer VALUES (performer_seq.nextval,'The Mighty Chewbacca');
INSERT INTO Performer VALUES (performer_seq.nextval,'Rachael');

INSERT INTO Casting VALUES (1,1,'star');
INSERT INTO Casting VALUES (1,3,'extra');
INSERT INTO Casting VALUES (2,1,'star');
INSERT INTO Casting VALUES (2,2,'costar');
INSERT INTO Casting VALUES (2,4,'costar');

-- a. Would you need an additional sequence for the performer relation primary key values?
--    Why or why not?

--    You do not need an additional sequence for the different tables but it is nice
--    to use a different one. You can use the same one because they would still be unique
--    keys. But it makes more sense to use different ones for the sake of understandibility.

-- b. Do you see any problems with using sequences in a DDL command file to construct the
--    full movies database?

--    If I reran this code it could make duplicate data because the sequence is not reseting.
--    also in the Casting table there are hard coded inserts that assume there are other variables
--    with those ids.