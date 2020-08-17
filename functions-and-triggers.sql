
--Net Power of individual parts in PC <= Power of PSU
	
--In a PC, all parts should draw less power than the power supplied by the PSU  TABLE LEVEL CHECK CONSTRAINT BASED ON A FUNCTION

use Stud;
USE T_25_i;

CREATE FUNCTION CheckPower_updated (@psu_pk INT,@gpu_pk int,@ram_pk int,@storage_pk int,@mothcpu_pk int)
RETURNS BIT
AS 
BEGIN 
	
	DECLARE @moth_pk int
	DECLARE @cpu_pk int
	DECLARE @bool bit
	DECLARE @ans int
	DECLARE @compare int
	
	SELECT @moth_pk = MotherboardPartID 
 	from MotherboardCPU mc WHERE MotherboardCPUID = @mothcpu_pk
 	
 	SELECT @cpu_pk = CPUPartID 
 	from MotherboardCPU mc WHERE MotherboardCPUID = @mothcpu_pk
 	

	SELECT @ans = SUM(p.PowerConsumed) from Part p 
	WHERE PartID IN (@gpu_pk,@ram_pk,@storage_pk,@moth_pk,@cpu_pk )
	
	SELECT @compare = p.PowerConsumed 
	FROM Part p 
	WHERE PartID = @psu_pk

	IF @ans+@compare <=0
		BEGIN 
			SET @bool = 1
		END
		
	ELSE 
		BEGIN 
			SET @bool = 0
		END
		
	RETURN @bool
	
END;

ALTER TABLE dbo.PC ADD CONSTRAINT CheckPower3 
CHECK (dbo.CheckPower_updated(PSU ,GPU ,RAM ,Storage ,MotherboardCPU )=1);

----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Slots in individual parts in a PC <= slots in Motherboard TABLE LEVEL CHECK CONSTRAINT BASED ON A FUNCTION

/*In a PC, ramslots used, gpu slots used, nvme slots used and sata slots used should be less than or equal to that provided by the motherboard */



CREATE or alter FUNCTION CheckSlots (@gpu_pk int,@ram_pk int,@storage_pk int,@mothcpu_pk int)
RETURNS BIT
AS 
BEGIN 
	
	DECLARE @bool BIT
	DECLARE @gpu_slots int 
	DECLARE @ram_slots int
	DECLARE @sata_slots int
	DECLARE @nvme_slots int
	
	
	DECLARE @moth_gpu_slots int
	DECLARE @moth_ram_slots int
	DECLARE @moth_sata_slots int
	DECLARE @moth_nvme_slots int
	
	IF @gpu_pk is null
		BEGIN 
			SET @gpu_slots =  0
		END
	else
		SELECT @gpu_slots = GpuSlotsUsed 
		FROM GPU g 
		WHERE PartID = @gpu_pk
	
	SELECT @ram_slots = RamSlotsUsed 
	FROM RAM r2 
	WHERE PartID = @ram_pk
	
	SELECT @sata_slots = SataSlotsUsed
	FROM Storage s2 
	WHERE PartID = @storage_pk
	
	SELECT @nvme_slots = NvmeSlotsUsed
	FROM Storage s2 
	WHERE PartID = @storage_pk
	
	SELECT @moth_gpu_slots = GpuSlots, @moth_ram_slots=RamSlots, @moth_sata_slots= SataSlots, @moth_nvme_slots= NvmeSlots
	FROM Motherboard m2 
	WHERE PartID = (SELECT mc.MotherboardPartID FROM MotherboardCPU mc WHERE MotherboardCPUID = @mothcpu_pk)
	
	
	IF @moth_gpu_slots >= @gpu_slots AND @moth_ram_slots >= @ram_slots AND @moth_sata_slots >= @sata_slots AND @moth_nvme_slots >= @nvme_slots
		BEGIN 
			SET @bool =  1
		END
	
	ELSE 
		BEGIN 
			SET @bool =  0
		END
		
	RETURN @bool
END;

ALTER TABLE dbo.PC ADD CONSTRAINT CheckSlots1 CHECK (dbo.CheckSlots(GPU ,RAM ,Storage ,MotherboardCPU )=1);
ALTER TABLE dbo.PC
drop CONSTRAINT CheckSlots1;


---------------------------------------------------------------------------------------------------------------------------------------------------------------

--Function for order total
CREATE FUNCTION dbo.GetOrderTotal(@OrderID int)
RETURNS MONEY
AS BEGIN
	DECLARE @TotalSale MONEY
	SELECT @TotalSale = SUM(op.Quantity * p.SalePrice)
			FROM dbo.OrderPart op 
			join dbo.Price p on p.PartID = op.PartID 
			where op.OrderID = @OrderID
		RETURN @TotalSale
	end;

--drop func
--drop function dbo.GetOrderTotal;

--add column to orders table
ALTER TABLE Orders 
ADD OrderTotalDue AS (dbo.GetOrderTotal(OrderID));

------------------------------------------------

CREATE TRIGGER check_date_staff
ON Staff
INSTEAD OF INSERT, UPDATE 
AS
BEGIN
	SET NOCOUNT ON
   IF EXISTS (
      SELECT 1
      FROM inserted
      WHERE (datediff(day, StartedAt, isnull(EndedAt,current_timestamp)) < 0)
   )
   BEGIN
      THROW 51001, 'Start Date cannot be earlier than End Date.', 1
      ROLLBACK TRANSACTION
   END 
   ELSE    
      BEGIN
	     SET IDENTITY_INSERT Staff ON
         INSERT INTO dbo.Staff (StaffId, StoreId, PersonId, Designation, StartedAt, EndedAt)
         SELECT StaffId, StoreId, PersonId, Designation, StartedAt, EndedAt
         FROM inserted
         SET IDENTITY_INSERT Staff OFF
   END    
END;
--Test check_date_staff
/*
drop trigger check_date_staff;

SET IDENTITY_INSERT Staff ON;
INSERT dbo.Staff (StaffId, StoreId, PersonId, Designation, StartedAt, EndedAt)
VALUES (813, 10, 21, 'Sales Person', '1-1-2020', '1-1-2019');
SET IDENTITY_INSERT Staff OFF;

SET IDENTITY_INSERT Staff ON;
INSERT dbo.Staff (StaffId, StoreId, PersonId, Designation, StartedAt, EndedAt)
VALUES (813, 10, 21, 'Sales Person', '1-1-2018', '1-1-2019');
SET IDENTITY_INSERT Staff OFF;

update dbo.Staff set StartedAt = '1-1-2020'
where StaffID = 801;
*/

----------------------------------------------------
CREATE TRIGGER check_date_price
ON Price
INSTEAD OF INSERT, UPDATE 
AS
BEGIN
	SET NOCOUNT ON
   IF EXISTS (
      SELECT 1
      FROM inserted
      WHERE (datediff(day, StartedAt, EndedAt) < 0)
   )
   BEGIN
      THROW 51001, 'Strat Date cannot be earlier than End Date.', 1
      ROLLBACK TRANSACTION
   END 
   ELSE    
      BEGIN
	     SET IDENTITY_INSERT Price ON
         INSERT INTO dbo.Price (PriceId, PartId, StartedAt, EndedAt, CostPrice, SalePrice)
         SELECT PriceId, PartId, StartedAt, EndedAt, CostPrice, SalePrice
         FROM inserted
         SET IDENTITY_INSERT Price OFF
   END    
END;
--Test
/*
SET IDENTITY_INSERT dbo.Price ON;
INSERT dbo.Price (PriceId, PartId, StartedAt, EndedAt, CostPrice, SalePrice)
VALUES (5,4, '10-10-2019', '10-8-2019', 380 ,419.99);
SET IDENTITY_INSERT dbo.Price OFF;

SET IDENTITY_INSERT dbo.Price ON;
INSERT dbo.Price (PriceId, PartId, StartedAt, EndedAt, CostPrice, SalePrice)
VALUES (5,4, '10-8-2018', '10-8-2019', 380 ,419.99);
SET IDENTITY_INSERT dbo.Price OFF;

update dbo.Price set StartedAt = '8-3-2020'
where PriceId = 1;
*/

--------------------------------------------
CREATE TRIGGER check_PartType_RAM
ON RAM	
--, PSU, GPU,Storage, Motherboard, CPU
INSTEAD OF INSERT, UPDATE 
AS
BEGIN
	SET NOCOUNT ON
   IF EXISTS (
      SELECT 1
      FROM inserted i
      join Part p on p.PartID = i.partid
      where p.PartType <> 'RAM'
   )
   BEGIN
      THROW 51003, 'A Part can only belong to one part category.', 1
      ROLLBACK TRANSACTION
   END 
   ELSE    
      BEGIN
         INSERT INTO dbo.RAM (PartId, Memory, ClockSpeed, RamSlotsUsed, RamType)
         SELECT PartId, Memory, ClockSpeed, RamSlotsUsed, RamType
         FROM inserted
   END    
END;

/*
DROP trigger check_PartID_RAM;

INSERT dbo.RAM (PartId)
VALUES (7);*/
---------------------------------------------------

CREATE TRIGGER check_PartType_GPU
ON GPU	
INSTEAD OF INSERT, UPDATE 
AS
BEGIN
	SET NOCOUNT ON
   IF EXISTS (
      SELECT 1
      FROM inserted i
      join Part p on p.PartID = i.partid
      where p.PartType <> 'GPU' 
   )
   BEGIN
      THROW 51003, 'A Part can only belong to one part category.', 1
      ROLLBACK TRANSACTION
   END 
   ELSE    
      BEGIN
         INSERT INTO dbo.GPU (PartId, GpuSlotsUsed, Vram, ClockSpeed)
         SELECT PartId, GpuSlotsUsed, Vram, ClockSpeed
         FROM inserted
   END    
END;
/*
DROP trigger check_PartID_GPU;
--Test
INSERT dbo.GPU (PartId)
VALUES (9);
*/

---------------------------------------------------

CREATE TRIGGER check_PartType_PSU
ON PSU	
INSTEAD OF INSERT, UPDATE 
AS
BEGIN
	SET NOCOUNT ON
   IF EXISTS (
      SELECT 1
      FROM inserted i
      join Part p on p.PartID = i.partid
      where p.PartType <> 'PSU' 
   )
   BEGIN
      THROW 51003, 'A Part can only belong to one part category.', 1
      ROLLBACK TRANSACTION
   END 
   ELSE    
      BEGIN
         INSERT INTO dbo.PSU (PartId, Voltage, Weight)
         SELECT PartId, Voltage, Weight
         FROM inserted
   END    
END;

---------------------------------------------------

CREATE TRIGGER check_PartType_Storage
ON Storage	
INSTEAD OF INSERT, UPDATE 
AS
BEGIN
	SET NOCOUNT ON
   IF EXISTS (
      SELECT 1
      FROM inserted i
      join Part p on p.PartID = i.partid
      where p.PartType <> 'Storage' 
   )
   BEGIN
      THROW 51003, 'A Part can only belong to one part category.', 1
      ROLLBACK TRANSACTION
   END 
   ELSE    
      BEGIN
         INSERT INTO dbo.Storage (PartId, NvmeSlotsUsed, SataSlotsUsed, DiskSpeed, DiskSpace)
         SELECT PartId, NvmeSlotsUsed, SataSlotsUsed, DiskSpeed, DiskSpace
         FROM inserted
   END    
END;
------------------------------------------------------------
CREATE TRIGGER check_PartType_Motherboard
ON Motherboard	
INSTEAD OF INSERT, UPDATE 
AS
BEGIN
	SET NOCOUNT ON
   IF EXISTS (
      SELECT 1
      FROM inserted i
      join Part p on p.PartID = i.partid
      where p.PartType <> 'Motherboard' 
   )
   BEGIN
      THROW 51003, 'A Part can only belong to one part category.', 1
      ROLLBACK TRANSACTION
   END 
   ELSE    
      BEGIN
         INSERT INTO dbo.Motherboard (PartId, RamSlots, SataSlots, GpuSlots, NvmeSlots, MotherboardType)
         SELECT PartId, RamSlots, SataSlots, GpuSlots, NvmeSlots, MotherboardType
         FROM inserted
   END    
END;

---------------------------------------------------

CREATE TRIGGER check_PartType_CPU
ON CPU	
INSTEAD OF INSERT, UPDATE 
AS
BEGIN
	SET NOCOUNT ON
   IF EXISTS (
      SELECT 1
      FROM inserted i
      join Part p on p.PartID = i.partid
      where p.PartType <> 'CPU' 
   )
   BEGIN
      THROW 51003, 'A Part can only belong to one part category.', 1
      ROLLBACK TRANSACTION
   END 
   ELSE    
      BEGIN
         INSERT INTO dbo.CPU (PartId, Clockspeed, ChipSize, CacheSize)
         SELECT PartId, Clockspeed, ChipSize, CacheSize
         FROM inserted
   END    
END;
------------------------------------------------



CREATE TRIGGER orderPart_check_stock
ON OrderPart
Instead OF INSERT, UPDATE, DELETE
AS
BEGIN
	SET NOCOUNT ON
-- Insert Case
	--orderpart quantity < 1
	IF EXISTS( SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)  AND
	EXISTS (
      SELECT 1
      FROM inserted
      WHERE (quantity < 1)
   )
   BEGIN
      THROW 51002, 'Part quantity cannot be less than 1.', 1
      ROLLBACK TRANSACTION
   END 
   -- stock is not enough
      IF EXISTS( SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted) AND 
   	EXISTS (SELECT stocktemp.quantity-i.quantity  From Inserted i 
		join (select s.quantity, s.PartID, s.StoreID,o.OrderID from stock s 
		join orders o on o.StoreId = s.StoreID) AS stocktemp
		on stocktemp.partid = i.partid and stocktemp.orderID = i.orderID
		where stocktemp.quantity-i.quantity < 0)
	  BEGIN
      	THROW 51004, 'Order quanity cannot greater than store stock.', 1 
      	ROLLBACK TRANSACTION
  	   END 
  	   -- insert orderpart
  	  IF EXISTS( SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted) AND 
   	EXISTS (SELECT stocktemp.quantity-i.quantity  From Inserted i 
		join (select s.quantity, s.PartID, s.StoreID,o.OrderID from stock s 
		join orders o on o.StoreId = s.StoreID) AS stocktemp
		on stocktemp.partid = i.partid and stocktemp.orderID = i.orderID
		where stocktemp.quantity-i.quantity >= 0)
    BEGIN
            --updated stock
	    	UPDATE stock
        	SET quantity = s.Quantity - i.Quantity
        	FROM
            Stock s
            INNER JOIN INSERTED i ON i.PartID = s.PartID
            join orders o on i.orderid = o.OrderID 
            where i.partid = s.partid and s.StoreID = o.storeID
            --insert orderpart
            SET IDENTITY_INSERT OrderPart ON
         	INSERT INTO dbo.OrderPart (OrderPartId, OrderId, PartId, Quantity)
         	SELECT OrderPartId, OrderId, PartId, Quantity
         	FROM inserted
         	SET IDENTITY_INSERT OrderPart OFF
            
    END
    -- Update Case
    --update quantity < 1
    IF EXISTS( SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)  AND
	EXISTS (
      SELECT 1
      FROM inserted
      WHERE (quantity < 1)
   )
   BEGIN
      THROW 51002, 'Part quantity cannot be less than 1.', 1
      ROLLBACK TRANSACTION
   END 
   -- stock not enough for update
   IF EXISTS( SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) AND 
   	EXISTS (SELECT stocktemp.quantity-i.quantity  From Inserted i 
		join (select s.quantity, s.PartID, s.StoreID,o.OrderID from stock s 
		join orders o on o.StoreId = s.StoreID) AS stocktemp
		on stocktemp.partid = i.partid and stocktemp.orderID = i.orderID
		where stocktemp.quantity-i.quantity < 0)
    BEGIN
        THROW 51004, 'Order quanity cannot greater than store stock.', 1 
      	ROLLBACK TRANSACTION
    END
    -- update orderpart
       IF EXISTS( SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) and 
       EXISTS (SELECT stocktemp.quantity-i.quantity  From Inserted i 
		join (select s.quantity, s.PartID, s.StoreID,o.OrderID from stock s 
		join orders o on o.StoreId = s.StoreID) AS stocktemp
		on stocktemp.partid = i.partid and stocktemp.orderID = i.orderID
		where stocktemp.quantity-i.quantity >= 0)
    BEGIN
	    --update stock
            UPDATE stock
        SET quantity = s.quantity - i.quantity + d.quantity
        FROM
            stock s
            INNER JOIN INSERTED i ON i.PartID = s.PartID
            INNER JOIN Deleted d ON d.PartID = s.PartID
            join orders o on i.orderid = o.OrderID 
            where i.partid = s.partid and s.StoreID = o.storeiD and d.partid = s.partid
        -- update orderpart
        	Delete OrderPart   
 			from OrderPart  
 			join deleted  
 			on OrderPart.OrderPartId = deleted.OrderPartId
 			--
			SET IDENTITY_INSERT OrderPart ON
         	INSERT INTO dbo.OrderPart (OrderPartId, OrderId, PartId, Quantity)
         	SELECT OrderPartId, OrderId, PartId, Quantity
         	FROM inserted
         	SET IDENTITY_INSERT OrderPart OFF		
    END
      
   -- Delete Case
   IF EXISTS( SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
   	BEGIN
            
   		--updated stock
	    	UPDATE stock
        	SET quantity = s.Quantity + d.Quantity
        	FROM
            Stock s
            INNER JOIN DELETED d ON d.PartID = s.PartID
            join orders o on d.orderid = o.OrderID 
            where d.partid = s.partid and s.StoreID = o.storeID    
        --
        	Delete OrderPart   
 			from OrderPart  
 			join deleted  
 			on OrderPart.OrderPartId = deleted.OrderPartId
   END    
  END;

use Stud;