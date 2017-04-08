
drop table RankLog;

create table RankLog (
    userId varchar2(30),
    dateChanged date,
    originalRank number(10,2),
    newRank number(10,2)
);

CREATE OR REPLACE TRIGGER MovieShadowLogTrigger
  BEFORE UPDATE ON Movie
  FOR each row
  WHEN (new.rank <> old.rank)
BEGIN
    insert into RankLog VALUES (
        user,
        sysdate,
        :old.rank,
        :new.rank
    );
END;
/

update Movie set rank = 11 where id IN (30959, 130128);

SELECT * FROM RankLog;
