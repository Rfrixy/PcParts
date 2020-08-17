use stud;
use T_25_i;
--- >>>>>> Data insertion

--  >>>>> Encryption on phone number
--Create DMK
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'Test_password';
--Create certificate to protect stmmetrick key
CREATE CERTIFICATE TestCertificate
WITH SUBJECT = 'TestCertificate',
EXPIRY_DATE = '2021-1-1';
--Create SymmetricKey to encrypt data
CREATE Symmetric Key TestSymmetricKey
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE TestCertificate;
--Open stmmetrick key
OPEN SYMMETRIC KEY TestSymmetricKey
DECRYPTION BY CERTIFICATE TestCertificate;


SET IDENTITY_INSERT dbo.Address ON;
INSERT dbo.Address (AddressId, House_No, Street, City, Country, Zipcode, Latitude, Longitude)
VALUES (101,'1','Lincoln Street', 'Boston', 'United State', '02111',42.352519, -71.0584282)
	,(102,'2','Lincoln Street', 'Somerville', 'United State', '02145',42.386605, -71.080666)
	,(103,'4','Yarmouth Street', 'Boston', 'United State', '02116',42.345532, -71.076373)
	,(104,'153','Hemenway Street', 'Boston', 'United State', '02115',42.341806, -71.090777)
	,(105,'16','Allston Street', 'Boston', 'United State', '02134',42.352571, -71.134806)
	,(106,'358R','Cambridge Street', 'Cambridge', 'United State', '02141',42.371038, -71.082149)
	,(107,'20','Child Street', 'Cambridge', 'United State', '02141',42.371514, -71.071800)
	,(108,'240','Medford Street', 'Charlestown', 'United State', '02129',42.380253, -71.062545)
	,(109,'128','Cambridge Street', 'Boston', 'United State', '02129',42.382398, -71.080454)
	,(110,'7','Otis Street', 'Somerville', 'United State', '02145',42.388376, -71.087046)
	,(111,'421-457','E 8th Street', 'Boston', 'United State', '02127',42.331693, -71.043620)
	,(112,'152','Old Colony Ave', 'Boston', 'United State', '02127',42.335108, -71.054374)
	,(113,'32','George Street', 'Roxbury', 'United State', '02119',42.327363, -71.074134)
	,(114,'126','Zeigler Street', 'Boston', 'United State', '02119',42.329476, -71.079875)
	,(115,'35','S Huntington Ave', 'Boston', 'United State', '02130',42.330649, -71.111467)
	,(116,'35-199','Welland Road', 'Brookline', 'United State', '02445',42.334488, -71.128548)
	,(117,'118','Babcock Street', 'Brookline', 'United State', '02446',42.347828, -71.122122)
	,(118,'250-196','Lexington Street', 'Boston', 'United State', '02128',42.379624, -71.031957)
	,(119,'10','Oxford Street', 'Boston', 'United State', '02111',42.352158, -71.060246)
	,(120,'59','Queensberry Street', 'Boston', 'United State', '02215',42.342682, -71.098127)
	,(121,'198-94','Bartlett Street', 'Boston', 'United State', '02129',42.378577, -71.065979)
	,(122,'387','Revolution Drive', 'Somerville', 'United State', '02145',42.391345, -71.079088)
	,(123,'1-99','Malvern Ave', 'Somerville', 'United State', '02144',42.400094, -71.128952)
	,(124,'40','Williams Street', 'Brookline', 'United State', '02446',42.343189, -71.126010)
	,(125,'15-23','Horadan Way', 'Boston', 'United State', '02120',42.333950, -71.098034)
	,(126,'61','Mt Pleasant Ave', 'Boston', 'United State', '02119',42.326143, -71.079407)
	,(127,'11','Ave de lafayette', 'Boston', 'United State', '02111',42.352809, -71.060299)
	,(128,'150-150A','Salem Street', 'Boston', 'United State', '02113',42.365750, -71.055451)
	,(129,'198-94','Bartlett Street', 'Boston', 'United State', '02129',42.378577, -71.065979)
	,(130,'387','Revolution Drive', 'Somerville', 'United State', '02145',42.391345, -71.079088)
	,(131,'1-99','Malvern Ave', 'Somerville', 'United State', '02144',42.400094, -71.128952)
	,(132,'40','Williams Street', 'Brookline', 'United State', '02446',42.343189, -71.126010)
	,(133,'15-23','Horadan Way', 'Boston', 'United State', '02120',42.333950, -71.098034)
	,(134,'61','Mt Pleasant Ave', 'Boston', 'United State', '02119',42.326143, -71.079407)
	,(135,'11','Ave de lafayette', 'Boston', 'United State', '02111',42.352809, -71.060299)
	,(136,'150-150A','Salem Street', 'Boston', 'United State', '02113',42.365750, -71.055451);
SET IDENTITY_INSERT dbo.Address OFF;

--- Figure this out later and make phone number not null again
-- Current issue: phone numbers are all set as NULL
SET IDENTITY_INSERT dbo.Person ON;
INSERT dbo.Person (PersonId, AddressId, LastName, FirstName, Email, EncryptedPhone)
VALUES (1,101,'Sanchez','Rick','sr@gmail.com'
		,EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'611-224-3445')))
	,(2,102,'Smith','Morty','sm@gmail.com'
		,EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'617-015-3164')))
	,(3,103,'Smith','Summer','ss@gmail.com'
		,EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'646-368-7523')))
	,(4,104,'Smith','Beth','sb@gmail.com'
		,EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'973-452-0114')))
	,(5,105,'Smith','Jerry','sj@gmail.com'
		,EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'954-387-9759')))
	,(6,106,'Cartman','Eric','ce@gmail.com'
		,EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'378-780-6304')))
	,(7,107,'McCormick','Kenny','mk@gmail.com'
		,EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'888-054-4210')))
	,(8,108,'Broflovski','Kyle','bk@gmail.com'
		,EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'401-896-6341')))
	,(9,109,'Marsh','Stan','ms@gmail.com'
		,EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'857-357-1212')))
	,(10,110,'Black','Token','bt@gmail.com'
		,EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'787-302-5090')))
	,(11,111,'Tucker','Craig','tc@gmail.com'
		,EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'447-578-9456')))
	,(12,112,'Stotch','Butters','sbu@gmail.com'
		,EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'886-252-8756')))
	,(13,113,'Tweak','Tweak','tt@gmail.com'
		,EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'613-417-1214')))
	,(14,114,'Testaburger','Wendy','tw@gmail.com'
		,EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'656-885-8524')))
	,(15,115,'Cartman','Liane','cl@gmail.com'
		,EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'789-574-1474')))
	,(16,116,'Stotch','Linda','cl@gmail.com'
		,EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'878-335-1001')))
	,(17,117,'Marsh','Sharon','msh@gmail.com'
		,EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'401-426-0021')))
	,(18,118,'Broflovski','Sheila','bsh@gmail.com'
		,EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary,'646-302-3434')));

SET IDENTITY_INSERT dbo.Person OFF;

SET IDENTITY_INSERT dbo.Customer ON;
INSERT dbo.Customer (CustomerId, PersonId, StartedAt)
VALUES (1,1,'5-21-2008')
	,(2,2,'5-11-2015')
	,(3,3,'9-23-2014')
	,(4,4,'10-20-2016')
	,(5,5,'1-10-2009')
	,(6,6,'11-1-2008')
	,(7,7,'6-1-2017')
	,(8,8,'12-31-2003')
	,(9,9,'3-15-2007')
	,(10,10,'6-8-2009');
SET IDENTITY_INSERT dbo.Customer OFF;

SET IDENTITY_INSERT dbo.Store ON;
INSERT dbo.Store (StoreId, AddressId, StartedAt, StoreName)
VALUES (1,119, '1-1-2008', 'Good PC Store')
	,(2,120, '11-1-2006', 'Epic PC Store')
	,(3,121, '7-1-2000', 'Great PC Store')
	,(4,122, '9-1-2001', 'Best PC Store')
	,(5,123, '1-1-2008', 'Good PC Store II')
	,(6,124, '3-1-2003', 'Nice PC Store')
	,(7,125, '2-1-2005', 'Ok PC Store')
	,(8,126, '11-1-2004', 'Fantastic PC Store')
	,(9,127, '1-1-2008', 'Good PC Store III')
	,(10,128, '3-1-2008', 'Good PC Store IV');
SET IDENTITY_INSERT dbo.Store OFF;
	
SET IDENTITY_INSERT dbo.Staff ON;
INSERT dbo.Staff (StaffId, StoreId, PersonId, Designation, StartedAt, EndedAt)
VALUES (801,1, 9, 'Sales Person', '1-1-2008', '1-1-2019')
	,(802,2, 10, 'Sales Person', '11-1-2006', '1-1-2020')
	,(803,3, 11, 'Sales Person', '7-1-2000',NULL)
	,(804,4, 12, 'Sales Person', '9-1-2001',NULL)
	,(805,5, 13, 'Sales Person', '1-1-2008',NULL)
	,(806,6, 14, 'Sales Person', '3-1-2003', '3-1-2017')
	,(807,7, 15, 'Sales Person', '2-1-2005', '4-1-2018')
	,(808,8, 16, 'Sales Person', '11-1-2004',NULL)
	,(809,9, 17, 'Sales Person', '1-1-2008',NULL)
	,(810,10, 18, 'Sales Person', '4-1-2008',NULL);
SET IDENTITY_INSERT dbo.Staff OFF;


SET IDENTITY_INSERT dbo.Part ON;
INSERT dbo.Part (PartID, [Name], LaunchedAt, PartType, [Description], Manufacturer, ModelNumber, PowerConsumed)
VALUES 
(1,'Intel Core i7-10700K','4-2-2020','CPU', 'Intel Core i7-10700K Comet Lake 8-Core 3.8 GHz LGA 1200 
	125W BX8070110700K Desktop Processor Intel UHD Graphics 630', 'Intel','i7-10700K',125)
	,(2,'AMD RYZEN 5 2600X','4-12-2018','CPU', 'AMD RYZEN 5 2600X 6-Core 3.6 GHz (4.2 GHz Max Boost)
	 Socket AM4 95W YD260XBCAFBOX Desktop Processor', 'AMD','RYZEN 5 2600X',95)
	,(3,'Intel Core i7-9700K','10-8-2018','CPU', 'Intel Core i7-9700K Coffee Lake 8-Core 3.6 GHz (4.9 GHz Turbo)
	 	LGA 1151 (300 Series) 95W BX80684I79700K Desktop Processor Intel UHD Graphics 630'
		, 'Intel','i7-9700K',95)
	,(4,'Intel Core i9-9900K','10-8-2018','CPU', 'Intel Core i9-9900K Coffee Lake 8-Core, 16-Thread, 3.6 GHz (5.0 GHz Turbo)
		 LGA 1151 (300 Series) 95W BX80684I99900K Desktop Processor Intel UHD Graphics 630'
		, 'Intel','i9-9900K',95)
	,(5,'MSI ProSeries Intel B365','10-10-2018','Motherboard', '8th and 9th gen Intel motherboard with LGA 1151 Socket. Supports DDR4 ram upto 2666 Mhz'
		, 'MSI','B365M PRO-VH',0)
	,(6,'ZOTAC Gaming GeForce GTX 1660 6GB','12-10-2019','GPU', 'Dual SLot, 4k Ready, 3x DisplayPort and 1x HDMI. Suitable for 60 fps at 1080p'
		, 'Nvidia','ZT-T16600K-10M',120)
	,(7,'Cooler Master MWE 550','01-06-2020','PSU', 'White 550W 80+ White PSU w/Hydro-Dynamic-Bearing Silent 120mm Fan, Single +12V Rail, Flat Black Cables'
		, 'Coolermaster','MWE 550', -550)
	,(8,'Corsair Vengeance RGB PRO 16GB','05-21-2018','RAM', 'Corsair Vengeance RGB PRO 16GB (2x8GB) DDR4 3200MHz C16 LED Desktop Memory - Black, CMW16GX4M2C3200C16'
		, 'Corsair','CMW16GX4M2C3200C16', 0)
	,(9,'Samsung SSD 860','01-22-2018','Storage', 'Samsung SSD 860 EVO 1TB 2.5 Inch SATA III Internal SSD (MZ-76E1T0B/AM)'
		, 'Corsair','CMW16GX4M2C3200C16', 0)
			,(101,'GeForce RTX 2070 SUPER','8-28-2019','GPU', '3 x WINDFORCE Fans, 8GB 256-Bit GDDR6'
		, 'Nvidia','GV-N207SWF3OC-8GD',235)
	,(102,'MSI GeForce RTX 2060','3-5-2019','GPU', '6GB 192-Bit GDDR6 PCI Express 3.0 x16 HDCP'
		, 'Nvidia','RTX 2060 VENTUS XS 6G OC',160)
	,(103,'Radeon RX 5700 XT ','9-19-2019','GPU', 'Overclocked 8G GDDR6 HDMI'
		, 'AMD','ROG-STRIX-RX5700XT-O8G-GAMING',225)
	,(104,'EVGA GeForce RTX 2070 SUPER','6-28-2019','GPU', '8GB GDDR6'
		, 'Nvidia','08G-P4-3071-KR',215)
	,(105,'Radeon RX 570','10-11-2018','GPU', '4GB 256-Bit GDDR5 PCI Express 3.0 x16 HDCP'
		, 'AMD','RX570 4G',150)
	,(106,'EVGA GeForce RTX 2060 KO','1-10-2020','GPU', 'GDDR6, Dual Fans, Metal Backplate'
		, 'Nvidia','06G-P4-2068-KR',190)
	,(107,'Radeon RX 5700 XT OC','8-15-2019','GPU', 'C 8G Graphics Card, PCIe 4.0, 8GB 256-Bit GDDR6'
		, 'AMD','GV-R57XTGAMING OC-8GD',225)
	,(108,'MSI GeForce RTX 2070 FROZR','1-7-2020','GPU', 'DirectX 12 RTX 2070 TRI FROZR 8GB 256-Bit GDDR6 PCI Express 3.0 x16 HDCP'
		, 'Nvidia','RTX 2070 TRI FROZR',175)
	,(109,'EVGA GeForce RTX 2070 SUPER XC','6-28-2019','GPU', '8GB GDDR6, Dual HDB Fans, RGB LED, Metal Backplate'
		, 'Nvidia','08G-P4-3173-KR',215)
	,(110,'Ryzen 9 3950X','11-25-2019','CPU', '6-Core 3.5 GHz Socket AM4 105W', 'AMD','100-100000051WOF',105)
	,(111,'AMD RYZEN 5 2600X','7-2-2019','CPU', '12-Core 3.8 GHz (4.6 GHz Max Boost) Socket AM4', 'AMD','100-100000023BOX',105)
	,(112,'Ryzen 7 3800X','7-2-2019','CPU', '8-Core 3.9 GHz (4.5 GHz Max Boost) Socket AM4'
		, 'AMD','100-100000025BOX',105)
	,(113,'Ryzen 7 3700X','7-2-2019','CPU', '8-Core 3.6 GHz (4.4 GHz Max Boost) Socket AM4'
		, 'AMD','100-100000071BOX',65)
	,(114,'Ryzen 5 3600X','7-2-2019','CPU', '6-Core 3.8 GHz (4.4 GHz Max Boost) Socket AM4'
		, 'AMD','100-100000022BOX',95)
	,(115,'Core i5-9400','3-22-2019','CPU', '6-Core 2.9 GHz (4.1 GHz Turbo) LGA 1151 (300 Series) 65W'
		, 'Intel','BX80684I59400',95)
	,(116,'ASUS ROG Strix B550-F ','6-12-2020','Motherboard', ' (3rd Gen Ryzen) ATX Gaming Motherboard (PCIe 4.0, 2.5Gb LAN, BIOS FlashBack, HDMI 2.1, Addressable Gen 2 RGB Header and AURA Sync)'
		, 'ASUS','STRIX B550-F GAMING (WI-FI)',0)
	,(117,'MSI MAG B550M','6-15-2020','Motherboard', 'SATA 6Gb/s'
		, 'MSI','MAG B550M BAZOOKA',0)
	,(118,'ASUS ROG STRIX B450-F','7-23-2018','Motherboard', 'SATA 6Gb/s'
		, 'ASUS','STRIX B450-F GAMING',0)
	,(119,'ASUS AM4 TUF Gaming X570-Plus (Wi-Fi)','7-7-2018','Motherboard', 'with PCIe 4.0, Dual M.2, 12+2 with Dr. MOS Power Stage, HDMI, DP, SATA 6Gb/s, USB 3.2 Gen 2 and Aura Sync RGB Lighting'
		, 'ASUS','TUF GAMING X570-PLUS (Wi-Fi)',0)
	,(120,'GIGABYTE B450M DS3H','7-26-2018','Motherboard', 'SATA 6Gb/s'
		, 'GIGABYTE','B450M DS3H',0)
	,(121,'ASUS ROG STRIX Z490-F ','4-23-2018','Motherboard', 'LGA 1200 (Intel 10th Gen) Intel Z490 SATA 6Gb/s ATX Intel Motherboard (16 Power Stages, DDR4 4800, Intel 2.5Gb Ethernet, USB 3.2 Front Panel Type-C, Dual M.2 and AURA Sync)'
		, 'ASUS','STRIX Z490-F GAMING',0)
	,(122,'ASUS Prime Z390-A LGA 1151','10-8-2018','Motherboard', '8 SATA 6Gb/s'
		, 'ASUS','Prime Z390-A',0)
	,(123,'ASUS ROG STRIX Z490-E','4-23-2020','Motherboard', 'LGA 1200 (Intel 10th Gen) Intel Z490 (WiFi 6) SATA 6Gb/s ATX Intel Motherboard (14+2 Power Stages, DDR4 4600, Intel 2.5 Gb Ethernet, Bluetooth v5.1, Dual M.2 and AURA Sync)'
		, 'ASUS','STRIX Z490-E GAMING',0)
	,(124,'MSI MPG Z490 GAMING EDGE WIFI LGA 1200 Intel Z490','4-23-2020','Motherboard', 'SATA 6Gb/s ATX'
		, 'MSI','MPG Z490 GAMING EDGE WIFI',0);
SET IDENTITY_INSERT dbo.Part OFF;

	
SET IDENTITY_INSERT dbo.Price ON;
INSERT dbo.Price
(PriceId, PartID, CostPrice, SalePrice, StartedAt, EndedAt)
Values 
(1, 1, 350, 410, '3-2-2020', NULL),
(2, 2, 100, 140, '04-19-2018', NULL),
(3, 3, 300, 330, '11-23-2018', NULL),
(4, 4, 400, 440, '3-2-2018', NULL),
(5, 5, 60, 70, '10-10-2018', NULL),
(6, 6, 189, 230, '12-10-2019', NULL),  
(7, 7, 50, 69, '01-06-2020', NULL),
(8, 8, 69, 89, '05-21-2018', NULL),
(9, 9, 100, 113, '01-22-2018', NULL)
,(101, 101, 450, 459.99, '8-28-2019', NULL)
,(102, 102, 300, 339.99, '3-5-2019', NULL)
,(103, 103, 450, 499.99, '9-19-2019', NULL)
,(104, 104, 500, 534.99, '6-28-2019', NULL)
,(105, 105, 100, 129.99, '10-11-2018', NULL)
,(106, 106, 300, 329.99, '1-10-2020', NULL)
,(107, 107, 400, 409.99, '8-15-2019', NULL)
,(108, 108, 400, 439.99, '1-7-2020', NULL)
,(109, 109, 550, 569.99, '6-28-2019', NULL)
,(110, 110, 660, 699.99, '11-25-2019', NULL)
,(111, 111, 400, 429.99, '7-2-2019', NULL)
,(112, 112, 300, 339.99, '7-2-2019', NULL)
,(113, 113, 250, 284.99, '7-2-2019', NULL)
,(114, 114, 200, 214.99, '7-2-2019', NULL)
,(115, 115, 160, 168.99, '3-22-2019', NULL)
,(116, 116, 200, 209.99, '6-12-2020', NULL)
,(117, 117, 120, 129.99, '6-15-2020', NULL)
,(118, 118, 120, 129.99, '7-23-2018', NULL)
,(119, 119, 180, 189.99, '7-7-2018', NULL)
,(120, 120, 70, 74.99, '7-26-2018', NULL)
,(121, 121, 250, 269.99, '4-23-2018', NULL)
,(122, 122, 170, 179.99, '10-8-2018', NULL)
,(123, 123, 280, 299.99, '4-23-2020', NULL)
,(124, 124, 190, 199.99, '4-23-2020', NULL);
SET IDENTITY_INSERT dbo.Price OFF;



-- Specifc parts begin here :---------

INSERT dbo.MotherBoard 
(PartID, RamSlots, SataSlots, GpuSlots, NvmeSlots, MotherboardType)
Values 
(5, 4, 1, 1, 0, 'Micro ATX')
,(116, 4, 6, 1, 1, 'ATX')
,(117, 4, 6, 1, 1, 'Micro ATX')
,(118, 4, 4, 1, 1, 'ATX')
,(119, 4, 8, 1, 1, 'ATX')
,(120, 4, 4, 1, 1, 'Micro ATX')
,(121, 4, 6, 1, 1, 'ATX')
,(122, 4, 6, 1, 1, 'ATX')
,(123, 4, 6, 1, 1, 'ATX')
,(124, 4, 6, 1, 1, 'ATX');



INSERT dbo.CPU 
(PartID, Clockspeed, ChipSize, CacheSize)
VALUES
(1, '3.8 Ghz', '14nm', '16M'),
(2, '3.6 Ghz', '12nm', '16M'),
(3, '3.6 Ghz', '14nm', '12M'),
(4, '3.6 Ghz', '14nm', '16M' ),
(110, '3.5 Ghz', '7nm', '64M'),
(111, '3.8 Ghz', '7nm', '64M'),
(112, '3.9 Ghz', '7nm', '32M'),
(113, '3.6 Ghz', '7nm', '32M'),
(114, '3.8 Ghz', '7nm', '32M'),
(115, '3.6 Ghz', '14nm', '9M')
;


SET IDENTITY_INSERT dbo.MotherboardCPU ON;
INSERT dbo.MotherboardCPU 
(MotherboardCPUID, MotherboardPartID, CPUPartID)
VALUES
(1, 5, 3),
(2, 5, 4)
,(103, 121, 2)
,(104, 121, 3)
,(105, 122, 3)
,(106, 123, 3)
,(107, 124, 3)
,(108, 121, 3)
,(109, 122, 115)
,(110, 123, 115)
,(101, 124, 115)
;
SET IDENTITY_INSERT dbo.MotherboardCPU OFF;

 
INSERT dbo.GPU 
(PartID, GpuSlotsUsed, Vram, Clockspeed)
VALUES
(6, 1, '6 GB', '1785 Mhz')
,(101,1, '8 GB', '1785 Mhz')
,(102,1, '6 GB', '1710 Mhz')
,(103,1, '8 GB', '2010 Mhz')
,(104,1, '8 GB', '1770 Mhz')
,(105,1, '4 GB', '1244 Mhz')
,(106,1, '6 GB', '1755 Mhz')
,(107,1, '8 GB', '1905 Mhz')
,(108,1, '8 GB', '1620 Mhz')
,(109,1, '8 GB', '1800 Mhz')
;



INSERT dbo.PSU 
(PartID, Voltage, [Weight])
VALUES
(7, 12,  '1.7 kg')
;


INSERT dbo.RAM 
(PartID, Memory, Clockspeed, RamSlotsUsed, RamType)
VALUES
(8, '16 GB', '3200 MHz', 2, 'DDR4')
;


INSERT dbo.Storage 
(PartID, NvmeSlotsUsed, SataSlotsUsed, Diskspeed, Diskspace)
VALUES
(9, 0, 1, '520 MB/s', '1 TB')
;



SET IDENTITY_INSERT dbo.Stock ON;
INSERT dbo.Stock (StockId, PartId, StoreId, Quantity)
VALUES (1, 3, 1, 100)
	, (2, 3, 2, 20)
	, (3, 3, 3, 30)
	, (4, 3, 4, 10)
	, (5, 4, 1, 100)
	, (6, 4, 2, 20)
	, (7, 4, 3, 30)
	, (8, 4, 4, 10)
	, (9, 2, 1, 30)
	, (10, 2, 2, 10)
	, (101, 115, 4, 30)
	, (102, 124, 4, 10)
	, (103, 105, 4, 30)
	, (104, 105, 3, 10)
	, (105, 116, 3, 30)
	, (106, 124, 3, 10);
SET IDENTITY_INSERT dbo.Stock OFF;


SET IDENTITY_INSERT dbo.Orders ON;
INSERT dbo.Orders (OrderId, CustomerId, StoreId, OrderDate)
VALUES (1,1,2,'4-2-2020')
	, (2,1,2, '4-22-2020')
	, (3,2,3, '4-2-2020')
	, (4,4,3, '4-8-2020')
	, (5,5,9, '4-2-2020')
	, (6,6,6, '5-12-2020')
	, (7,6,5, '6-10-2020')
	, (8,7,7, '7-2-2020')
	, (9,6,9, '4-2-2020')
	, (10,1,9, '6-2-2020')
	, (101,10,4, '7-2-2020')
	, (102,7,4, '4-2-2020')
	, (103,9,3, '6-2-2020')
	, (104,10,3, '6-2-2020');
SET IDENTITY_INSERT dbo.Orders OFF;

--(xx,orderID, partID, quantity)
SET IDENTITY_INSERT dbo.OrderPart ON;
INSERT dbo.OrderPart (OrderPartId, OrderId, PartId, Quantity)
VALUES (1,1,1,2)
	,(2,2,3,1)
	,(3,3,2,1)
	,(4,4,3,2)
	,(5,5,4,3)
	,(6,6,1,1)
	,(7,7,2,1)
	,(8,8,1,1)
	,(9,9,3,2)
	,(10,10,4,2)
	,(11,10,1,1)
	,(101,101,124,2)
	,(102,102,105,1)
	,(103,103,105,2)
	,(104,103,124,1)
	,(105,104,116,2)
	,(106,101,115,2);
SET IDENTITY_INSERT dbo.OrderPart OFF ;


------------------------------ PSUs ------------------------------


SET IDENTITY_INSERT dbo.Part ON;
INSERT dbo.Part (PartID, [Name], LaunchedAt, PartType, [Description], Manufacturer, ModelNumber, PowerConsumed)
VALUES 
     (10,'Thermaltake Smart 500W','09-01-2015','PSU', 'Thermaltake Smart 500W 80+ White Certified PSU, Continuous Power with 120mm Ultra Quiet Cooling Fan, ATX 12V V2.3/EPS 12V Active PFC Power Supply PS-SPD-0500NPCWUS-W'
		, 'Thermaltake','PS-SPD-0500NPCWUS-W', -700)
	, (11,'ASUS ROG Strix 850W White','06-26-2020','PSU', 'ASUS ROG Strix 850W White Edition PSU, Power Supply (ROG heatsinks, Axial-tech Fan Design, Dual Ball Fan Bearings, 0dB Technology, 80 Plus Gold Certification, Fully Modular Cables, 10-Year Warranty)'
		, 'ASUS','ROG-STRIX-850G-WHITE', -850)
	, (12,'EVGA 600W Bronze','11-04-2016','PSU', 'EVGA 110-BQ-0600-K1 600 BQ, 80+ Bronze 600W, Semi Modular, FDB Fan, 3 Year Warranty, Power Supply'
		, 'EVGA','110-BQ-0600-K1 600 BQ', -600)
	, (13,'Gamemax 600W RGB','05-30-2019','PSU', 'Power Supply 600W Semi Modular 80+ Bronze, GAMEMAX VP-600-M-RGB'
		, 'Gamemax','VP-600-RGB', -600)
	, (14,'Corsair CX Series 550','11-16-2015','PSU', 'Corsair CX Series 550 Watt 80 Plus Bronze Certified Modular Power Supply (CP-9020102-NA)'
		, 'Corsair','CP-9020102-NA', -550)
	, (15,'Thermaltake Smart RGB 700W','08-25-2017','PSU', 'Thermaltake Smart RGB 700W 80+ 256-Color RGB Fan ATX 12V 2.3 Kaby Lake Ready Power Supply 5 Yr Warranty Power Supply PS-SPR-0700NHFAWU-1'
		, 'Thermaltake','SPR-700AH2NK-1', -700)
	, (16,'SilverStone Technology Strider 1200W','08-01-2016','PSU', 'SilverStone Technology Strider 1200W 80 Plus Platinum Modular PSU 1200 Power Supply (PS-ST1200-PT)'
		, 'SilverStone','PS-ST1200-PT', -1200)
	, (17,'CORSAIR AXi Series, AX1200i','07-27-2012','PSU', 'CORSAIR AXi Series, AX1200i, 1200 Watt, 80+ Platinum Certified, Fully Modular - Digital Power Supply'
		, 'Corsair','AX1200i', -1200)
	, (18,'Apevia ATX-PR150W','02-07-2016','PSU', 'Apevia ATX-PR150W Prestige 150W budget Power Supply'
		, 'Apevia','ATX-PR150W', -150)
SET IDENTITY_INSERT dbo.Part OFF;



SET IDENTITY_INSERT dbo.Price ON;
INSERT dbo.Price
(PriceId, PartID, CostPrice, SalePrice, StartedAt, EndedAt)
Values 
(10, 10, 42, 50, '09-01-2015', NULL)
,(11, 11, 166, 190, '06-26-2020', NULL)
,(12, 12, 72, 86, '11-04-2016', NULL)
,(13, 13, 40, 70, '05-30-2019', NULL)
,(14, 14, 75, 86, '11-16-2015', NULL)
,(15, 15, 75, 86, '08-25-2017', NULL)
,(16, 16, 200, 240, '08-01-2016', NULL)
,(17, 17, 320, 400, '07-27-2012', NULL)
,(18, 18, 20, 30, '02-07-2016', NULL)
SET IDENTITY_INSERT dbo.Price OFF;


INSERT dbo.PSU 
(PartID, Voltage, [Weight])
VALUES
(10, 120,  '1.72 kg')
,(11, 120,  '1.8 kg')
,(12, 120,  '0.45 kg')
,(13, 120,  '1.9 kg')
,(14, 120,  '1 kg')
,(15, 120,  '1.3 kg')
,(16, 120,  '4.8 kg')
,(17, 220,  '1.9 kg')
,(18, 220,  '0.81 kg')
;


------------------------------ RAMs ------------------------------


SET IDENTITY_INSERT dbo.Part ON;
INSERT dbo.Part (PartID, [Name], LaunchedAt, PartType, [Description], Manufacturer, ModelNumber, PowerConsumed)
VALUES 
	(30,'Corsair Vengeance RGB PRO 16GB','05-21-2018','RAM', 'Corsair Vengeance RGB PRO 16GB (2x8GB) DDR4 3200MHz C16 LED Desktop Memory - Black, CMW16GX4M2C3200C16'
		, 'Corsair','CMW16GX4M2C3200C16', 3)
	,(20,'Corsair Vengeance LPX 16GB','07-05-2015','RAM', 'Corsair Vengeance LPX 16GB (2x8GB) DDR4 DRAM 3000MHz C15 Desktop Memory Kit - Black (CMK16GX4M2B3000C15)'
		, 'Corsair','CMK16GX4M2B3000C15', 0)
	,(21,'Corsair Vengeance RGB PRO 32GB','07-05-2015','RAM', 'Corsair Vengeance RGB PRO 32GB (2x16GB) DDR4 3200 (PC4-25600) C16 Desktop Memory - White'
		, 'Corsair','PC4-25600', 5)
	,(22,'OLOy DDR4 RAM 16GB','01-09-2020','RAM', 'OLOy DDR4 RAM 16GB (2x8GB) 3000 MHz CL16 1.35V 288-Pin Desktop Gaming UDIMM (MD4U083016BJDA)'
		, 'OLOy','MD4U083016BJDA', 0)
	,(23,'TEAMGROUP T-Force Delta RGB','06-12-2019','RAM', 'TEAMGROUP T-Force Delta RGB DDR4 16GB (2x8GB) 3200MHz (PC4-25600) CL16 Desktop Memory Module ram TF3D416G3200HC16CDC01 - Black'
		, 'OLOy','MD4U083016BJDA', 4)
	,(24,'HyperX Fury 8GB','08-19-2019','RAM', 'HyperX Fury 8GB 2666MHz DDR4 CL16 DIMM 1Rx8  Black XMP Desktop Memory Single Stick HX426C16FB3/8'
		, 'HyperX','HX426C16FB3/8', 0)
	,(25,'Crucial Balistix 16GB','02-04-2020','RAM', 'Crucial Ballistix 3200 MHz DDR4 DRAM Desktop Gaming Memory Kit 16GB (8GBx2) CL16 BL2K8G32C16U4B (Black)'
		, 'Crucial','BL2K8G32C16U4B', 0)
	,(26,'G.SKILL Trident Z 64','10-25-2019','RAM', 'G.SKILL Trident Z Neo (for AMD Ryzen) Series 64GB (4x16GB) 288-Pin RGB DDR4 3600 (PC4 28800) DIMM F4-3600C16Q-64GTZNC'
		, 'G. Skill','B07WXML87M', 2)
	,(27,'Patriot memory','01-01-2017','RAM', 'Patriot Memory Signature Line DDR4 4GB (1x4GB) UDIMM Frequency: 2400MHz (PC4-19200) 1. 2 Volt - PSD44G240082'
		, 'Patriot','PSD44G240082', 0)
	,(28,'Patriot Viper 4 Blackout','07-02-2019','RAM', 'Patriot Viper 4 Blackout Series DDR4 8GB (2 x 4GB) 3000MHz Kit'
		, 'Patriot','PVB48G300C6K', 0)
	,(29,'Corsair Vengeance RGB PRO 128GB','01-06-2020','RAM', 'Corsair Vengeance RGB PRO 128GB (4x32GB) DDR4 3200 (PC4-25600) C16 Desktop Memory 鈥� Black (CMW128GX4M4E3200C16)'
		, 'Corsair','CMW128GX4M4E3200C16', 0)
SET IDENTITY_INSERT dbo.Part OFF;

	
SET IDENTITY_INSERT dbo.Price ON;
INSERT dbo.Price
(PriceId, PartID, CostPrice, SalePrice, StartedAt, EndedAt)
Values 
(30, 30, 69, 89, '05-21-2018', NULL)
,(20, 21, 55, 69, '05-30-2015', NULL)
,(21, 21, 110, 140, '08-24-2018', NULL)
,(22, 22, 39, 56, '01-09-2020', NULL)
,(23, 23, 50, 73, '06-12-2019', NULL)
,(24, 24, 27, 38, '08-19-2019', NULL)
,(25, 25, 57, 70, '02-04-2020', NULL)
,(26, 26, 300, 360, '10-25-2019', NULL)
,(27, 27, 12, 18, '01-01-2017', NULL)
,(28, 28, 31, 40, '07-02-2019', NULL)
,(29, 29, 580, 616, '01-06-2020', NULL)
SET IDENTITY_INSERT dbo.Price OFF;



INSERT dbo.RAM 
(PartID, Memory, Clockspeed, RamSlotsUsed, RamType)
VALUES
(30, '16 GB', '3200 MHz', 2, 'DDR4')
,(20, '16 GB', '3000 MHz', 2, 'DDR4')
,(21, '32 GB', '3200 MHz', 2, 'DDR4')
,(22, '16 GB', '3000 MHz', 2, 'DDR4')
,(23, '16 GB', '3200 MHz', 2, 'DDR4')
,(24, '8 GB', '2666 MHz', 1, 'DDR4')
,(25, '16 GB', '3200 MHz', 2, 'DDR4')
,(26, '64 GB', '3600 MHz', 4, 'DDR4')
,(27, '4 GB', '2400 MHz', 1, 'DDR4')
,(28, '8 GB', '3000 MHz', 2, 'DDR4')
,(29, '128 GB', '3200 MHz', 4, 'DDR4')
;

------------------------------ Storage ------------------------------

SET IDENTITY_INSERT dbo.Part ON;
INSERT INTO dbo.Part (PartID ,Description ,LaunchedAt ,PartType ,Name,Manufacturer ,modelNumber ,PowerConsumed ) 
VALUES (200,'Seagate Barracuda','2008-01-01','Storage','Seagate Barracuda 2 TB Internal Hard Drive HDD','Seagate','ST2000DM005',3.7)
,(201,'Seagate BarraCuda ','2017-01-01','Storage','Seagate Barracuda Model No. ST1000DM010 1TB','Seagate',' ST1000DM010',5)
,(202,'Western Digital WD10EZEX','2017-01-01','Storage','Western Digital WD10EZEX 1TB Internal Hard Drive for Desktop','Western Digital','WD10EZEX',3)
,(203,'Consistent 500 GB','2018-01-01','Storage','Consistent 500 GB SATA 3.5 Inch Desktop Internal Hard Drive with 2 Year Warranty
','Consistent ','CT3500SC',4)
,(204,'Western Digital WD Blue','2012-01-01','Storage','Western Digital WD Blue WD20EZAZ 2TB 5400 RPM 256MB Cache','Western Digital','WD20EZAZ',6)
,(205,'Toshiba 320 GB Laptop','2019-01-07','Storage','Toshiba 320 GB Laptop Internal Hard Drive','Toshiba','B07MQ1GYKX',2)
,(206,'TULMAN 2.5 Inch Transparent USB 3.0 ','2019-03-27','Storage','Tulman HDD for desktop','Tulman','TULLPUS03',6)
,(207,'HGST Ultrastar A7K2000 HUA722010CLA330','2020-01-24','Storage','HGST Ultrastar A7K2000 HUA722010CLA330 (0A39289) 1TB 32MB Cache 7200RPM SATA 3.0GB/s','HGST Ultrastar','HUA722010CLA330-0A39289',3)
,(208,'WD 320 GB AV-GP SATA 3 Gb/s','2016-10-13','Storage','WD 320 GB AV-GP SATA 3 Gb/s Intellipower 8 MB Cache Bulk/OEM AV Hard Drive- WD3200AVVS','WD','WD3200AVVS',2)
,(209,'Western Digital + Kington','2020-11-01','Storage','WD 320 GB AV-GP SATA 3 Gb/s Intellipower 8 MB Cache Bulk/OEM AV Hard Drive- WD3200AVVS + kindlston 40 gb nvme','WD+Kingston','WD3200AVVS+KGF2006789',7)

SET IDENTITY_INSERT dbo.Part OFF;


INSERT INTO Storage(PartID ,NvmeSlotsUsed ,SataSlotsUsed ,Diskspeed ,Diskspace ) 
VALUES (200,0,1,'5400RPM','2TB'),
(202,0,1,'7200RPM','1TB'),
(201,0,2,'7200RPM','1TB'),
(203,0,1,'5000RPM','500 GB'),
(204,1,1,'5400RPM','2 TB'),
(205,0,1,'3000RPM','320 GB'),
(206,0,1,'30000RPM','250 GB'),
(207,0,1,'7200RPM','1 TB'),
(208,0,2,'4000RPM','320 GB'),
(209,1,1,'4000RPM','1.2 TB');

SET IDENTITY_INSERT dbo.Price ON;
INSERT INTO Price (PartID,StartedAt ,EndedAt ,PriceID ,CostPrice ,SalePrice ) 
VALUES (200,getdate(),'2021-01-01',200,499,500),
(201,'2019-01-01','2020-01-01',201,299,400),
(202,'2019-09-01','2020-12-01',202,250,361),
(203,'2019-09-04','2020-12-01',203,150,174),
(204,'2019-04-19','2029-12-01',204,479,524),
(205,'2019-04-19','2021-01-01',205,170,199),
(206,'2020-11-01','2021-01-01',206,17,25),
(207,'2020-01-25','2021-01-01',207,345,398),
(208,'2016-01-25','2017-01-01',208,130,159),
(208,'2017-01-01','2021-01-01' ,209,230,259),
(209,'2020-11-01','2021-01-01' ,210,1230,2259);
SET IDENTITY_INSERT dbo.Price OFF;


SET IDENTITY_INSERT dbo.PC ON;
INSERT dbo.PC 
(PcID, [Name], RAM, PSU, GPU, Storage, MotherboardCPU)
VALUES
(1, 'R-380 gaming mid-tier build', 8,7,6,9,1)
,(3, 'Rfrixy home', 22,14,6,9,103)
,(4, 'Antec Build', 25,14,101,207,104)
,(5, 'Raphael', 21,14,102,208,105)
,(8, 'Diablo', 20,12,103,208,108)
,(6, 'Droplet', 27,13, NULL,205,106)
,(7, 'Sea', 23,11,NULL,201,107)
,(2, 'ZipX budget surfer', 28,10,NULL,203,2);
SET IDENTITY_INSERT dbo.PC OFF;



SET IDENTITY_INSERT dbo.PC ON;

INSERT dbo.PC 
(PcID, [Name], RAM, PSU, GPU, Storage, MotherboardCPU)
VALUES
(9, 'Juggernaut', 26,16,108,204,109),
(10, 'Titan-Station',29,17,109,209,110);
SET IDENTITY_INSERT dbo.PC OFF;




SET IDENTITY_INSERT dbo.UseCases ON;
INSERT dbo.UseCases (UseCaseID, Name, Description)
VALUES 
(1, 'Gaming', 'PCs with this tag can be used for gaming purposes')
, (2, 'Video Editing', 'PCs capable of commercial video editing')
, (3, 'General Use', 'PCs capable of normal day to day use')
, (4, 'Budget build', 'PCs that will not leave a hole in your wallet')
, (5, 'Photo Editing', 'PCs capable of commercial video editing')
, (6, 'Machine Learning', 'PCs targeted towards machine learning')
;
SET IDENTITY_INSERT dbo.UseCases OFF;

INSERT dbo.PCUseCases (PcID, UseCaseID)
VALUES 
(1, 1)
,(10,2)
,(10,6)
,(2,4)
,(6,3)
,(7,3)
,(8,4)
,(9,4)
,(3,1)
,(8,1)
;

use Stud;
