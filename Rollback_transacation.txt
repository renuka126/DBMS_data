CREATE DATABASE BankSystem;

USE BankSystem;

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    AccountHolderName VARCHAR(50),
    Balance DECIMAL(10,2)
);

INSERT INTO Accounts
VALUES
(101, 'Rahul Sharma', 25000.00),
(102, 'Priya Patil', 18000.00);

SELECT * FROM Accounts;

START TRANSACTION;

UPDATE Accounts
SET Balance = Balance - 5000
WHERE AccountID = 101;

UPDATE Accounts
SET Balance = Balance + 5000
WHERE AccountID = 102;

-- Check temporary changes
SELECT * FROM Accounts;

-- Cancel the transaction
ROLLBACK;

-- Original balances restored
SELECT * FROM Accounts;
