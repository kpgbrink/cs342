
-- Exercise 6.1

-- a.Get the names and mandate statements of all teams along with the ID of 
--   their “chair” member. If a chair member does not exist, include NULL 
--   for the ID.
select t.name, t.mandate, pt.personId
from Team t
left outer join PersonTeam pt on t.name = pt.teamName and pt.role = 'chair';

-- b. [Optional] If you’re looking for a challenge, modify the previous query
--     to return the chair person’s full name instead of just their ID.

select t.name, t.mandate, case when p.id is not null then p.firstname || ' ' || p.lastName end FullName
from Team t
left outer join PersonTeam pt on t.name = pt.teamName and pt.role = 'chair'
left join Person p on pt.personId = p.id;