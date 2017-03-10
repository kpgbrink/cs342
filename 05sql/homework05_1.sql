-- Write SQL queries that:

-- a. Get a list of the employees who have finished all of their jobs (i.e., all their 
--    jobs in the job_history table have non-null end_dates).
select distinct e.*
from employees e
where e.employee_id not in (select jh.employee_id
                  from job_history jh 
                  where jh.end_date is null);

                  
                  
-- b. Get a list of employees along with their manager such that the managers have less 
--    seniority at the company and that all the employees’ jobs have been within the 
--    manager’s department.
select e.*, m.*
from employees e
join employees m on e.manager_id = m.employee_id
where
    -- managers less seniority
    (select min(jhe.start_date) 
     from job_history jhe
     where jhe.employee_id = e.employee_id) 
     >
     (select min(jhm.start_date) 
     from job_history jhm
     where jhm.employee_id = m.employee_id)
     and
     e.employee_id not in (select jh.employee_id
                           from job_history jh
                           where jh.employee_id = e.employee_id
                           and jh.department_id <> m.department_id);



-- c. The countries in which at least one department is located. Try to write this 
--     as both a join and a nested query. If you can, explain which is better. If 
--     you can’t, explain which is not possible and why.

-- with join
select distinct c.*
from countries c
join locations l on c.country_id = l.country_id
join departments d on l.location_id = d.location_id; 

-- with subquery
select c.*
from countries c
where c.country_id in (select l.country_id 
                        from locations l
                        where l.location_id in (select d.location_id from departments d));
-- Joins are generally faster than a nested query so the join would be better to use.
-- also for this specific case the joins make more sense to use because there isn't a 
-- special condition that would make more sense with a nested query.
                        
                        
                        