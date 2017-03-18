-- Kristofer Brink

@load

-- create new view
create view birthday_Czar as
select firstName, lastName, birthdate, trunc(months_between(sysdate, birthdate)/12) as age
from Person;


-- a) Retrieve the GenX people from the database (i.e., those born from 1961–1975).
select *
from birthday_Czar
where birthdate between '01-JAN-1961' and '31-DEC-1975';


-- b) Update the Person base table to include a GenX birthdate for 
-- some person who had a NULL birthdate before. Now, try to re-run your query
-- on the view from the previous question. Do the results of the view query change? 
-- Why or why not?
update birthday_Czar 
set birthdate='01-JAN-1961'
where birthdate is null;

select *
from birthday_Czar
where birthdate between '01-JAN-1961' and '31-DEC-1975';
-- Yes the query changes. From 3 rows to 9 rows. 6 were updated.


-- c) Insert a new person using your new view. If this doesn’t work,
--  explain (but do not implement) the modifications you’d have to make to your 
-- view so that it does. Be sure that you understand what is required for a view to 
-- be updateable and what happens to the fields of the new record in the base table that
--  are not included in the view.
insert into birthday_Czar (firstName, lastName, birthdate)
values ('Kristofer', 'Brink', '01-JAN-1961');
-- Age is computed in the created view. Age needs to be in the original table for
-- it to be possible to add it. 

-- Drop your new view. Does this affect your base tables in any way?
drop view birthday_Czar;
-- This does not affect the base table.


