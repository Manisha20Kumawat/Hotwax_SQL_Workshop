# Hotwax_SQL_Workshop
This README provides information about Normalization and their operations:

1. **Initial Table Structure(1NF)**
2. **Conversion to 2NF**
3. **Conversion to 3NF**
4. **Database Operations**

## 1. Initial Table Structure(1NF)

### Create and use database
create database  hotwax_sql_workshop;
use hotwax_sql_workshop;

### Create Orders Table
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

### Insert Data into Orders Table
INSERT INTO Orders VALUES
('O1', 'John', 'Doe', 'One Plus Nord', 'Red Mobile Phone', 'No', 'Seter_z', 20000, '2022-08-15', 'Approved', 'Indore', 'MP', 452001),
('O2', 'John', 'Doe', 'Air Jordans', 'Shoes', 'Yes', 'Nike', 25000, '2022-08-15', 'Approved', 'Indore', 'MP', 452001),
('O3', 'Mary', 'Ann', 'One Plus Nord', 'Red Mobile Phone', 'No', 'Seter_z', 20000, '2022-08-15', 'Approved', 'Pune', 'Maharashtra', 410014);

### Table structure
![orders](https://github.com/Manisha20Kumawat/Hotwax_SQL_Workshop/assets/142007598/8d7c4706-1ebe-4902-afa8-3f5ede0d7e16)

## 2. Conversion to 2NF

### Create Users and Products Table
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

### Alter Orders Table
ALTER TABLE Orders
ADD COLUMN UserId INT,
ADD COLUMN ProductId INT,
ADD FOREIGN KEY (UserId) REFERENCES Users(UserId),
ADD FOREIGN KEY (ProductId) REFERENCES Products(ProductId);

### Insert Data into Users and Products Tables
INSERT INTO Users (FirstName, LastName, City, State, PinCode)
SELECT DISTINCT FirstName, LastName, City, State, PinCode
FROM Orders;

INSERT INTO Products (ProductName, ProductDescription, ProductReturnable, Seller)
SELECT DISTINCT ProductName, ProductDescription, ProductReturnable, Seller
FROM Orders;

### Update Orders Table with UserId and ProductId
SET SQL_SAFE_UPDATES = 0;

UPDATE Orders o
JOIN Users u ON o.FirstName = u.FirstName AND o.LastName = u.LastName
JOIN Products p ON o.ProductName = p.ProductName
SET o.UserId = u.UserId, o.ProductId = p.ProductId
WHERE o.OrderId IS NOT NULL;

SET SQL_SAFE_UPDATES = 1;

### Drop Unnecessary Columns from Orders Table
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

### Tables Users, Products, Orders
![Users](https://github.com/Manisha20Kumawat/Hotwax_SQL_Workshop/assets/142007598/ab48a342-c7ba-4f85-b82c-326aa39afe78)

![Products](https://github.com/Manisha20Kumawat/Hotwax_SQL_Workshop/assets/142007598/bac764bd-a7dc-4a45-8be4-c8eac18f7947)

![Orders Updated](https://github.com/Manisha20Kumawat/Hotwax_SQL_Workshop/assets/142007598/a0128c80-5469-4ebe-963b-d6a21810e350)

## 3. Conversion to 3NF

### Create Address and User Tables
CREATE TABLE Address (
    PinCode INT PRIMARY KEY,
    City VARCHAR(50),
    State VARCHAR(50)
);

CREATE TABLE User (
    UserId INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    PinCode INT,
    FOREIGN KEY (PinCode) REFERENCES Address(PinCode)
);

### Insert Data into Address User Tables
INSERT INTO Address (PinCode, City, State) VALUES
(452001, 'Indore', 'MP'),
(410014, 'Pune', 'Maharashtra');

INSERT INTO User (FirstName, LastName, PinCode) VALUES
('John', 'Doe', 452001),
('Mary', 'Ann', 410014);

### Create and Populate Orders1 Table
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

### Tables Address, User, Orders1
![Address](https://github.com/Manisha20Kumawat/Hotwax_SQL_Workshop/assets/142007598/e505862c-9a29-49a3-a921-79eea5c0b701)

![User](https://github.com/Manisha20Kumawat/Hotwax_SQL_Workshop/assets/142007598/1d5fad89-158d-4e0a-b540-80d864242076)

![Orders1](https://github.com/Manisha20Kumawat/Hotwax_SQL_Workshop/assets/142007598/14edbb3a-563b-475d-8acb-6ec60d009994)

## 4. Database Operations

### Check Status of Your Order
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

### Query Output
![Check Status](https://github.com/Manisha20Kumawat/Hotwax_SQL_Workshop/assets/142007598/46c753c7-0917-4948-b25a-4c77ea251f5b)

### Find Total Amount of Your Orders
SELECT OrderId, Total
FROM Orders1
WHERE OrderId = 'O1';

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
    u.UserId = 1  
GROUP BY 
    u.UserId, UserName;

### Query Output 
![Total](https://github.com/Manisha20Kumawat/Hotwax_SQL_Workshop/assets/142007598/34c2dd01-f3c4-4dc9-85fd-97eb7bd0910e)

![TotalAll](https://github.com/Manisha20Kumawat/Hotwax_SQL_Workshop/assets/142007598/82481aae-1d7a-47b2-8be8-022b276a1fbb)

### Update Your City
UPDATE Address
SET City = 'NewCityName'
WHERE PinCode = (
    SELECT PinCode 
    FROM User 
    WHERE UserId = 1
);

### Query Output
![Address](https://github.com/Manisha20Kumawat/Hotwax_SQL_Workshop/assets/142007598/bbd7ec2a-92a3-4915-b2bb-6f72513f14dd)

![Update City](https://github.com/Manisha20Kumawat/Hotwax_SQL_Workshop/assets/142007598/70621f5a-6e74-4b1c-960d-11b5805870b6)

### Change Product Description
SELECT * FROM Products
WHERE ProductId = 1;

UPDATE Products
SET ProductDescription = 'New Product Description'  
WHERE ProductId = 1;

SELECT * FROM Products
WHERE ProductId = 1;

### Query Output
![Product Description](https://github.com/Manisha20Kumawat/Hotwax_SQL_Workshop/assets/142007598/0a968162-28d7-47de-bf67-a1e91b39f01e)

![Change Product Description](https://github.com/Manisha20Kumawat/Hotwax_SQL_Workshop/assets/142007598/95eae023-7821-4773-8093-ad647eb51910)

### Display Returnable Products
SELECT 
    ProductId,
    ProductName,
    ProductDescription
FROM 
    Products 
WHERE 
    ProductReturnable = 'Yes';
    
### Query Output
![Returnable](https://github.com/Manisha20Kumawat/Hotwax_SQL_Workshop/assets/142007598/44e56d4f-5969-4955-a9ce-2b6ae69f6c7c)


















