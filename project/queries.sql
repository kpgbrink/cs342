

-- 3 major queries

-- a join of at least four tables - done
-- proper comparisons of NULL values - done
-- a self-join using tuple variables - done
-- a combination of inner and outer joins
-- a nested select statement - done
-- aggregate statistics on grouped data - done


-- Get a big dump of information on schedules users have made.
select s.*, sbr.*, pah.*
from Schedule s
join Schedule_SideBarLink ssbr on s.id = ssbr.schedule_id
join SideBarLink sbr on ssbr.sidebarlink_id = sbr.id
join Schedule_PlaceAndHours spah on s.id = spah.schedule_id
join PlaceAndHours pah on spah.placeAndHours_id = pah.id
where sbr.id is not null;

-- Find amount of people in a group by id
select friendGroup_id, count(friendGroup_id)
from FriendGroup_Student
group by friendGroup_id;

-- Get count of all people with an email. For checking percentage of people with email.
select count(*)
from Student s 
where s.email is not Null;

-- Join all people who have the same last name. Good for finding families.
select s.lastName
from Student s, Student st
where s.lastName = st.lastName and s.id <> st.id;

-- Find ids of people with at least one friend. I could have used count and group but this is clearer.
select s.id
from Student s
where s.id in (select sf.student_id
            from StudentFriend sf);
            
-- show all people and their friends if they have any
select s.*, f.*
from Student s
left outer join StudentFriend sf on s.id = sf.student_id
join Student f on sf.student_friend_id = f.id;


-- This is a important link view
-- it gets all unique class links for every class
-- people would use it to see links people use for classes.
create view ImportantLinks as
select cl.* 
from ClassLink cl, ClassLink cls
where cl.link <> cls.link and cl.id <> cls.id;
-- I choose a non-materialized view because I want the links to update quickly. People usually
-- only get things set up at the beginning of the semester and I want people to be able to colaborate quickly

