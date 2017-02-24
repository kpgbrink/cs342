-- This command file loads an experimental person relation.
-- The data conforms to the following assumptions:
--     * Person IDs and team names are unique for people and teams respectively.
--     * People can have at most one mentor.
--     * People can be on many teams, but only have one role per team.
--     * Teams meet at only one time.
--
-- CS 342
-- Spring, 2017
-- kvlinden

drop table AltPerson;

CREATE TABLE AltPerson (
	personId integer,
	name varchar(10),
	status char(1),
	mentorId integer,
	mentorName varchar(10),
	mentorStatus char(1),
    teamName varchar(10),
    teamRole varchar(10),
    teamTime varchar(10)
	);

INSERT INTO AltPerson VALUES (0, 'Ramez', 'v', 1, 'Shamkant', 'm', 'elders', 'trainee', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'elders', 'chair', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'executive', 'protem', 'Wednesday');
INSERT INTO AltPerson VALUES (2, 'Jennifer', 'v', 3, 'Jeff', 'm', 'deacons', 'treasurer', 'Tuesday');
INSERT INTO AltPerson VALUES (3, 'Jeff', 'm', NULL, NULL, NULL, 'deacons', 'chair', 'Tuesday');



-- 4.1

-- a. Explain, informally, why the relation is not well-designed and then prove your point formally.

--    Informally: Wow there are too many NULLs and things can be seperated. So much repetition, I can't stand it. The id is repeated, and that is ugly and wrong.

--    Formally: This does not satisfy Boyce-Codd normal form because things that are non-trivial functional dependencies are not seperated. 
--              Things like mentorName depend on the mentorId, so that means it needs to be seperated to satisfy BCNF.


-- b. If mentor and team are seperated into different tables this database could satisfy BCNF and be much easier to use. Every person would have a mentorId but 
--    they would not need a mentorName also because the mentorId will point to a person who has a name. Also the teamName would not be repeated because
--    it would be in its own table and each person could have a connection to the team.


