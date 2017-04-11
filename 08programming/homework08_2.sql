/* Bacon Number — Implement a tool that loads a table (named BaconTable) with records that specify an
 actor ID and that actor’s Bacon number. An actor’s bacon number is the length of the shortest path 
 between the actor and Kevin Bacon (KB) in the “co-acting” graph. That is, KB has bacon number 0; all
 actors who acted in the same movie as KB have bacon number 1; all actors who acted in the same movie
 as some actor with Bacon number 1 but have not acted with Bacon himself have Bacon number 2, etc. 
 Actors who have never acted with anyone with a bacon number should not have a record in the table. 
 Stronger solutions will be configured so that the number can be based on any actor, not just Kevin Bacon. */
 
-- Kevin Bacon 

drop table baconTable;

create table baconTable (
    actorId integer primary key,
    baconNumber integer
);


create or replace procedure baconNumber (baseActorId integer, depthLevel integer) as
    checkbaseactor integer;
    checkbacontable integer;
begin
    -- check if baseActor is in the database.
    -- Does bacon exist?
    select count(*) into checkBaseActor from Actor where id = baseActorId;
    if checkBaseActor = 0 then
        raise_application_error(-20000, 'Base actor does not exist of id ' || baseActorId);
    end if;
    
    -- Insert Bacon 0. The Actor everyone is connected to.
    insert into BaconTable values (baseActorId, 0);
    
    -- loop through the bacon a certain depth amount.
    for i in 1..depthLevel loop
        -- add the actors to the table that are connected to someone in the i depth
        for actor in (select actorId
                      from role 
                      where movieId in 
                      (select movieId from baconTable where baconNumber = i)) loop
            select count(*) into checkbacontable from baconTable where actorId = actor.actorId;
            if checkbacontable = 0 then
                insert into baconTable values (actor.actorId, i);
            end if;
        end loop;
    end loop;
end;
/
show errors;

begin baconNumber(22591, 10); end;
/

select * from baconTable;




