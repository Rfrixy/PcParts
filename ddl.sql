-- DATABASE CREATION
use Stud;
drop database T_25_i;
create database T_25_i;

use T_25_i;

-- Table Creation

CREATE TABLE dbo.Address(
AddressID int IDENTITY NOT NULL PRIMARY KEY,
House_No varchar(100) NOT NULL,
Street varchar(100) NOT NULL,
City varchar(100) NOT NULL,
Country varchar(100) NOT NULL,
Zipcode varchar(10) NOT NULL,
Latitude Decimal(8,6) NOT NULL,
Longitude Decimal(9,6) NOT NULL
);

CREATE TABLE dbo.Store(
StoreID int IDENTITY NOT NULL PRIMARY KEY ,
AddressID int NOT NULL
REFERENCES Address(AddressID),
StartedAt date NOT NULL,
StoreName varchar(40) NOT NULL
);

CREATE TABLE dbo.Person(
PersonID int IDENTITY  NOT NULL PRIMARY KEY ,
AddressID int NOT NULL
REFERENCES Address(AddressID),
LastName varchar(40) NOT NULL,
FirstName varchar(40) NOT NULL,
Email varchar(100) NOT NULL,
EncryptedPhone varbinary(250)
);

CREATE TABLE dbo.Customer(
CustomerID int IDENTITY NOT NULL PRIMARY KEY ,
PersonID int NOT NULL
REFERENCES Person(PersonID),
StartedAt date NOT NULL
);

CREATE TABLE dbo.Staff(
StaffID int IDENTITY  NOT NULL PRIMARY KEY ,
StoreID int  NOT NULL
REFERENCES Store(StoreID),
PersonID int  NOT NULL
REFERENCES Person(PersonID),
Designation varchar(40) NOT NULL,
StartedAt date NOT NULL,
EndedAt date 
);

CREATE TABLE dbo.Orders(
OrderID int IDENTITY NOT NULL PRIMARY KEY,
CustomerID int NOT NULL
REFERENCES Customer(CustomerID),
StoreId int NOT NULL
REFERENCES Store(StoreId),
OrderDate datetime DEFAULT Current_Timestamp
);

CREATE TABLE dbo.Part
(
PartID int IDENTITY NOT NULL PRIMARY KEY,
Description varchar(2500) ,
LaunchedAt date,
Name varchar(240) NOT NULL,
PartType varchar(40) ,
Manufacturer varchar(40) NOT NULL,
ModelNumber varchar(40) NOT NULL,
PowerConsumed int,
);


CREATE TABLE dbo.OrderPart
(
OrderPartID int IDENTITY NOT NULL PRIMARY KEY,
OrderID int NOT NULL
REFERENCES dbo.Orders(OrderID),
PartID int NOT NULL
REFERENCES dbo.Part(PartID),
Quantity int NOT NULL CHECK(Quantity>0)
);

CREATE TABLE dbo.Stock
(
StockID int IDENTITY NOT NULL PRIMARY KEY,
PartID int NOT NULL
REFERENCES dbo.Part(PartID),
StoreID int NOT NULL
REFERENCES dbo.Store(StoreID),
Quantity int NOT NULL CHECK(Quantity>-1)
);

CREATE TABLE dbo.Price
(
PriceID int IDENTITY NOT NULL PRIMARY KEY,
PartID int FOREIGN KEY REFERENCES Part(PartID) ,
StartedAt date NOT NULL,
EndedAt date,
CostPrice money NOT NULL  CHECK(CostPrice>0),
SalePrice money NOT NULL CHECK(SalePrice>0)
);

CREATE TABLE Motherboard (
    PartID int NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES Part(PartID),
    RamSlots int ,
    SataSlots int,
    GpuSlots int,
    NvmeSlots int,
    MotherboardType varchar(200),
    );
    
CREATE TABLE CPU (
    PartID int NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES Part(PartID),
    Clockspeed varchar(40) ,
    ChipSize varchar(40),
    CacheSize varchar(40),
    );

CREATE TABLE MotherboardCPU (
    MotherboardCPUID int IDENTITY NOT NULL PRIMARY KEY ,
    MotherboardPartID int NOT NULL FOREIGN KEY REFERENCES Motherboard(PartID) ,
    CPUPartID int NOT NULL FOREIGN KEY REFERENCES CPU(PartID),
    );
 
CREATE TABLE RAM (
    PartID int NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES Part(PartID),
    Memory varchar(40),
    Clockspeed varchar(40),
    RamSlotsUsed varchar(40),
    RamType varchar(40)
    );
   
CREATE TABLE PSU (
    PartID int NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES Part(PartID),
    Voltage int,
    Weight varchar(40),
    );
   
CREATE TABLE GPU (
    PartID int NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES Part(PartID),
    GpuSlotsUsed int ,
    Vram  varchar(40),
    ClockSpeed varchar(40),
    );
    
CREATE TABLE Storage (
    PartID int NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES Part(PartID),
    NvmeSlotsUsed int,
    SataSlotsUsed int,
    Diskspeed varchar(250),
    Diskspace varchar(250),
    );
   
CREATE TABLE PC (
    PcID int IDENTITY NOT NULL PRIMARY KEY ,
    Name varchar(250),
    RAM int FOREIGN KEY REFERENCES RAM(PartID),
    PSU int FOREIGN KEY REFERENCES PSU(PartID),
    GPU int FOREIGN KEY REFERENCES GPU(PartID),
    Storage int FOREIGN KEY REFERENCES Storage(PartID),
    MotherboardCPU int FOREIGN KEY REFERENCES MotherboardCPU(MotherboardCPUID)
    );
    
    
CREATE TABLE UseCases (
    UseCaseID int IDENTITY NOT NULL PRIMARY KEY,
    Name varchar(250),
    Description varchar(2000)
    );  
    
CREATE TABLE PCUseCases (
    PcID int NOT NULL FOREIGN KEY REFERENCES PC(PcId)  ,
    UseCaseID int NOT NULL FOREIGN KEY REFERENCES UseCases(UseCaseID),
    CONSTRAINT PK_PCUseCases PRIMARY KEY (PcID,UseCaseID)
    );
    
use Stud;
   