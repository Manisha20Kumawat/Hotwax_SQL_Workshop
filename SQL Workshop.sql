create database  hotwax_sql_workshop;
use hotwax_sql_workshop;
CREATE TABLE Orders (
    OrderId VARCHAR(10) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    ProductName VARCHAR(50),
    ProductDescription VARCHAR(50),
    ProductReturnable VARCHAR(3),
    Seller VARCHAR(50),
    Total INT,
    Date DATE,
    OrderStatus VARCHAR(20),
    City VARCHAR(50),
    State VARCHAR(50),
    PinCode INT
);
INSERT INTO Orders VALUES
('O1', 'John', 'Doe', 'One Plus Nord', 'Red Mobile Phone', 'No', 'Seter_z', 20000, '2022-08-15', 'Approved', 'Indore', 'MP', 452001),
('O2', 'John', 'Doe', 'Air Jordans', 'Shoes', 'Yes', 'Nike', 25000, '2022-08-15', 'Approved', 'Indore', 'MP', 452001),
('O3', 'Mary', 'Ann', 'One Plus Nord', 'Red Mobile Phone', 'No', 'Seter_z', 20000, '2022-08-15', 'Approved', 'Pune', 'Maharashtra', 410014);

CREATE TABLE Users (
    UserId INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    PinCode INT
);

CREATE TABLE Products (
    ProductId INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(50),
    ProductDescription VARCHAR(50),
    ProductReturnable VARCHAR(3),
    Seller VARCHAR(50)
);

ALTER TABLE Orders
ADD COLUMN UserId INT,
ADD COLUMN ProductId INT,
ADD FOREIGN KEY (UserId) REFERENCES Users(UserId),
ADD FOREIGN KEY (ProductId) REFERENCES Products(ProductId);

INSERT INTO Users (FirstName, LastName, City, State, PinCode)
SELECT DISTINCT FirstName, LastName, City, State, PinCode
FROM Orders;

INSERT INTO Products (ProductName, ProductDescription, ProductReturnable, Seller)
SELECT DISTINCT ProductName, ProductDescription, ProductReturnable, Seller
FROM Orders;

SET SQL_SAFE_UPDATES = 0;

SET SQL_SAFE_UPDATES = 1;

UPDATE Orders o
JOIN Users u ON o.FirstName = u.FirstName AND o.LastName = u.LastName
JOIN Products p ON o.ProductName = p.ProductName
SET o.UserId = u.UserId, o.ProductId = p.ProductId
WHERE o.OrderId IS NOT NULL;

SET SQL_SAFE_UPDATES = 0;

UPDATE Orders o
JOIN Users u ON o.FirstName = u.FirstName AND o.LastName = u.LastName
JOIN Products p ON o.ProductName = p.ProductName
SET o.UserId = u.UserId, o.ProductId = p.ProductId
WHERE o.OrderId IS NOT NULL;

SET SQL_SAFE_UPDATES = 1;

ALTER TABLE Orders
DROP COLUMN FirstName,
DROP COLUMN LastName,
DROP COLUMN ProductName,
DROP COLUMN ProductDescription,
DROP COLUMN ProductReturnable,
DROP COLUMN Seller,
DROP COLUMN City,
DROP COLUMN State,
DROP COLUMN PinCode;

Select * from Orders;
Select * from Users;
Select * from Products;

Select * from Users;

CREATE TABLE Address (
    PinCode INT PRIMARY KEY,
    City VARCHAR(50),
    State VARCHAR(50)
);

INSERT INTO Address (PinCode, City, State) VALUES
(452001, 'Indore', 'MP'),
(410014, 'Pune', 'Maharashtra');

CREATE TABLE User (
    UserId INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    PinCode INT,
    FOREIGN KEY (PinCode) REFERENCES Address(PinCode)
);

select * from Address;
select * from User;

INSERT INTO User (FirstName, LastName, PinCode) VALUES
('John', 'Doe', 452001),
('Mary', 'Ann', 410014);

select * from User;

select * from Orders;

CREATE TABLE Orders1 (
    OrderId VARCHAR(10) PRIMARY KEY,
    UserId INT,
    ProductId INT,
    Total INT,
    Date DATE,
    OrderStatus VARCHAR(20),
    FOREIGN KEY (UserId) REFERENCES User(UserId),
    FOREIGN KEY (ProductId) REFERENCES Products(ProductId)
);

INSERT INTO Orders1 VALUES
('O1', 1, 1, 20000, '2022-08-15', 'Approved'),
('O2', 1, 2, 25000, '2022-08-15', 'Approved'),
('O3', 2, 1, 20000, '2022-08-15', 'Approved');

select * from Orders1;

SELECT 
    o.OrderId, CONCAT(u.FirstName, ' ', u.LastName) AS UserName,
    p.ProductName, o.Total, o.Date, o.OrderStatus
FROM 
    Orders o
JOIN 
    User u ON o.UserId = u.UserId
JOIN 
    Products p ON o.ProductId = p.ProductId
WHERE 
    o.OrderId = 'O2';
    
SELECT 
    o.OrderId, CONCAT(u.FirstName, ' ', u.LastName) AS UserName,
    p.ProductName, o.Total, o.Date, o.OrderStatus
FROM 
    Orders1 o
JOIN 
    User u ON o.UserId = u.UserId
JOIN 
    Products p ON o.ProductId = p.ProductId
WHERE 
    o.OrderId = 'O1';
    
SELECT OrderId, Total
FROM Orders1
WHERE OrderId = 'O1';

SELECT OrderId, Total
FROM Orders1
WHERE OrderId = 'O2';

SELECT 
    o.OrderId,
    CONCAT(u.FirstName, ' ', u.LastName) AS UserName,
    p.ProductName,
    o.Total AS OrderTotal
FROM 
    Orders1 o
JOIN 
    User u ON o.UserId = u.UserId
JOIN 
    Products p ON o.ProductId = p.ProductId
WHERE 
    u.UserId = 1;

SELECT 
    u.UserId,
    CONCAT(u.FirstName, ' ', u.LastName) AS UserName,
    SUM(o.Total) AS TotalAmountAllOrders,
    COUNT(o.OrderId) AS NumberOfOrders
FROM 
    User u
JOIN 
    Orders1 o ON u.UserId = o.UserId
WHERE 
    u.UserId = 1  -- Replace 1 with the desired CustomerId
GROUP BY 
    u.UserId, UserName;
    
select * from Address;

SELECT u.UserId, u.FirstName, u.LastName, a.PinCode, a.City, a.State
FROM User u
JOIN Address a ON u.PinCode = a.PinCode
WHERE u.UserId = 1; 

UPDATE Address
SET City = Indore  
WHERE UserId = 1;

INSERT INTO Address (PinCode, City, State)
VALUES (400001, 'Mumbai', 'Maharashtra');

UPDATE User
SET PinCode = 400001  -- Use the PinCode you just inserted
WHERE UserId = 1;

SELECT u.UserId, u.FirstName, u.LastName, a.PinCode, a.City, a.State
FROM User u
JOIN Address a ON u.PinCode = a.PinCode
WHERE u.UserId = 1; 

SELECT * FROM Products
WHERE ProductId = 1;

UPDATE Products
SET ProductDescription = 'New Product Description'  
WHERE ProductId = 1;

SELECT * FROM Products
WHERE ProductId = 1;

SELECT 
    ProductId,
    ProductName,
    ProductDescription
FROM 
    Products 
WHERE 
    ProductReturnable = 'Yes';
    
select * from Products;














