-- Starter code for lab 3.
--
-- CS 342, Spring, 2017
-- kvlinden

-- Exercise 3.1

drop table Request;
drop table HomegroupTopic;
drop table Topic;
drop table PersonHouseHold;
drop table PersonTeam;
drop table Person;
drop table Homegroup;
drop table HouseHold;
drop table Team;

create table HouseHold(
	ID integer PRIMARY KEY,
	street varchar(30),
	city varchar(30),
	state varchar(2),
	zipcode char(5),
	phoneNumber char(12)
	);
    
create table Homegroup (
    ID integer PRIMARY KEY,
    name varchar(30),
    houseHoldId integer,
    foreign key (houseHoldId) references HouseHold(ID) on delete cascade
);

create table Topic (
    Id integer PRIMARY KEY,
    title varchar(30),
    description varchar(640)
);

create table HomegroupTopic (
    homegroupId integer,
    topicId integer,
    foreign key (homegroupId) references Homegroup(ID) on delete cascade,
    foreign key (topicId) references Topic(ID) on delete cascade
);

create table Person (
	ID integer PRIMARY KEY,
	title varchar(4),
	firstName varchar(15),
	lastName varchar(15),
	membershipStatus char(1) CHECK (membershipStatus IN ('m', 'a', 'c')),
    mentorId integer,
    homegroupId integer,
    foreign key (mentorId) references Person(ID) on delete set null,
    foreign key (homegroupId) references Homegroup(ID) on delete set null
	);

create table PersonHouseHold (
    PersonId integer,
    HouseHoldId integer,
    role varchar(30),
    foreign key (PersonId) references Person(ID) on delete cascade,
    foreign key (HouseHoldId) references HouseHold(ID) on delete cascade
);

create table Team (
    ID integer PRIMARY KEY,
    name varchar(30)
);

create table PersonTeam (
    PersonId integer,
    TeamId integer,
    role varchar(30),
    startDate date,
    endDate date,
    foreign key (PersonId) references Person(ID) on delete cascade,
    foreign key (Teamid) references Team(ID) on delete cascade
);

-- why would the date be the key? I didn't do it like that
-- request can onlyo have one response.
create table Request (
	householdId integer,
	personId integer,
	requestDate date,
	text varchar(255),
	requestAccess varchar(64),
	response varchar(64),
	foreign key (houseHoldId) references HouseHold(ID) on delete cascade,
	foreign key (PersonId) references Person(ID) on delete set null
);


INSERT INTO Household VALUES (0,'2347 Oxford Dr. SE','Grand Rapids','MI','49506','616-243-5680');

INSERT INTO Homegroup VALUES (0, 'Group0', 0);

INSERT INTO Person VALUES (0,'mr.','Keith','VanderLinden','m', null, 0);
INSERT INTO Person VALUES (1,'ms.','Brenda','VanderLinden','m', 0, 0);


INSERT INTO Topic VALUES (0, 'Fun Topic', 'This topic is really fun trust me');

INSERT INTO HomegroupTopic VALUES (0, 0);

INSERT INTO PersonHouseHold VALUES (0, 0, 'Talker');
INSERT INTO PersonHouseHold VALUES (1, 0, 'Walker');

INSERT INTO Team VALUES (0, 'A Team');
INSERT INTO Team VALUES (1, 'B Team');

INSERT INTO PersonTeam VALUES (0,0,'Hitman', date '2017-02-12', date '2017-05-07');
INSERT INTO PersonTeam VALUES (0,1,'Maker', date '2017-04-12', date '2017-05-09');
INSERT INTO PersonTeam VALUES (1,0,'Destroyer', date '2017-02-1', date '2017-05-01');

INSERT INTO Request VALUES (0, 0, date '2017-03-23', 'I want food', 'everyone', 'My food not yours');
INSERT INTO Request VALUES (0,1, date '2017-03-23', 'I want frisbee', 'everyone', 'I have that');


