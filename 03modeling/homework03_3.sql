-- Exercise 9.11
-- Make sql database based on 3.32

drop table partCEOrder;
drop table CEOrder;
drop table Part;
drop table Employee;
drop table Customer;


create table Employee(
    id integer PRIMARY KEY,
    firstName varchar(32),
    lastname varchar(32),
    zipCode char(5)
);

create table Customer(
    id integer PRIMARY KEY,
    firstName varchar(32),
    lastname varchar(32),
    zipCode char(5)
);

create table Part(
    id integer PRIMARY KEY,
    name varchar(32),
    price number(9,2),
    qty number(9)
);

-- Customer Employee Order
create table CEOrder(
    id integer PRIMARY KEY,
    customerId integer,
    employeeId integer,
    receitDate date,
    shipDate date,
    actualShipDate date,
    foreign key (customerId) references Customer(id) on delete cascade,
    foreign key (employeeId) references Employee(id) on delete cascade
);

create table partCEOrder(
    partId integer,
    CEOrderId integer,
    foreign key (partId) references Part(id) on delete cascade,
    foreign key (CEOrderId) references CEOrder(id) on delete cascade
);

INSERT INTO Employee VALUES (0, 'Kristofer', 'Brink', 49546);
INSERT INTO Employee VALUES (1, 'Bob', 'Dobb', 49547);

INSERT INTO Customer VALUES (0, 'Todd', 'Bodd', 12345);
INSERT INTO Customer VALUES (1, 'Mod', 'Ha', 12346);

INSERT INTO Part VALUES (0, 'Computer', 12.12, 4);
INSERT INTO Part VALUES (1, 'Mouse', 23.23, 9);

INSERT INTO CEOrder VALUES (0, 0, 0, date '2017-02-12', date '2017-03-12', date '2017-05-13');
INSERT INTO CEOrder VALUES (1, 1, 1, date '2017-02-12', date '2017-03-12', date '2017-05-13');

INSERT INTO partCEOrder VALUES (0, 1);
INSERT INTO partCEOrder VALUES (1, 0);
