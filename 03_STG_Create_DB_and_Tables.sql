

CREATE DATABASE DC_STG;
USE DC_STG;
CREATE SCHEMA stg;


-- STAGING EMPLOYEE TABLE
CREATE TABLE stg.Employee (
	ID_Employee INT PRIMARY KEY IDENTITY,
	Full_Name NVARCHAR(100),
	Job_Title NVARCHAR(100),
	HireDate DATE,
	Phone_Number NVARCHAR(20),
	Email NVARCHAR(100)
);


-- STAGING SUPPLIER TABLE
CREATE TABLE stg.Supplier (
	ID_Supplier INT PRIMARY KEY IDENTITY,
	Trade_Name NVARCHAR(100),
	Contact_Name NVARCHAR(100)
);


-- STAGING PRODUCT
CREATE TABLE stg.Product (
    ID_Product INT PRIMARY KEY IDENTITY,
	ID_Supplier INT,
    Product_Name NVARCHAR(100),
    Category NVARCHAR(50),
    Unit_Price DECIMAL(10,2),
    FOREIGN KEY (ID_Supplier) REFERENCES stg.Supplier(ID_Supplier)
);


-- STAGING CARRIER (TRANSPORT COMPANY)
CREATE TABLE stg.Carrier (
    ID_Carrier INT PRIMARY KEY IDENTITY,
    Carrier_Name NVARCHAR(100),
    Phone NVARCHAR(20)
);


-- STAGING VEHICLE
CREATE TABLE stg.Vehicle (
    ID_Vehicle INT PRIMARY KEY IDENTITY,
	ID_Carrier INT,
    License_Plate CHAR(7) UNIQUE,
    Model NVARCHAR(50), 
    FOREIGN KEY (ID_Carrier) REFERENCES stg.Carrier(ID_Carrier)
);


-- STAGING DESTINATION
CREATE TABLE stg.Destination (
    ID_Destination INT PRIMARY KEY IDENTITY,
    LocationName NVARCHAR(100),
    Address NVARCHAR(200),
    City NVARCHAR(100),
    State CHAR(2)
);


-- STAGING ORDERS (RECEIPT OR SHIPMENT)
CREATE TABLE stg.Order_Transaction (
	ID_Order INT PRIMARY KEY IDENTITY,
	Order_Number NVARCHAR(50), 
	ID_Product INT,
	ID_Supplier INT,
	ID_Employee INT,
	ID_Vehicle INT,
	ID_Carrier INT,
	ID_Destination INT,
	Order_Type NVARCHAR(10), -- 'INBOUND' or 'OUTBOUND'
	Order_Date DATE,
	Quantity INT,
	Unit_Price DECIMAL(10,2),
	Total_Value AS (Quantity * Unit_Price) PERSISTED,
	FOREIGN KEY (ID_Product) REFERENCES stg.Product(ID_Product),
	FOREIGN KEY (ID_Supplier) REFERENCES stg.Supplier(ID_Supplier),
	FOREIGN KEY (ID_Employee) REFERENCES stg.Employee(ID_Employee),
	FOREIGN KEY (ID_Vehicle) REFERENCES stg.Vehicle(ID_Vehicle),
	FOREIGN KEY (ID_Carrier) REFERENCES stg.Carrier(ID_Carrier),
	FOREIGN KEY (ID_Destination) REFERENCES stg.Destination(ID_Destination)
);


TRUNCATE TABLE stg.Order_Transaction;
TRUNCATE TABLE stg.Destination;
TRUNCATE TABLE stg.Vehicle;
TRUNCATE TABLE stg.Carrier;
TRUNCATE TABLE stg.Product;
TRUNCATE TABLE stg.Supplier;
TRUNCATE TABLE stg.Employee;