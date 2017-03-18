-- Kristofer Brink

-- a. The IDs and full names of managers and the number of employees each of them manages. 
--    Order the results by decreasing number of employees and return only the top ten results.
select * from
	(select m.employee_id as ManagerID, m.first_name || ' '|| m.last_name as Manager_full_name, count(e.employee_id) as Number_of_employees
        from Employees m
		join Employees e on m.employee_id = e.manager_id
		group by m.employee_id, m.first_name, m.last_name
		order by count(e.employee_id) desc)
	where rownum <= 10;

-- b. The name, number of employees and total salary for each department outside of the US with
--    less than 100 employees. The total salary is the sum of the salaries of each of the
--    department's employees.
select * from
    (select d.department_name, count(e.employee_id) as NumberOfEmployees, sum(e.salary) as Sum_of_salary 
        from Departments d
        join Employees e on d.department_id = e.department_id
        join Locations l on d.location_id = l.location_id
        where l.country_id <> 'US'
        group by d.department_name)
    where NumberOfEmployees < 100;


-- c. The department name, department manager name and manager job title for all departments. 
--    If the department has no manager, include it in the output with NULL values for the manager 
--    and title.
select d.department_name, e.first_name || ' ' || e.last_name as Manager, j.job_title from Departments d 
	left outer join Employees e on d.department_id = e.department_id
	join Jobs j on j.job_id = e.job_id;

-- d. The name of each department along with the average salary of the employees of that 
--    department. If a department has no employees, include it in the list with no salary value.
--    Order your results by decreasing salary. You may order the NULL-valued salaries however you’d
--    like.
select d.department_name, trunc(avg(e.salary)) as Average_salary from Departments d
	left outer join Employees e on d.department_id = e.department_id
	group by d.department_name
	order by Average_salary desc NULLS last;