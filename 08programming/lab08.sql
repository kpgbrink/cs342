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
        RAISE_APPLICATION_ERROR(-20000, 'Actor of this id already exists: ' || :newactorId);
    end if;
    
    -- make it so there can be no more than 230 casting for any movie
    select count(*) into checkCount from Role
    where movieId = :new.movieId;
    
    if counter >= 1 then
        RAISE_APPLICATION_ERROR(-20000, 'Cannot cast more than 230 actors per movie');
    end if;    
end;

-- Procedure that adds an actor 
create or replace procedure castActor
(actorIDIn in Role.actorId%type, movieIdin in Role.movieId%type, rolein in Role.role%type) as
	counter integer;
begin	
	insert into Role(actorId, movieId, role) values
		(actorIDIn, movieIdin, rolein);
	dbms_output.put_line('Inserted new role');
end;

--a. 
begin castActor (89558, 238072, 'Danny Ocean'); end;

-- b.
begin castActor (89558, 238073, 'Danny Ocean'); end;

-- c.
begin castActor(89558, 167324, 'Danny Ocean'); end;
