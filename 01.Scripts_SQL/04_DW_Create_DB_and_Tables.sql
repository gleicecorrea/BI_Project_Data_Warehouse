
CREATE DATABASE DC_DW
USE DC_DW;



-- DIMENSION SUPPLIER
CREATE TABLE dim_Supplier (
    SK_Supplier INT PRIMARY KEY IDENTITY,
    ID_Supplier INT NOT NULL,
    Trade_Name NVARCHAR(100),
    Contact_Name NVARCHAR(100),
    Start_Date DATE,
    End_Date DATE,
    Is_Current BIT
);

-- DIMENSION EMPLOYEE
CREATE TABLE dim_Employee (
    SK_Employee INT PRIMARY KEY IDENTITY,
    ID_Employee INT NOT NULL,
    Full_Name NVARCHAR(100),
    Job_Title NVARCHAR(100),
    HireDate DATE,
    Phone_Number NVARCHAR(20),
    Email NVARCHAR(100),
    Start_Date DATE,
    End_Date DATE,
    Is_Current BIT
);


-- DIMENSION PRODUCT
CREATE TABLE dim_Product (
    SK_Product INT PRIMARY KEY IDENTITY,
    ID_Product INT NOT NULL,
    Product_Name NVARCHAR(100),
    Category NVARCHAR(50),
    Unit_Price DECIMAL(10,2),
    ID_Supplier INT NOT NULL,
    Start_Date DATE,
    End_Date DATE,
    Is_Current BIT
);


-- DIMENSION CARRIER
CREATE TABLE dim_Carrier (
    SK_Carrier INT PRIMARY KEY IDENTITY,
    ID_Carrier INT NOT NULL,
    Carrier_Name NVARCHAR(100),
    Phone NVARCHAR(20),
    Start_Date DATE,
    End_Date DATE,
    Is_Current BIT
);

-- DIMENSION VEHICLE
CREATE TABLE dim_Vehicle (
    SK_Vehicle INT PRIMARY KEY IDENTITY,
    ID_Vehicle INT NOT NULL,
    License_Plate CHAR(7),
    Model NVARCHAR(50),
    ID_Carrier INT NOT NULL,
    Start_Date DATE,
    End_Date DATE,
    Is_Current BIT
);


-- DIMENSION DESTINATION
CREATE TABLE dim_Destination (
    SK_Destination INT PRIMARY KEY IDENTITY,
    ID_Destination INT NOT NULL,
    LocationName NVARCHAR(100),
    Address NVARCHAR(200),
    City NVARCHAR(100),
    State CHAR(2),
    Start_Date DATE,
    End_Date DATE,
    Is_Current BIT
);


-- DIMENSION DATE
CREATE TABLE dim_Date (
    SK_Date INT PRIMARY KEY IDENTITY (1,1),
    Full_Date DATE,
    Year INT,
    Month INT,
    Day INT,
    Weekday_Name NVARCHAR(20),
    CONSTRAINT UQ_dim_Date UNIQUE (Full_Date)
);


-- FACT TABLE
CREATE TABLE fact_Order (
    SK_Fact INT PRIMARY KEY IDENTITY (1,1),
    SK_Product INT,
    SK_Supplier INT,
    SK_Employee INT,
    SK_Carrier INT,
    SK_Destination INT,
	SK_Vehicle INT,
    SK_Date INT,
    Order_Type NVARCHAR(10), -- INBOUND | OUTBOUND
    Quantity INT,
    Unit_Price DECIMAL(10,2),
    Total_Value AS (Quantity * Unit_Price) PERSISTED,
    FOREIGN KEY (SK_Product) REFERENCES dim_Product(SK_Product),
    FOREIGN KEY (SK_Supplier) REFERENCES dim_Supplier(SK_Supplier),
    FOREIGN KEY (SK_Employee) REFERENCES dim_Employee(SK_Employee),
    FOREIGN KEY (SK_Carrier) REFERENCES dim_Carrier(SK_Carrier),
    FOREIGN KEY (SK_Destination) REFERENCES dim_Destination(SK_Destination),
	FOREIGN KEY (SK_Vehicle) REFERENCES dim_Vehicle(SK_Vehicle),
    FOREIGN KEY (SK_Date) REFERENCES dim_Date(SK_Date)
);


