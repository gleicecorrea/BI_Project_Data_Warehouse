-- EMPLOYEE TABLE
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


-- SUPPLIERS TABLE
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


-- CARRIER TABLE
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


-- VEHICLE TABLE
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


-- DESTINATION TABLE
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


-- PRODUCT TABLE
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


-- ORDER_TRANSACTION TABLE
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
