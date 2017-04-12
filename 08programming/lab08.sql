-- Kristofer Brink

-- Exercise 8.1

-- Check if role can be added
-- actor cannot already be cast in movie
-- there cannot be more than 230 castings per movie


create or replace trigger checkAddActor before insert on Role for each row
declare
    checkActor integer;
    checkCount integer;
begin
    -- check if actor is already cast in movie
    select count(*) into checkActor from Role
    where movieId = :new.movieId and actorId = :new.actorId;
    
    if checkActor >= 1 then
        RAISE_APPLICATION_ERROR(-20000, 'Actor of this id already exists: ' || :new.actorId);
    end if;
    
    -- make it so there can be no more than 230 casting for any movie
    select count(*) into checkCount from Role
    where movieId = :new.movieId;
    
    if checkCount >= 1 then
        RAISE_APPLICATION_ERROR(-20000, 'Cannot cast more than 230 actors per movie');
    end if;    
end;
/
show errors;

-- Procedure that adds an actor 
create or replace procedure castActor
(actorIDIn in Role.actorId%type, movieIdin in Role.movieId%type, rolein in Role.role%type) as
	counter integer;
begin	
	insert into Role(actorId, movieId, role) values
		(actorIDIn, movieIdin, rolein);
	dbms_output.put_line('Inserted new role');
end;
/ 
show errors;

--a. 
begin castActor (89558, 238072, 'Danny Ocean'); end;
/

-- b.
begin castActor (89558, 238073, 'Danny Ocean'); end;
/

-- c.
begin castActor(89558, 167324, 'Danny Ocean'); end;
/

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
    sequelMovieId integer;
BEGIN
    BEGIN
        -- insert sequel of movieId into sequelsTemp
        select s.id into sequelMovieId
        from Movie m
        join Movie s on m.sequelId = s.id
        where m.id = movieIdIn
        and s.id not in (select st.id from SequelsTemp st);
    EXCEPTION
        when no_data_found then
            sequelMovieId := null;
    END;
    
    
    if sequelMovieId is not null then
        insert into SequelsTemp select m.id, m.name from Movie m where m.id = sequelMovieId;
        getSequels(sequelMovieId);
    end if;
    
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







