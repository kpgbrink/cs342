
@lab05_load

-- a. Get the youngest person in the database. Write this both as a sub-select and 
-- as a ROWNUM query (see the notes below). Consider implementing your sub-select 
-- without using aggregate functions (e.g., MAX()).

SELECT *
FROM (SELECT * FROM Person p ORDER BY p.birthdate DESC)
WHERE ROWNUM = 1;

-- b. Get the IDs and full names of people who share the same first name. What happens
--  when there are three or more people who share the same name?

SELECT p.id, p.firstName, p.lastName
FROM Person p
JOIN Person m on p.firstName = m.firstName and p.id <> m.id;
-- When there are more than three people the query shows each person that has someone with the same
-- first name multiple times.


-- c. Get the names of all people who are on the music team but not in Byl’s home group. Write this both 
-- as a sub-select and as a set operations query.

-- sub select
SELECT p.firstName, p.lastName
From Person p
Join PersonTeam pt on p.id = pt.personId
Where pt.teamName = 'Music'
and p.id not in (
    select p.id
    From Person p
    Join HomeGroup hg on p.homeGroupID = hg.id
    Where hg.name = 'Byl'
);

-- correlated subquery
SELECT p.firstName, p.lastName
From Person p
Join PersonTeam pt on p.id = pt.personId
Where pt.teamName = 'Music'
MINUS
SELECT p.firstName, p.lastName
From Person p
Join HomeGroup hg on p.homeGroupID = hg.id
Where hg.name = 'Byl';


