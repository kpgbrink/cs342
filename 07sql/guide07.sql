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

-- Formal languages for the relational model (Chapter 8, for Wednesday)

-- a. Relational Algebra (read Sections 8.1–8.3 & 8.5) — Write a simple query on the movies database using SELECT (scondition), PROJECT (pfieldlist), RENAME (?newName) and JOIN (?condition) (see example queries 1 & 2 in Section 8.5).
SELECT (Person), PROJECT (Person), RENAME (Person2) and JOIN (Person2.lastName = Person.lastname)
-- b. Tuple Relational Calculus (read Sections 8.6.1–8.6.4 & 8.6.8) — Write a simple query on the movies database using the tuple relational calculus queries (see example queries 0 & 1 in Section 8.6.4).
{ p.firstName, p.lastName | Person(p) AND (Existential d)
(HomeGroup(hg)AND hg.name = 'Home1' AND p.homeGroupId = hg.id)}

-- c.Define the following terms:
--    i. Existential (?) and universal (?) quantifiers (see Section 8.6.3).
--       Existential: there exists.. ,  Universal: all that exist..
--    ii. Safe expressions (see Section 8.6.8).
-- guaranteed to yield a finite number of tuples as its result; otherwise unsafe.