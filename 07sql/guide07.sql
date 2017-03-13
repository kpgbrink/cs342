-- Views (Section 7.3, for Monday)

-- Write a simple view specification. For details on Oracle views, see Managing Views.
-- CREATE VIEW employee AS
-- SELECT empno, ename,
-- FROM employee
-- WHERE depto = 10
-- WITH CHECK OPTION CONSTRAINT sales_staff_cnst;

-- b. Define the following terms (in the comments of your SQL command file).

-- i. Base Tables: physical structure that contains stored records

-- ii. Join Views: view of two or more tables joined together.

-- iii. Updateable Join Views: a join view that can be updated, a denormalized table
--     for updating.

-- iv. Key-Preserved Tables: 1 key value goes to 1 table.

-- Views that are implemented via query modification vs materialization.
-- (For details on Oracle materialization, see Materialized View Concepts 
--  and Architecture, focusing on the “What is a Materialized View?” and 
--  “Why Use Materialized Views” sections.)
-- Materialized view is a replica of a target master from a point in time.
-- this helps ease network loads.
-- Query modification. Instant.