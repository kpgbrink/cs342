-- Kristofer Brink


---------------------------------------------------------------------------
-- 1.Create a view of all employees and their department; include the employee ID, name, 
--   email, hire date and department name. Then write SQL commands to do the following:
create or replace view employeeView as
select e.employee_id, e.first_name, e.last_name, e.email, e.hire_date, d.department_name
from EMPLOYEES e, DEPARTMENTS d
where e.department_id = d.department_id;

-- a) Get the name and ID of the newest employee in the “Executive” department.
select first_name, last_name, employee_id, max(hire_date) as newest
from employeeView
where ROWNUM = 1
group by first_name, last_name, employee_id;

-- b) Change the name of the “Administration” department to “Bean Counting”.
update employeeView set department_name = 'Bean counting'
where department_name = 'Administration';
-- This does not work because department was joined to employee.
-- "cannot modify a column which maps to a non key-preserved table"

-- c) Change the name of “Jose Manuel” to just “Manuel”
update employeeView set first_name = NULL
where first_name ='Jose' and last_name='Manuel';
-- nothing updates.

-- d) Insert a new employee in the “Payroll” department (make up appropriate data for this record).
insert into employeeView (first_name, last_name, email, hire_date, department_name)
values ('Bobby', 'Bob', 'bob@gmail.com', '03-JUN-23', 'Payroll');
-- This does not work because department was joined to employee.
-- Error message "cannot modify more than one base table through a join view"


---------------------------------------------------------------------------
-- 2. Redo the previous exercise with a materialized view.

-- create view
create MATERIALIZED view employeeMaterializedView as
select e.employee_id, e.first_name, e.last_name, e.email, e.hire_date, d.department_name
from EMPLOYEES e, DEPARTMENTS d
where e.department_id = d.department_id;

-- a) Get the name and ID of the newest employee in the “Executive” department.
select first_name, last_name, employee_id, max(hire_date) as newest
from employeeMaterializedView
where ROWNUM = 1
group by first_name, last_name, employee_id;

-- b) Change the name of the “Administration” department to “Bean Counting”.
update employeeMaterializedView set department_name = 'Bean counting'
where department_name = 'Administration';
-- cannot update data in a materialized view

-- c) Change the name of “Jose Manuel” to just “Manuel”
update employeeMaterializedView set first_name = NULL
where first_name = 'Jose' and last_name = 'Manuel';
-- cannot update data in a materialized view

-- d) Insert a new employee in the “Payroll” department (make up appropriate data for this record).
insert into employeeMaterializedView (first_name, last_name, email, hire_date, department_name)
values ('Bobby', 'Bob', 'bob@gmail.com', '03-JUN-23', 'Payroll');
-- cannot update data in a materialized view

drop materialized view employeeMaterializedView;

----------------------------------------------------------------------------
-- 3. Write the following queries as specified:

-- a) The query on which your view from exercise 1 is based - Write this query using both 
--    the relational algebra and tuple relational calculus, with respect to the original HR relations.

-- algebra
-- PI_firstName, lastName, employee_id, email, hire_date, department_name (theta Employee(department_id) = Department(department_id D)))

-- calculus
-- {e.employee_id, e.first_name, e.last_name, e.email, e.hire_date, d.department_name | Employee(e), Department(d) ^ e.department_id = d.department_id}


-- b) The query from exercise 1.a - Write this query using (only) the relational calculus, with respect to DeptView.

-- {first_name, last_name, employee_id |  employeeView ^ rowNum = 1}


