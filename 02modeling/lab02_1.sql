-- Exercise 2.1

-- A. Try adding records to the movie relation that cause these intra-relation issues:

--i. a repeated primary key value
INSERT INTO Movie VALUES (1, 'Movie', 1995, 8.2);
-- error ORA-00001: unique constraint (KPB23.SYS_C006999) violated

--ii. a NULL primary key value
INSERT INTO Movie VALUES (null, 'Movie', 1995, 8.2);
-- ORA-01400: cannot insert NULL into ("KPB23"."MOVIE"."ID")

--iii. a violation of a CHECK constraint
INSERT INTO Movie VALUES (3, 'Movie', 100, 8.2);
-- ORA-02290: check constraint (KPB23.SYS_C006998) violated

--iv. a violation of an SQL datatype constraint
INSERT INTO Movie VALUES (3, 'Movie', 2000, 'I should be a float, oops');
-- ORA-01722: invalid number

--v. a negative score value
INSERT INTO Movie VALUES (3, 'Movie', 2000, -8);
-- 1 row created



-- B. Try adding records that cause these inter-relation issues:

-- i. a new record with a NULL value for a foreign key value
INSERT INTO Casting VALUES (null, 1, 'star');
-- 1 row created

-- ii. a foreign key value in a referencing (aka child) table that doesn't match 
--     any key value in the referenced (aka parent) table.
INSERT INTO Casting VALUES (9999, 1, 'star');
-- ORA-02291: integrity constraint (KPB23.SYS_C007002) violated - parent key not found

-- iii. a key value in a referenced table with no related records in the referencing table
INSERT INTO Performer VALUES (5, 'Bob the Builder');
-- 1 row created.

-- C. Try deleting/modifying records as follows:
-- i. Delete a referenced record that is referenced by a referencing record.
DELETE FROM Movie WHERE ID = 1;
-- 1 row deleted

-- ii. Delete a referencing record that references a referenced record.
DELETE FROM Casting WHERE ID = 1;

-- iii. Modify the ID of a movie record that is referenced by a casting record.
UPDATE Movie  SET ID = 99 WHERE ID = 1;
-- ORA-02292: integrity constraint (KPB23.SYS_C007002) violated - child record found

-- Note that though the text discusses it, Oracle doesn’t support ON UPDATE CASCADE. 
-- Would supporting such a feature be a good idea?

-- No because primary keys are supposed to be immutable. If you are changing
-- your primary key then you are doing something wrong.