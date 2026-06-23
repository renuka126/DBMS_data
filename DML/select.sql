-- Creating Customer table

CREATE TABLE Customer
(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(30),
    Balance INT
);

-- Inserting records

INSERT INTO Customer VALUES (1, 'Vikas', 'Pune', 15000);
INSERT INTO Customer VALUES (2, 'Nidhi', 'Mumbai', 22000);
INSERT INTO Customer VALUES (3, 'Ramesh', 'Pune', 18000);
INSERT INTO Customer VALUES (4, 'Kavita', 'Delhi', 25000);
INSERT INTO Customer VALUES (5, 'Suresh', 'Mumbai', 12000);

-- Display all customers

SELECT * FROM Customer;


-- Display customers from Pune

SELECT *
FROM Customer
WHERE City = 'Pune';


-- Display customers having balance greater than 15000

SELECT *
FROM Customer
WHERE Balance > 15000;


-- Display only names and balances

SELECT CustomerName, Balance
FROM Customer;