-- 1. Exercise 5.14
-- Implement this schema using the Oracle SQL DDL. Please add an item name in the Item 
-- table.

-- Include appropriate constraints and, in particular, specify what should be done on 
-- deletes (e.g., cascade, ...). Justify your implementation in the code comments.

-- Include 3-5 sample records in each table. You’ll need to have sufficient records to
--  drive the queries specified below, so it’s probably wise to look through the queries
--  so that you will have non-empty and non-NULL results for each of them.

CREATE TABLE CUSTOMER(
    Id INT NOT NULL PRIMARY KEY,
    Cname VARCHAR(64) NOT NULL,
    City VARCHAR(64) NOT NULL
);

CREATE TABLE "ORDER"(
    Id INT NOT NULL PRIMARY KEY,
    Odate DATE NOT NULL,
    CustomerId INT NOT NULL,
    Ord_amt INT NOT NULL,
	-- a customer cannot be deleted if they have orders
    CONSTRAINT ORDER_CUSTOMER_FK FOREIGN KEY (CustomerId) REFERENCES CUSTOMER (Id)
);

CREATE TABLE ITEM(
    Id INT NOT NULL PRIMARY KEY,
    Unit_price NUMBER NOT NULL
);

CREATE TABLE ORDER_ITEM(
    OrderId INT NOT NULL,
    ItemId INT NOT NULL,
    Qty INT NOT NULL,
    CONSTRAINT ORDER_ITEM_PK PRIMARY KEY (OrderId, ItemId),
	-- If the order is deleted then the order item should be deleted
    CONSTRAINT ORDER_ITEM_ORDER_FK FOREIGN KEY (OrderId) REFERENCES "ORDER" (Id) ON DELETE CASCADE,
	-- The item should not be deleted unless if the order_item referencing it is gone.
    CONSTRAINT ORDER_ITEM_ITEM_FK FOREIGN KEY (ItemId) REFERENCES ITEM (Id)
);

CREATE TABLE WAREHOUSE(
    Id INT NOT NULL PRIMARY KEY,
    City VARCHAR(64) NOT NULL
);

CREATE TABLE SHIPMENT(
    OrderId INT NOT NULL,
    WarehouseId INT NOT NULL,
    ShipDate DATE NOT NULL,
    CONSTRAINT SHIPMENT_PK PRIMARY KEY (OrderId, WarehouseId),
	-- If order is deleted then the shipment will be deleted.
    CONSTRAINT SHIPMENT_ORDER_FK FOREIGN KEY (OrderId) REFERENCES "ORDER" (Id) ON DELETE CASCADE,
	-- Prevent warehouse from being deleted.
    CONSTRAINT SHIPMENT_WAREHOUSE_FK FOREIGN KEY (WarehouseId) REFERENCES WAREHOUSE (Id)
);

INSERT INTO CUSTOMER VALUES (1, 'Bob', 'City1');
INSERT INTO CUSTOMER VALUES (2, 'Todd', 'City2');
INSERT INTO CUSTOMER VALUES (3, 'Kristofer', 'City3');

INSERT INTO "ORDER" VALUES (1, DATE '2017-02-18', 1, 1);
INSERT INTO "ORDER" VALUES (2, DATE '2017-02-5', 1, 2);
INSERT INTO "ORDER" VALUES (3, DATE '2017-02-1', 2, 3);

INSERT INTO ITEM VALUES (1, 1.10); 
INSERT INTO ITEM VALUES(2, 1.20);
INSERT INTO ITEM VALUES(3, 1.30);

INSERT INTO ORDER_ITEM VALUES (1, 1, 1);
INSERT INTO ORDER_ITEM VALUES (2, 2, 2);
INSERT INTO ORDER_ITEM VALUES (3, 3, 3);

INSERT INTO WAREHOUSE VALUES (1, 'City3');
INSERT INTO WAREHOUSE VALUES (2, 'City2');
INSERT INTO WAREHOUSE VALUES (3, 'City1');

INSERT INTO SHIPMENT VALUES (1, 1, DATE '2017-03-01');
INSERT INTO SHIPMENT VALUES (2, 2, DATE '2017-03-02');
INSERT INTO SHIPMENT VALUES (3, 3, DATE '2017-03-03');

-- 2. Exercise 5.20. What recommendations would you have for CIT if they were considering replacing 
--       surrogate student ID numbers with a more natural key? Either suggest a new form 
--       of key or try to convince them that surrogate keys are acceptable.

--      a. For natural keys you could use the person's name and graduation date and
--         age and maybe parents. Even with all of that as the natural key it still would
--         not neccessarily always be unique.I would not use a natural key because there 
--         is a chance it would not be unique and a surrogate key makes more sense in 
--         this situation.
--      c. Making a surrogate key makes clashes for uniqueness hard to happen. 
--         Using a natural key can be easier but it could also cause a problem with 
-- 	       the key not being unique. Usually surrogate keys are used because uniqueness
--         is a big enough problem.

-- 3. Write the SQL commands to retrieve the following from the customer-order database
--    you built above.

-- a. all the order dates and amounts for orders made by a customer with a particular name
--  (one that exists in your database), ordered chronologically by date
SELECT o.Odate, o.Ord_amt
FROM "ORDER" o 
JOIN CUSTOMER c ON o.CustomerId = c.Id
WHERE c.Cname = 'Bob'
ORDER BY o.Odate;
-- a. all the customer ID numbers for customers who have at least one order in the
--    database

-- b. all the customer ID numbers for customers who have at least one order in the
--    database

SELECT DISTINCT c.Id
FROM CUSTOMER c
JOIN "ORDER" o ON c.Id = o.CustomerId;

-- c. the customer IDs and names of the people who have ordered an item with a particular 
--    name (one that exists in your database)
SELECT DISTINCT c.Id, c.Cname
FROM CUSTOMER c
JOIN "ORDER" o ON c.Id = o.CustomerId
JOIN ORDER_ITEM oi ON o.Id = oi.OrderId
JOIN Item i ON oi.ItemId = i.Id
WHERE i.Id = 1;






