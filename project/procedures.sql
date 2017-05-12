-- delete a user 
-- a lot of things need to be deleted when a user/student is deleted.
-- this makes sure all of the data used on a user is deleted.
create or replace procedure deleteUser(userId in integer) as
    cursor schedulesDeleted is select id from Schedule where student_id = userid;
begin
	delete from StudentFriend where student_id = userId or student_friend_id = userId;
    for sched in schedulesDeleted
    loop
        delete from Schedule_SideBarLink where schedule_id = sched.id;
        delete from Schedule_PlaceAndHours where schedule_id = sched.id;
        delete from Schedule_ClassLink where schedule_id = sched.id;
    end loop;
    delete from Schedule where student_id = userId;
    delete from FriendGroup_Student where student_id = userId;
    delete from Student where id = userId;
end;
/
show errors;