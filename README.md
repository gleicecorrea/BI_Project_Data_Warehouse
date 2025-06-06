# BI Project Data Warehouse: OLTP, Staging, ETL and SCD Type 2 with SSIS

This project simulates the data structure of a Distribution Center (DC), covering the creation of a transactional environment based on OLTP (Online Transaction Processing), progressing through the Staging layer, and culminating in the modeling of a Data Warehouse (DW). It also includes the use of ETL processes with SSIS to automate data integration, the implementation of Incremental Load for efficient data loading, and the application of SCD (Slowly Changing Dimension) techniques to manage historical changes in dimension tables.
 
---

# OBJECTIVE

Demonstrate, in practice, the full operation of the main stages in building and handling a relational and analytical database, using:

- **OLTP model** for operational transactions  
- **Staging area** for raw data  
- **Data Warehouse (OLAP)** using a star schema with fact and dimension tables  
- **ETL process with SSIS** for data integration and transformation  
- **Incremental Load** to populate the tables  
- **Type 2 SCD** to store the full history of changes in dimension tables  


---


## Index
This project is structured into 5 steps:

- **Step 1** -> Creation of the transactional environment (OLTP) in SQL  
- **Step 2** -> Implementation of the Staging area in SQL  
- **Step 3** -> Modeling and creation of the Data Warehouse (DW) in SQL  
- **Step 4** -> Development of the ETL process using SSIS  
- **Step 5** -> Connection with Power BI and creation of graphical visualizations  

---


## Step 1 – OLTP Creation: Operational Database (DC_OLTP)

Normalized modeling of the main entities:  
- Employee, Supplier, Product, Carrier, Vehicle, Destination, Order_Transaction  
- Use of primary and foreign keys  
- Manual data insertion into tables  

# 
### Creation of the Database and Tables in OLTP

``` bash
CREATE DATABASE DC_OLTP;
USE DC_OLTP;
```

EMPLOYEE TABLE:

``` bash
CREATE TABLE Employee (
	ID_Employee INT PRIMARY KEY IDENTITY,
	Full_Name NVARCHAR(100),
	Job_Title NVARCHAR(100),
	HireDate DATE,
	Phone_Number NVARCHAR(20),
	Email NVARCHAR(100)
);
```

SUPPLIER TABLE:
``` bash
CREATE TABLE Supplier (
	ID_Supplier INT PRIMARY KEY IDENTITY,
	Trade_Name NVARCHAR(100),
	Contact_Name NVARCHAR(100)
);
```
PRODUCT TABLE:
``` bash
CREATE TABLE Product (
    ID_Product INT PRIMARY KEY IDENTITY,
	ID_Supplier INT,
    Product_Name NVARCHAR(100),
    Category NVARCHAR(50),
    Unit_Price DECIMAL(10,2),
    FOREIGN KEY (ID_Supplier) REFERENCES Supplier(ID_Supplier)
);
```

CARRIER TABLE (TRANSPORT COMPANY):
``` bash
CREATE TABLE Carrier (
    ID_Carrier INT PRIMARY KEY IDENTITY,
    Carrier_Name NVARCHAR(100),
    Phone NVARCHAR(20)
);
```


VEHICLE TABLE:
``` bash
CREATE TABLE Vehicle (
    ID_Vehicle INT PRIMARY KEY IDENTITY,
	ID_Carrier INT,
    License_Plate CHAR(7) UNIQUE,
    Model NVARCHAR(50), 
    FOREIGN KEY (ID_Carrier) REFERENCES Carrier(ID_Carrier)
);
```

DESTINATION TABLE:
``` bash
CREATE TABLE Destination (
    ID_Destination INT PRIMARY KEY IDENTITY,
    LocationName NVARCHAR(100),
    Address NVARCHAR(200),
    City NVARCHAR(100),
    State CHAR(2)
);
```

ORDERS TABLE:
``` bash
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
```

# 
### Manual Data Insertion into OLTP Tables
Fictitious data was inserted to simulate:  
- Product inbound and outbound orders  
- Logistic movements between vehicles, suppliers, and destinations  

EMPLOYEE TABLE:

``` bash
INSERT INTO Employee (Full_Name, Job_Title, HireDate, Phone_Number, Email) VALUES
('Ana Silva', 'Manager', '2020-01-15', '11999990000', 'ana.silva@example.com'),
('Carlos Souza', 'Warehouse Worker', '2021-06-10', '11988880000', 'carlos.souza@example.com'),
('Beatriz Lima', 'Accountant', '2019-03-12', '11977770000', 'beatriz.lima@example.com'),
('Diego Martins', 'Sales Rep', '2022-02-20', '11966660000', 'diego.martins@example.com'),
('Elisa Costa', 'HR Specialist', '2018-11-05', '11955550000', 'elisa.costa@example.com'),
('Fabio Oliveira', 'Logistics Coordinator', '2017-07-07', '11944440000', 'fabio.oliveira@example.com'),
('Gisele Santos', 'Customer Service', '2023-01-10', '11933330000', 'gisele.santos@example.com'),
('Henrique Ramos', 'Technician', '2020-06-17', '11922220000', 'henrique.ramos@example.com'),
('Isabela Fernandes', 'Marketing Analyst', '2019-09-23', '11911110000', 'isabela.fernandes@example.com'),
('João Pedro', 'Warehouse Worker', '2021-08-15', '11900000000', 'joao.pedro@example.com'),
('Karen Almeida', 'Quality Analyst', '2022-04-01', '11899990000', 'karen.almeida@example.com'),
('Lucas Pereira', 'Driver', '2018-12-12', '11888880000', 'lucas.pereira@example.com'),
('Mariana Dias', 'Sales Rep', '2020-10-30', '11877770000', 'mariana.dias@example.com'),
('Nicolas Silva', 'Inventory Manager', '2017-03-22', '11866660000', 'nicolas.silva@example.com'),
('Olivia Rocha', 'Receptionist', '2019-07-19', '11855550000', 'olivia.rocha@example.com');
```

SUPPLIER TABLE:
``` bash
INSERT INTO Supplier (Trade_Name, Contact_Name) VALUES
('Music Supply Co.', 'João Lima'),
('Instrumentos BR', 'Maria Fernanda'),
('Sound Pro Ltda', 'Paulo Mendes'),
('Guitar World', 'Carla Souza'),
('Rhythm Masters', 'Ricardo Alves'),
('Note Perfect', 'Sofia Oliveira'),
('Tune Up', 'Felipe Costa'),
('Beat It', 'Ana Paula'),
('String Kings', 'Marcos Silva'),
('Sound Waves', 'Renata Almeida'),
('Harmony Corp', 'Daniel Santos'),
('Melody Store', 'Juliana Ribeiro'),
('Acoustic Hub', 'Fabiana Lima'),
('Bassline Ltda', 'Lucas Fernandes'),
('Drum House', 'Patricia Martins');
```
PRODUCT TABLE:
``` bash
INSERT INTO Product (ID_Supplier, Product_Name, Category, Unit_Price) VALUES
(1, 'Guitar', 'Instruments', 1500.00),
(2, 'Drum Set', 'Instruments', 2300.00),
(3, 'Microphone', 'Accessories', 300.00),
(4, 'Amplifier', 'Electronics', 1200.00),
(5, 'Piano', 'Instruments', 5000.00),
(6, 'Violin', 'Instruments', 2500.00),
(7, 'Headphones', 'Accessories', 150.00),
(8, 'Keyboard', 'Instruments', 2000.00),
(9, 'Speaker', 'Electronics', 800.00),
(10, 'Mixer', 'Electronics', 900.00),
(11, 'Drumsticks', 'Accessories', 50.00),
(12, 'Cables', 'Accessories', 40.00),
(13, 'Sheet Music', 'Accessories', 30.00),
(14, 'Guitar Strings', 'Accessories', 20.00),
(15, 'Bass Guitar', 'Instruments', 1800.00);
```

CARRIER TABLE (TRANSPORT COMPANY):
``` bash
INSERT INTO Carrier (Carrier_Name, Phone) VALUES
('TransLogistics', '1133334444'),
('FastShip', '1144445555'),
('Speedy Transport', '1155556666'),
('Cargo Express', '1166667777'),
('MoveFast Ltda', '1177778888'),
('ShipRight', '1188889999'),
('QuickMove', '1199990000'),
('Direct Freight', '1100001111'),
('RoadRunners', '1111112222'),
('SafeHaul', '1122223333'),
('Eagle Transport', '1133334445'),
('BlueLine Logistics', '1144445556'),
('GreenWay Cargo', '1155556667'),
('Prime Movers', '1166667778'),
('Ace Transport', '1177778889');
```


VEHICLE TABLE:
``` bash
INSERT INTO Vehicle (ID_Carrier, License_Plate, Model) VALUES
(1, 'ABC1234', 'Truck Model A'),
(2, 'XYZ9876', 'Van Model B'),
(3, 'DEF5678', 'Truck Model C'),
(4, 'GHI3456', 'Van Model D'),
(5, 'JKL7890', 'Truck Model E'),
(6, 'MNO2345', 'Van Model F'),
(7, 'PQR6789', 'Truck Model G'),
(8, 'STU0123', 'Van Model H'),
(9, 'VWX4567', 'Truck Model I'),
(10, 'YZA8901', 'Van Model J'),
(11, 'BCD2345', 'Truck Model K'),
(12, 'EFG6789', 'Van Model L'),
(13, 'HIJ0123', 'Truck Model M'),
(14, 'KLM4567', 'Van Model N'),
(15, 'NOP8901', 'Truck Model O');
```

DESTINATION TABLE:
``` bash
INSERT INTO Destination (LocationName, Address, City, State) VALUES
('Warehouse SP', 'Rua das Flores, 123', 'São Paulo', 'SP'),
('Distribution RJ', 'Av. Brasil, 456', 'Rio de Janeiro', 'RJ'),
('Warehouse MG', 'Av. Central, 789', 'Belo Horizonte', 'MG'),
('Distribution PR', 'Rua Paraná, 101', 'Curitiba', 'PR'),
('Warehouse RS', 'Av. das Gaúchas, 202', 'Porto Alegre', 'RS'),
('Distribution BA', 'Rua Bahia, 303', 'Salvador', 'BA'),
('Warehouse PE', 'Av. Recife, 404', 'Recife', 'PE'),
('Distribution CE', 'Rua Ceará, 505', 'Fortaleza', 'CE'),
('Warehouse SC', 'Av. Santa Catarina, 606', 'Florianópolis', 'SC'),
('Distribution GO', 'Rua Goiás, 707', 'Goiânia', 'GO'),
('Warehouse ES', 'Av. Espírito Santo, 808', 'Vitória', 'ES'),
('Distribution AM', 'Rua Amazonas, 909', 'Manaus', 'AM'),
('Warehouse PA', 'Av. Pará, 1001', 'Belém', 'PA'),
('Distribution RJ2', 'Rua Rio de Janeiro, 1102', 'Rio de Janeiro', 'RJ'),
('Warehouse SP2', 'Av. São Paulo, 1203', 'São Paulo', 'SP');
```

ORDERS TABLE:
``` bash
INSERT INTO Order_Transaction (Order_Number, ID_Product, ID_Supplier, ID_Employee, ID_Vehicle, ID_Carrier, ID_Destination, Order_Type, Order_Date, Quantity, Unit_Price) VALUES
('ORD001', 1, 1, 1, 1, 1, 1, 'INBOUND', '2023-05-01', 10, 1500.00),
('ORD002', 2, 2, 2, 2, 2, 2, 'OUTBOUND', '2023-05-02', 5, 2300.00),
('ORD003', 3, 3, 3, 3, 3, 3, 'INBOUND', '2023-05-03', 15, 300.00),
('ORD004', 4, 4, 4, 4, 4, 4, 'OUTBOUND', '2023-05-04', 7, 1200.00),
('ORD005', 5, 5, 5, 5, 5, 5, 'INBOUND', '2023-05-05', 3, 5000.00),
('ORD006', 6, 6, 6, 6, 6, 6, 'OUTBOUND', '2023-05-06', 8, 2500.00),
('ORD007', 7, 7, 7, 7, 7, 7, 'INBOUND', '2023-05-07', 12, 150.00),
('ORD008', 8, 8, 8, 8, 8, 8, 'OUTBOUND', '2023-05-08', 9, 2000.00),
('ORD009', 9, 9, 9, 9, 9, 9, 'INBOUND', '2023-05-09', 6, 800.00),
('ORD010', 10, 10, 10, 10, 10, 10, 'OUTBOUND', '2023-05-10', 4, 900.00),
('ORD011', 11, 11, 11, 11, 11, 11, 'INBOUND', '2023-05-11', 20, 50.00),
('ORD012', 12, 12, 12, 12, 12, 12, 'OUTBOUND', '2023-05-12', 25, 40.00),
('ORD013', 13, 13, 13, 13, 13, 13, 'INBOUND', '2023-05-13', 30, 30.00),
('ORD014', 14, 14, 14, 14, 14, 14, 'OUTBOUND', '2023-05-14', 40, 20.00),
('ORD015', 15, 15, 15, 15, 15, 15, 'INBOUND', '2023-05-15', 11, 1800.00);
```


# 
### Relationships Between Tables in OLTP
An **ER diagram** was created to visually represent the relationships between tables, allowing validation of the logical connections in the model.

![image](https://github.com/user-attachments/assets/7fdc8ae6-6df7-47ff-8e97-7bcbe254a599)

---


## Step 2 – Creation of the STAGING Area: Transition Layer (DC_STG)
- Replica of the OLTP tables  
- No primary or foreign keys, since it is a temporary data storage table  
- Data will not be manually inserted into these tables, as they will be loaded automatically via **SSIS**  
- Allows transformation and validation before entering the DW  


### Creation of Tables in STAGING


``` bash
CREATE DATABASE DC_STG;
USE DC_STG;
CREATE SCHEMA stg;
```

STAGING EMPLOYEE TABLE
``` bash
CREATE TABLE stg.Employee (
	ID_Employee INT PRIMARY KEY IDENTITY,
	Full_Name NVARCHAR(100),
	Job_Title NVARCHAR(100),
	HireDate DATE,
	Phone_Number NVARCHAR(20),
	Email NVARCHAR(100)
);
```

STAGING SUPPLIER TABLE
``` bash
CREATE TABLE stg.Supplier (
	ID_Supplier INT PRIMARY KEY IDENTITY,
	Trade_Name NVARCHAR(100),
	Contact_Name NVARCHAR(100)
);
```

STAGING PRODUCT
``` bash
CREATE TABLE stg.Product (
    ID_Product INT PRIMARY KEY IDENTITY,
	ID_Supplier INT,
    Product_Name NVARCHAR(100),
    Category NVARCHAR(50),
    Unit_Price DECIMAL(10,2),
    FOREIGN KEY (ID_Supplier) REFERENCES stg.Supplier(ID_Supplier)
);
```
STAGING CARRIER (TRANSPORT COMPANY)
``` bash
CREATE TABLE stg.Carrier (
    ID_Carrier INT PRIMARY KEY IDENTITY,
    Carrier_Name NVARCHAR(100),
    Phone NVARCHAR(20)
);
```

STAGING VEHICLE
``` bash
CREATE TABLE stg.Vehicle (
    ID_Vehicle INT PRIMARY KEY IDENTITY,
	ID_Carrier INT,
    License_Plate CHAR(7) UNIQUE,
    Model NVARCHAR(50), 
    FOREIGN KEY (ID_Carrier) REFERENCES stg.Carrier(ID_Carrier)
);
```

STAGING DESTINATION
``` bash
CREATE TABLE stg.Destination (
    ID_Destination INT PRIMARY KEY IDENTITY,
    LocationName NVARCHAR(100),
    Address NVARCHAR(200),
    City NVARCHAR(100),
    State CHAR(2)
);
```
STAGING ORDERS (RECEIPT OR SHIPMENT)
``` bash
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
```

---


## Step 3 – Creation of the Data Warehouse (DC_DW)

### Dimensional modeling with:  
- **Dimension** tables: dim_Product, dim_Supplier, dim_Employee, dim_Carrier, dim_Destination, dim_Date  
- **Fact** table: fact_Order  


### Characteristics:
- **Surrogate Keys**: artificial primary keys generated in the DW to improve performance and track history  
- **Natural Key**: original key values from the OLTP are maintained  
- Creation of the columns “Start_Date”, “End_Date”, and “Is_Current” (a flag indicating whether the record is current) to control record updates in the tables  
- Calculation of measures such as total_value in the fact table  
- Creation of the date dimension table  

### Creation of Tables in the DW

``` bash
CREATE DATABASE DC_DW
USE DC_DW;
```
DIMENSION SUPPLIER

``` bash
CREATE TABLE dim_Supplier (
    SK_Supplier INT PRIMARY KEY IDENTITY,
    ID_Supplier INT NOT NULL,
    Trade_Name NVARCHAR(100),
    Contact_Name NVARCHAR(100),
    Start_Date DATE,
    End_Date DATE,
    Is_Current BIT
);
```
DIMENSION EMPLOYEE

``` bash
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
```
DIMENSION PRODUCT

``` bash
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
```
DIMENSION CARRIER

``` bash
CREATE TABLE dim_Carrier (
    SK_Carrier INT PRIMARY KEY IDENTITY,
    ID_Carrier INT NOT NULL,
    Carrier_Name NVARCHAR(100),
    Phone NVARCHAR(20),
    Start_Date DATE,
    End_Date DATE,
    Is_Current BIT
);
```
DIMENSION VEHICLE

``` bash
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
```
DIMENSION DESTINATION

``` bash
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
```
DIMENSION DATE

``` bash
CREATE TABLE dim_Date (
    SK_Date INT PRIMARY KEY IDENTITY (1,1),
    Full_Date DATE,
    Year INT,
    Month INT,
    Day INT,
    Weekday_Name NVARCHAR(20),
    CONSTRAINT UQ_dim_Date UNIQUE (Full_Date)
);
```

FACT TABLE
``` bash
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
```



### Relationships Between Tables in the DW  
**ER Diagram**


![image](https://github.com/user-attachments/assets/e05a9d79-8624-40f6-ac7a-ce376631ac9e)


---


## Summary of what we have so far
- Three databases have been created (DC_OLTP, DC_STG, and DC_DW)  
- Data has only been manually inserted into the OLTP  


  ![image](https://github.com/user-attachments/assets/4ead1c67-19cc-44de-ad48-a93c1b085ad5)


---

## Step 4 – Visual Studio
### General overview of what we will do in Visual Studio:
Create a Data Flow in SSIS to move data from OLTP → STAGING → DW, applying:

- Incremental load (only new or changed data)  
- Type 2 SCD on dimension tables  


### Overview of the Flow (3-Layer Architecture):
 
``` bash
                         -->   [DW - DIMENSIONS]
 [OLTP] --> [STAGING] --| 
                         -->   [DW - FACTS]
``` 

---

### 1) CREATION OF A NEW PROJECT
![image](https://github.com/user-attachments/assets/8ebada86-b945-4ccc-b1ac-702992bd5e31)


---


### 2) CREATION OF A NEW CONECTION
![image](https://github.com/user-attachments/assets/c7977602-a051-4e80-86fa-148ce1f968a8)

# 

 ### 2.a) Setting up the New Connection
![image](https://github.com/user-attachments/assets/1214e6b2-b773-48fb-8ddd-7d386cb712e9)

# 

### 2.b) Renaming the New Connection
![image](https://github.com/user-attachments/assets/cfff9782-622f-44e1-b9a4-84dd6d28542f)


![image](https://github.com/user-attachments/assets/9154ba4e-4360-4b6b-95ec-e0e824c1f0f3)

Connection renamed.

---


### 3) CREATION AND SETUP OF THE FIRST PACKAGE (OLTP_STAGING)
**In this step, we will extract data from the transactional system (OLTP) and load it into the Staging layer tables of the Data Warehouse.**

Techniques and key points:

- Full Load: In this package, we use the strategy of truncating and reloading the staging tables at each execution.  
- To build this package, we will use the following SSIS components:  
  - OLE DB Source  
  - OLE DB Destination  
  - SQL Task  


**Creating and Renaming a New Package:**

![image](https://github.com/user-attachments/assets/b2023b07-08cc-40b9-a409-ff03b8fb5435)

# 

  ### 3.A) 1st PACKAGE (OLTP_STAGING) – Creation of the Data Flow Task
![image](https://github.com/user-attachments/assets/b15c3fcd-ca8e-44d1-b143-83f2203cc464)

Rename it to "DFT_OLTP_STG" as shown in the image above.


Double-click on "DFT_OLTP_STG" to open the Data Flow:
![image](https://github.com/user-attachments/assets/332a41e0-2da5-444f-9d49-8dcba9aa142d)

# 

 ### 3.B) 1st PACKAGE (OLTP_STAGING) – Component Configuration in the Data Flow:
We will need an "OLE DB Source" component, which will use the "DC_OLTP" database as the data source, and an "OLE DB Destination" component, which will define where the data will be loaded — the "DC_STG" database.

![image](https://github.com/user-attachments/assets/5e17d83e-3b5f-47df-a1f0-496b932a962c)


 ### 3.B.a) 1st PACKAGE (OLTP_STAGING) – OLE DB Source Configuration  
Point it to the "DC_OLTP" database.
![image](https://github.com/user-attachments/assets/5e8f0896-c788-4504-82f1-241267174f41)



### 3.B.b) 1st PACKAGE (OLTP_STAGING) – OLE DB Destination Configuration  
Before configuring the OLE DB Destination, we need to create a new connection for the STAGING database:

![image](https://github.com/user-attachments/assets/c185562d-0d1c-4fd4-a8a5-405807526121)

And the OLE DB Destination configuration is as follows:  
(Point it to the "DC_STG" database.)


![image](https://github.com/user-attachments/assets/73b64af9-abfe-4c47-849e-8f28d6178936)


### 3.B.c) 1st PACKAGE (OLTP_STAGING) – Replicating for the Other Tables  
Once the first model is created, simply repeat the process for all the other tables:  
- Carrier  
- Destination  
- Product  
- Supplier  
- Vehicle  
- Order_Transaction  

![image](https://github.com/user-attachments/assets/d7f6f399-f4f7-4f99-8112-4b67a56f15e7)

# 


### 3.C) 1st PACKAGE (OLTP_STAGING) – Truncating Staging Tables with Execute SQL Task  
In the Control Flow environment, add the "Execute SQL Task" component and rename it as shown in the image below.

![image](https://github.com/user-attachments/assets/66b33362-7420-485f-a2e8-fe187f1b5df5)

Using the SQLStatement, we add the queries responsible for cleaning the data in the tables as shown in the image below.  
This will ensure the staging tables are always cleared before receiving new data.


![image](https://github.com/user-attachments/assets/2a287457-aef3-4b4f-a0c0-0535ac7b517c)

---


### 4) CREATION AND SETUP OF THE SECOND PACKAGE (STAGING_DW_DIMENSION)  
**In this package, we will load data from the Staging tables into the dimension tables of the Data Warehouse (such as dim_Employee, dim_Product, etc.), while maintaining change history.**

Techniques and key points:

- Detect changes in dimensions and insert new or updated data using Slowly Changing Dimension Type 2 (**SCD Type 2**)  
- To build this package, we will use the following SSIS components:  
  - OLE DB Source  
  - OLE DB Destination  
  - Lookup  
  - Conditional Split  
  - Derived Column  
  - OLE DB Command  

**Creating and Renaming a New Package:**

  ![image](https://github.com/user-attachments/assets/d0e87d6a-2bed-4266-8586-499ae329c7fe)

# 

### 4.A) 2nd PACKAGE (STAGING_DW_DIMENSION) – General Data Flow  
To better understand the data flow we will build in this package, here is a screenshot of the completed flow for one table — in this case, the Employee table.


![image](https://github.com/user-attachments/assets/6e22ae05-1a55-4028-a330-6fe7b331ff94)

# 

### 4.B) 2nd PACKAGE (STAGING_DW_DIMENSION) – New Connection "DC_DW"  
We will establish the third and final connection between SSIS and SQL.

   ![image](https://github.com/user-attachments/assets/300099be-7052-4d61-8998-e157db2bce0c)

# 

### 4.C) 2nd PACKAGE (STAGING_DW_DIMENSION) – Lookup Component  

The following 3 images show how the Lookup configuration was done:


![image](https://github.com/user-attachments/assets/80165376-d8c5-45ec-8704-5ffc862950ba)

Here we apply a "WHERE Is_Current = 1" filter to retrieve only the data that is currently in use.

![image](https://github.com/user-attachments/assets/187955c0-522f-4815-9af8-6e9c1e685367)

The Lookup will work as a join between the staging and dw_dimension tables using the ID_Employee column:

![image](https://github.com/user-attachments/assets/fb9e0cd1-f735-496d-9b84-ff182bb210c2)

It is good practice to rename the columns coming from the Lookup with the "LKP_" prefix.

# 

### 4.D) 2nd PACKAGE (STAGING_DW_DIMENSION) – Derived Column

The rows that didn’t match in the Lookup — meaning they are new records — move to this step, where we use the **Derived Column** component.  
Here, we will create 3 new columns for the staging table: Start_Date, End_Date, and Is_Current, where:

- Start_Date will be set to the current date using GETDATE()  
- End_Date will be set to NULL  
- Is_Current will be set to 1 to indicate that this is the most current (active) record  

![image](https://github.com/user-attachments/assets/6078c3f2-42ac-4c49-943f-7b75a18cb90f)

Once this is done, we insert the new records from staging into the dimension table:

Connetion Manager:

![image](https://github.com/user-attachments/assets/b605b488-9530-4ef1-8176-3d03204e3b54)

Mappings:

![image](https://github.com/user-attachments/assets/8b39575c-a084-4ded-99e9-576ee9af5fcd)

# 

### 4.E) 2nd PACKAGE (STAGING_DW_DIMENSION) – Conditional Split

The rows that matched in the Lookup (i.e., already existed in the DW) reach the Conditional Split component.  
Here, we split the data flow into two paths: ChangedRows and UnchangedRows.  
To do this, we define the following two conditions:  
- ChangedRows:


```bash
(TRIM(ISNULL(Full_Name) ? "" : Full_Name) != TRIM(ISNULL(LKP_Full_Name) ? "" : LKP_Full_Name))
||
(TRIM(ISNULL(Job_Title) ? "" : Job_Title) != TRIM(ISNULL(LKP_Job_Title) ? "" : LKP_Job_Title))
||
(TRIM(ISNULL(Phone_Number) ? "" : Phone_Number) != TRIM(ISNULL(LKP_Phone_Number) ? "" : LKP_Phone_Number))
||
(TRIM(ISNULL(Email) ? "" : Email) != TRIM(ISNULL(LKP_Email) ? "" : LKP_Email))
```

 - UnchangedRows  ->  TRUE

In the first condition (ChangedRows), we compare the columns that are subject to updates—such as phone, email, and (maiden) name—from the staging table with the dimension columns (from the Lookup), checking if there is at least one change in the data.

We also handle null values and whitespace:  
- ISNULL(...) ? "" :  → If the value is NULL, it is replaced with an empty string.  
- TRIM(...) → Removes leading and trailing spaces.

In the second condition (UnchangedRows), we discard rows that have no changes.


![image](https://github.com/user-attachments/assets/0be59cd4-405d-4377-9b9c-886bfd76eb41)


# 

### 4.F) 2nd PACKAGE (STAGING_DW_DIMENSION) – OLE DB Command

<img src="![image](https://github.com/user-attachments/assets/6cc748a9-94f1-4e6c-8cd5-d027c046f4a1)" width="48">

This is where the rows to be updated go.  
We use the SQL UPDATE command to update the dimension table, as shown in the images below:


Connection Managers:

![image](https://github.com/user-attachments/assets/81240e7c-3c3c-4bfb-bb90-71154f9ffb57)

Component Properties:

![image](https://github.com/user-attachments/assets/fc52c797-4630-40cf-922c-56b49b1174ec)

Column Mappings:

![image](https://github.com/user-attachments/assets/0bd2ae02-2d1d-4f0b-9c32-ecaa637cd36d)

# 

### 4.G) 2nd PACKAGE (STAGING_DW_DIMENSION) – Derived Column and Final Insert

In this step, we build the same logic process that was done in step 4.D.


![image](https://github.com/user-attachments/assets/49e780a4-1d52-4a52-95b4-b5bc816d8a8a)

# 

### 4.H) 2nd PACKAGE (STAGING_DW_DIMENSION) – Component Organization and Distribution

We completed the entire process for the Employee table; now just apply the same logic to the other tables.

We organized the Data Flow to avoid overloading the environment, using 1 Data Flow for every 2 tables:


![image](https://github.com/user-attachments/assets/e5ac0a68-6d3a-42cb-ba09-db17d27db669)

Control Flow:

![image](https://github.com/user-attachments/assets/94f3e721-0c3d-472d-bc0a-f2fe5d6961bc)


---


### 5) CREATION OF THE THIRD PACKAGE (STAGING_DW_FACT)

In this package, we will load data from the table DC_STG.stg.Order_Transaction into the fact table DC_DW.dbo.Fact_Order.

**Creating and Renaming a New Package:**


  ![image](https://github.com/user-attachments/assets/704b0f64-8911-4342-a4d8-2f62efe0bb38)

# 


### 5.A) 3rd PACKAGE (STAGING_DW_FACT) – General Data Flow


![image](https://github.com/user-attachments/assets/2f32ba81-1b3b-47e1-8463-576024cfc681)

# 

### 5.B) 3° PACOTE (STAGING_DW_FACT) - OLDB Source

Para trazer a tabela que servirá como origem dos dados dessa etapa do processo utlizamos uma query em SQL para conseguir filtrar por Order_Date e trazer somente os dados mais recentes.

![image](https://github.com/user-attachments/assets/f400070f-4ef8-4e1d-a30a-1a708fa82716)


![image](https://github.com/user-attachments/assets/a7684752-763e-4da9-97b2-2d36d1e30318)

# 

### 5.B) 3rd PACKAGE (STAGING_DW_FACT) – OLE DB Source

To bring in the table that will serve as the data source for this step of the process, we use a SQL query to filter by Order_Date and retrieve only the most recent data.

![image](https://github.com/user-attachments/assets/53787846-1a97-4fa4-a842-037693480b00)


![image](https://github.com/user-attachments/assets/3fddc859-8531-4436-834c-5f4c2d84d333)

We do this for all Dimension tables.


### 5.D) 3rd PACKAGE (STAGING_DW_FACT) – Final Load into the Fact Table


![image](https://github.com/user-attachments/assets/8f0a499e-6983-4a94-ac14-ce38ca47b8ca)


---


### 6) CREATION OF THE MASTER PACKAGE

Creating a new package:


![image](https://github.com/user-attachments/assets/9855198e-c78c-492e-9157-55b2392436bc)

# 

### 6.A) MASTER PACKAGE – Execute Package Task


![image](https://github.com/user-attachments/assets/a6d74b5b-a81c-4623-abf3-5652a91de5e6)

Select each specific package in the order they should be executed.

![image](https://github.com/user-attachments/assets/a227500f-13cd-42e5-a3e3-d83441a67181)


---

## Best Practices Adopted in This Project

### SQL
- Names in **snake_case**, without accents or spaces  
- Tables named in **singular**  
- Prefixes by layer: dim_, fact_, stg_  
- Consistent patterns to improve readability and maintainability

### SSIS
- Standardized naming for component identifiers, including what the component relates to  
  e.g.: DFT_OLTP_STG (Data Flow Task to move data from OLTP to STG).




