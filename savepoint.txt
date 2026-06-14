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

START TRANSACTION;

UPDATE Accounts
SET Balance = Balance - 3000
WHERE AccountID = 101;

SAVEPOINT TransferPoint;

UPDATE Accounts
SET Balance = Balance + 3000
WHERE AccountID = 102;

-- Undo changes after savepoint
ROLLBACK TO TransferPoint;

COMMIT;

SELECT * FROM Accounts;