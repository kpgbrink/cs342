-- This command file loads an experimental person database.
-- The data conforms to the following assumptions:
--     * People can have 0 or many team assignments.
--     * People can have 0 or many visit dates.
--     * Teams and visits don't affect one another.
--
-- CS 342, Spring, 2017
-- kvlinden

DROP TABLE PersonTeam;
DROP TABLE PersonVisit;

CREATE TABLE PersonTeam (
	personName varchar(10),
    teamName varchar(10)
	);

CREATE TABLE PersonVisit (
	personName varchar(10),
    personVisit date
	);

-- Load records for two team memberships and two visits for Shamkant.
INSERT INTO PersonTeam VALUES ('Shamkant', 'elders');
INSERT INTO PersonTeam VALUES ('Shamkant', 'executive');
INSERT INTO PersonVisit VALUES ('Shamkant', '22-FEB-2015');
INSERT INTO PersonVisit VALUES ('Shamkant', '1-MAR-2015');

-- Query a combined "view" of the data of the form View(name, team, visit).
SELECT pt.personName, pt.teamName, pv.personVisit
FROM PersonTeam pt, PersonVisit pv
WHERE pt.personName = pv.personName;


-- 4.2

-- a. Demonstrate, formally, whether the relations implemented by the tables PersonTeam and PersonVisit are in BCNF and/or 4NF (or not).

--    BCNF: This does satisfy BNCF because for PersonTeam personName and teamName do not depend on each other.
--          For PersonVisit the personName and personVisit do not depend on each other also.
--          Because there are no functional dependencies and no primary keys these relations are in BCNF.
--    4NF: This already satisfies BCNF which is one requirement of 4NF. There are also no dependencies so it automatically satisfies 4NF.

-- b. Consider the output of the data queried by the combined “view” query at the end of the command file. Demonstrate, formally, whether this 
--    view, when considered as a (single) relation, is in BCNF and/or 4NF (or not).

--    BCNF: This still satisfies BCNF because there are no functional dependencies or primary keys in these relations.
--          Everything in the table is the key.

--    4NF: This is still in 4NF because it already satisfies BCNF which is a requirement and there are no dependencies so it automatically is in 4NF.


-- c. The view has the same number of records as the original tables. Does this mean that the original schema and the derived “view” schema are 
--    equally appropriate? If so, explain why; if not, explain why one of the schemata is better. Does your choice depend on context?


-- The first table is bad and the second table is also bad. The non-combined version is better because if you were to add more data the table would grow 
-- even bigger. The data that would be shown in the second version would be derivable data from the original table. 
-- Choice does not depend on context because you can get the second table from the first so if you want to view it as that way it is possible.





