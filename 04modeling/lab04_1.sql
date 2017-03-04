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

--    Informally: There are too many NULLs and things can be seperated. Too much repetition, and the id is repeated.

--    Formally: This does not satisfy Boyce-Codd normal form because things that are non-trivial functional dependencies are not seperated. 
--              Things like mentorName depend on the mentorId, so that means it needs to be seperated to satisfy BCNF.


-- b. If mentor and team are seperated into different tables this database could satisfy BCNF and be much easier to use. Every person would have a mentorId but 
--    they would not need a mentorName also because the mentorId will point to a person who has a name. Also the teamName would not be repeated because
--    it would be in its own table and each person could have a connection to the team.

-- Homework 4

drop table PersonTeam;
drop table Team;
drop table Person;

-- i.

-- Person(ID, name, status, mentorId) 
CREATE TABLE Person (
    id integer not null primary key,
    name varchar(10),
    mentorId integer
);

-- Team(NAME, time) 
CREATE TABLE Team(
    name varchar(10) not null primary key, 
    time varchar(10)
);
-- PersonTeam(PERSON_ID, TEAM_NAME, role)
CREATE TABLE PersonTeam(
    personId integer,
    teamName varchar(10), 
    role varchar(10),
    foreign key (personId) references Person(id),
    foreign key (teamName) references Team(name)
);

-- ii

INSERT INTO Person 
    select distinct personId, name, mentorId
    from AltPerson;

INSERT INTO Team
    select distinct teamName, teamTime
    from AltPerson;
    
INSERT INTO PersonTeam
    select distinct personId, teamName, teamRole
    from AltPerson;

-- iii.
    
select * from Person;

select * from Team;

select * from PersonTeam;

-- d.

select 
    p.id personId, 
    p.name name,
    case when p.mentorId is NULL then 'm' else 'v' end status,
	p.mentorId mentorId,
	m.name mentorName,
    case when m.mentorId is NULL then 'm' else 'v' end mentorStatus,
    t.name teamName,
    pt.role teamRole,
    t.time teamTime
from Person p
join PersonTeam pt on p.id = pt.personId
join Team t on pt.teamName = t.name
left join Person m on p.mentorId = m.id
order by p.id;






