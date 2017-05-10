-- Exercise 8.2
/* Write a recursive procedure to creates a temporary table and loads it with the 
IDs and names of all the sequels of a given movie (identified by movie ID #), including 
sequels of sequels. Look forward in time (i.e., list Ocean’s Twelve for Ocean’s Eleven 
but not vice-versa) and you can assume that there will be no cycles in the sequel chains. 
Demonstrate that your procedure works by trying the following.*/

-- Insert your results into this table.
CREATE TABLE SequelsTemp (
  id INTEGER,
  name varchar2(100),
  PRIMARY KEY (id)
 );
 
CREATE OR REPLACE PROCEDURE getSequels (movieIdIn IN Movie.id%type) as
	-- Fill this in based on:
	--     the cursor example in class exercise 8.2.b.
	-- the recursive procedure example in class exercise 8.3.b.
  cursor sequel is
    select id, name
    from movie
    where id = (select sequelid from movie where id = movieIdIn);
begin
    -- loops through all sequels from cursor and adds more recurively
    for i in sequel loop
        insert into SequelsTemp values (i.id, i.name);
        getSequels(i.id);
    end loop;
END;
/
show errors;

-- Get the sequels for Ocean's 11, i.e., 4 of them.
BEGIN  getSequels(238071);  END;
/
SELECT * FROM SequelsTemp;


delete SequelsTemp;

-- Get the sequels for Ocean's Fourteen, i.e., none.
BEGIN  getSequels(238075);  END;
/
SELECT * FROM SequelsTemp;

-- Clean up.
DROP TABLE SequelsTemp;