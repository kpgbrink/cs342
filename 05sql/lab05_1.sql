
@lab05_load
    
-- Exercise 5.1


-- a. Retrieve the cross-product of all person and all household records. How many records
--    to you get and why? As an optional challenge, can you use SQL to compute this number?

select *
from Person p
join HouseHold h on p.householdID = h.id;

-- optional challenge
select count(*)
from Person p
join HouseHold h on p.householdId = h.id;

-- b. Retrieve the people who have birthdays specified in the database, ordered by day-of-year
--    (i.e., Jan 1 birthdays go before Jan 2 birthdays, regardless of the year). Note that you 
--    can compute the day of year value using the Oracle function: TO_CHAR(birthdate, 'DDD').

select *
from Person p
order by TO_CHAR(p.birthdate, 'DDD');


