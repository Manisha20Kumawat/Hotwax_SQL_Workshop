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

![orders](https://github.com/Manisha20Kumawat/Hotwax_SQL_Workshop/assets/142007598/8d7c4706-1ebe-4902-afa8-3f5ede0d7e16)

