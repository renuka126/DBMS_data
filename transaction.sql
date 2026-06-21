
CREATE DATABASE BankSystem;

-- Select Database
USE BankSystem;

-- Create Accounts Table
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    AccountHolderName VARCHAR(50),
    Balance DECIMAL(10,2)
);

-- Insert Sample Records
INSERT INTO Accounts
VALUES
(101, 'Rahul Sharma', 25000.00),
(102, 'Priya Patil', 18000.00);

-- Display Initial Data
SELECT * FROM Accounts;

-- Start Transaction
START TRANSACTION;

-- Transfer Rs. 5000 from Rahul to Priya

UPDATE Accounts
SET Balance = Balance - 5000
WHERE AccountID = 101;

UPDATE Accounts
SET Balance = Balance + 5000
WHERE AccountID = 102;

-- Verify Updated Balances
SELECT * FROM Accounts;

-- Save Changes Permanently
COMMIT;

-- Display Final Records
SELECT * FROM Accounts;
