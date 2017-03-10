
-- Exercise 6.1

-- a.Get the names and mandate statements of all teams along with the ID of 
--   their “chair” member. If a chair member does not exist, include NULL 
--   for the ID.
select t.name, t.mandate, p.firstname, p.lastName
from Team t
left outer join PersonTeam pt on t.name = pt.teamName and pt.role = 'chair'
left join Person p on pt.personId = p.id;



