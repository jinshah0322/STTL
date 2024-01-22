use dbForUnion

CREATE TABLE Finance_FirstHalf2023 (
    TransactionID INT PRIMARY KEY,
    TransactionDate DATE,
    Description NVARCHAR(255),
    Income DECIMAL(18, 2),
    Expenses DECIMAL(18, 2)
);
INSERT INTO Finance_FirstHalf2023 (TransactionID, TransactionDate, Description, Income, Expenses)
VALUES
    (1, '2023-01-15', 'Sales Income', 150000.00, 0.00),
    (2, '2023-02-05', 'Service Income', 75000.00, 0.00),
    (3, '2023-03-20', 'Product Purchase', 0.00, 30000.00),
	(4,'2023-03-20', 'Product Purchase', 0.00, 30000.00)

CREATE TABLE Finance_SecondHalf2023 (
    TransactionID INT PRIMARY KEY,
    TransactionDate DATE,
    Description NVARCHAR(255),
    Income DECIMAL(18, 2),
    Expenses DECIMAL(18, 2)
);

INSERT INTO Finance_SecondHalf2023 (TransactionID, TransactionDate, Description, Income, Expenses)
VALUES
	(4,'2023-03-20', 'Product Purchase', 0.00, 30000.00),
    (5, '2023-07-10', 'Sales Income', 120000.00, 0.00),
    (6, '2023-08-22', 'Consulting Fees', 50000.00, 0.00),
    (7, '2023-09-05', 'Equipment Purchase', 0.00, 45000.00)

/*union query*/
select * from Finance_FirstHalf2023 union select * from Finance_SecondHalf2023

/*union all*/
select * from Finance_FirstHalf2023 union all select * from Finance_SecondHalf2023