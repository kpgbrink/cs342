

--GRANT CONNECT TO schedule_helper IDENTIFIED BY password;
--GRANT UNLIMITED TABLESPACE TO schedule_helper;



--@load.sql

-- Create the Schedule helper church user and database. 
-- See ../README.txt for details.

-- Create the user.
DROP USER kpb23 CASCADE;
GRANT 
	CONNECT,
	CREATE TABLE,
	CREATE SESSION,
	CREATE SEQUENCE,
	CREATE VIEW,
	CREATE MATERIALIZED VIEW,
	CREATE PROCEDURE,
	CREATE TRIGGER,
	UNLIMITED TABLESPACE
	TO kpb23
	IDENTIFIED BY bjarne;

-- Connect to the user's account/schema.
CONNECT kpb23/bjarne;

-- Load database
@load.sql