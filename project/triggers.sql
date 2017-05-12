-- someone cannot have more than 1000 friends
create or replace trigger friendAdding before insert on StudentFriend for each row
declare
    checkFriend integer;
    tooManyFriends exception;
begin
	select count(*) into checkFriend from StudentFriend where student_id = :new.student_id;
	if checkFriend > 1000 then
		raise tooManyFriends;
	end if;

exception
	when tooManyFriends then
		RAISE_APPLICATION_ERROR(-20001, 'student: ' || :new.student_id || ' has too many friends');
end;
/
show errors;