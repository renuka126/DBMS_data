-- Creating Product table

CREATE TABLE Product
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price INT
);

-- Inserting records

INSERT INTO Product VALUES (1, 'Laptop', 60000);
INSERT INTO Product VALUES (2, 'Mouse', 500);
INSERT INTO Product VALUES (3, 'Keyboard', 1200);
INSERT INTO Product VALUES (4, 'Monitor', 10000);
INSERT INTO Product VALUES (5, 'Printer', 8000);

-- Displaying all records

SELECT * FROM Product;


-- Deleting Mouse record

DELETE FROM Product
WHERE ProductID = 2;


-- Deleting Printer record

DELETE FROM Product
WHERE ProductID = 5;

-- Displaying remaining records

SELECT * FROM Product;