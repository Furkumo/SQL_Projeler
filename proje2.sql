--Proje 2 A i�lemi
--Veritaban� yedeklme

--Tam yedekleme
BACKUP DATABASE AdventureWorks2019
TO DISK = 'C:\SQLBackups\AdventureWorks_Full.bak'
WITH INIT, NAME = 'AdventureWorks Full Backup';

--Fark yedekleme 
BACKUP DATABASE AdventureWorks2019
TO DISK = 'C:\SQLBackups\AdventureWorks_Diff.bak'
WITH DIFFERENTIAL,
NAME = 'AdventureWorks Differential Backup';

--Veritaban�n� log yedeklemeye uygun hale getirir
ALTER DATABASE AdventureWorks2019
SET RECOVERY FULL;

--Art�k yedekleme 
BACKUP LOG AdventureWorks2019
TO DISK = 'C:\SQLBackups\AdventureWorks_Log.trn'
WITH NAME = 'AdventureWorks Log Backup';

--Proje 2 B i�lemi
-- yedekleme yap�yoruz
BACKUP DATABASE AdventureWorks2019
TO DISK = 'C:\SQLBackups\AdventureWorks_Full.bak'
WITH INIT, NAME = 'Test Backup Before Delete';

--se�ti�imiz sat�r� siliyoruz
DELETE FROM Person.EmailAddress
WHERE BusinessEntityID = 3;

--sildi�imizden emin olmak i�in kontrol ediyoruz
SELECT  * FROM Person.EmailAddress;

--geri y�kleme yap�yoruz
USE master;
ALTER DATABASE AdventureWorks2019 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

RESTORE DATABASE AdventureWorks2019
FROM DISK = 'C:\SQLBackups\AdventureWorks_Full.bak'
WITH REPLACE;

ALTER DATABASE AdventureWorks2019 SET MULTI_USER;

--y�kledi�imiz sat�r�n geldi�ini kontrol ediyoruz
USE AdventureWorks2019;
SELECT * FROM Person.EmailAddress WHERE BusinessEntityID = 3;

--logical namesi ��reniyoruz 
RESTORE FILELISTONLY
FROM DISK = 'C:\SQLBackups\AdventureWorks_Full.bak';

--geri y�kleme yap�yoruz 
RESTORE DATABASE AdventureWorks_Test
FROM DISK = 'C:\SQLBackups\AdventureWorks_Full.bak'
WITH MOVE 'AdventureWorks2019' TO 'C:\SQLBackups\AdventureWorks_Test.mdf',
     MOVE 'AdventureWorks2019_Log' TO 'C:\SQLBackups\AdventureWorks_Test.ldf',
     REPLACE;

USE AdventureWorks_Test;
GO
SELECT TOP 5 * FROM Person.EmailAddress;

