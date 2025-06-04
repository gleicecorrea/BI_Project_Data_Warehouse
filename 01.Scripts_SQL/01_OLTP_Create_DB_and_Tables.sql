
-- DISTRIBUTION CENTER DATABSE
-- CREATE DATABASE DC_OLTP;
USE DC_OLTP;


-- EMPLOYEE TABLE
CREATE TABLE Employee (
	ID_Employee INT PRIMARY KEY IDENTITY,
	Full_Name NVARCHAR(100),
	Job_Title NVARCHAR(100),
	HireDate DATE,
	Phone_Number NVARCHAR(20),
	Email NVARCHAR(100)
);


-- SUPPLIER TABLE
CREATE TABLE Supplier (
	ID_Supplier INT PRIMARY KEY IDENTITY,
	Trade_Name NVARCHAR(100),
	Contact_Name NVARCHAR(100)
);


-- PRODUCT
CREATE TABLE Product (
    ID_Product INT PRIMARY KEY IDENTITY,
	ID_Supplier INT,
    Product_Name NVARCHAR(100),
    Category NVARCHAR(50),
    Unit_Price DECIMAL(10,2),
    FOREIGN KEY (ID_Supplier) REFERENCES Supplier(ID_Supplier)
);


-- CARRIER (TRANSPORT COMPANY)
CREATE TABLE Carrier (
    ID_Carrier INT PRIMARY KEY IDENTITY,
    Carrier_Name NVARCHAR(100),
    Phone NVARCHAR(20)
);


-- VEHICLE
CREATE TABLE Vehicle (
    ID_Vehicle INT PRIMARY KEY IDENTITY,
	ID_Carrier INT,
    License_Plate CHAR(7) UNIQUE,
    Model NVARCHAR(50), 
    FOREIGN KEY (ID_Carrier) REFERENCES Carrier(ID_Carrier)
);


-- DESTINATION
CREATE TABLE Destination (
    ID_Destination INT PRIMARY KEY IDENTITY,
    LocationName NVARCHAR(100),
    Address NVARCHAR(200),
    City NVARCHAR(100),
    State CHAR(2)
);


-- ORDERS (RECEIPT OR SHIPMENT)
CREATE TABLE Order_Transaction (
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
	FOREIGN KEY (ID_Product) REFERENCES Product(ID_Product),
	FOREIGN KEY (ID_Supplier) REFERENCES Supplier(ID_Supplier),
	FOREIGN KEY (ID_Employee) REFERENCES Employee(ID_Employee),
	FOREIGN KEY (ID_Vehicle) REFERENCES Vehicle(ID_Vehicle),
	FOREIGN KEY (ID_Carrier) REFERENCES Carrier(ID_Carrier),
	FOREIGN KEY (ID_Destination) REFERENCES Destination(ID_Destination)
);
