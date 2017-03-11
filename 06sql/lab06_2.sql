-- a. 
select AVG(TRUNC(MONTHS_BETWEEN(SYSDATE, p.birthdate)/12)) AVERAGE_AGE
from Person p;

-- b.
select *
from (
	select p.householdID, count(*) Count
	from Person p
	group by p.householdID) c
where c.Count >= 2
order by c.Count desc;


-- c.
select c.*, hh.phoneNumber
	from (
	select p.householdID, count(*) Count
	from Person p
	group by p.householdID) c
join HouseHold hh on c.householdID = hh.id
where c.Count >= 2
order by c.Count desc;