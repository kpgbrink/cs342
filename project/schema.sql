-- Calvin Schedule Helper. The DATABASE
-- Example of outcome without the advanced login and friending.
-- http://sam.ohnopub.net/~kpgbrink/2016/fall/

-- The users of this database will be students
CREATE TABLE Student (
    id integer not null primary key,
    firstName varchar(30),
    middleName varchar(30),
    lastName varchar(30),
    email varchar(60)
);

-- Users can friend other users. This will let people see their friends schedules
CREATE TABLE StudentFriend (
    student_id integer,
    student_friend_id integer,
    foreign key (student_id) references Student(id) on delete cascade,
    foreign key (student_friend_id) references Student(id) on delete cascade
);

-- students can have schedules
CREATE TABLE Schedule (
    id integer not null primary key,
    student_id integer,
    title varchar(50),
    semester varchar(50),
    semester_year integer,
    link varchar(100), -- link to schedule from slate permutate
    permission varchar(50), -- me, friends, public
    foreign key (student_id) references Student(id) on delete cascade
);

-- Data for common links you can add. 
CREATE TABLE SideBarLink (
    id integer primary key,
    title varchar(40),
    image varchar(100),
    link varchar(100)
);

-- Connect schedule to link
CREATE TABLE Schedule_SideBarLink (
    schedule_id integer,
    sidebarlink_id integer,
    foreign key (schedule_id) references Schedule(id) on delete cascade,
    foreign key (sidebarlink_id) references SideBarLink(id) on delete cascade
);

-- Data for places and hours that can be shown.
-- add link
CREATE TABLE PlaceAndHours (
    id integer primary key,
    place_name varchar(50),
    hour_script varchar(30)
);

-- Connect schedule to place hours
CREATE TABLE Schedule_PlaceAndHours (
    schedule_id integer,
    placeAndHours_id integer,
    foreign key (schedule_id) references Schedule(id) on delete cascade,
    foreign key (placeAndHours_id) references PlaceAndHours(id) on delete cascade
);

-- Data for links to the class important webpages.
CREATE TABLE ClassLink (
    id integer primary key,
    name varchar(40),
    link varchar(100)
);

-- Connect schedule to classLink
CREATE TABLE Schedule_ClassLink (
    schedule_id integer,
    classLink_id integer,
    foreign key (schedule_id) references Schedule(id) on delete cascade,
    foreign key (classLink_id) references ClassLink(id) on delete cascade
);

-- Added for more relationships

-- Data for groups of students who want to know other's schedules.
CREATE TABLE FriendGroup (
    id integer primary key,
    creater_id integer,
    name varchar(50),
    foreign key (creater_id) references Student(id) on delete cascade
);

-- Schedules that are shared in the group
CREATE TABLE FriendGroup_Schedule (
    friendGroup_id integer,
    schedule_id integer, 
    foreign key (friendGroup_id) references FriendGroup(id) on delete cascade,
    foreign key (schedule_id) references Schedule(id) on delete cascade
);

-- Students that are in the group
CREATE TABLE FriendGroup_Student (
    friendGroup_id integer,
    student_id integer,
    foreign key (friendGroup_id) references FriendGroup(id) on delete cascade,
    foreign key (student_id) references Student(id) on delete cascade
);



