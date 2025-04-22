--Proje 2 A iþlemi
--Veritabaný yedeklme

--Tam yedekleme
BACKUP DATABASE AdventureWorks2019
TO DISK = 'C:\SQLBackups\AdventureWorks_Full.bak'
WITH INIT, NAME = 'AdventureWorks Full Backup';

--Fark yedekleme 
BACKUP DATABASE AdventureWorks2019
TO DISK = 'C:\SQLBackups\AdventureWorks_Diff.bak'
WITH DIFFERENTIAL,
NAME = 'AdventureWorks Differential Backup';

--Veritabanýný log yedeklemeye uygun hale getirir
ALTER DATABASE AdventureWorks2019
SET RECOVERY FULL;

--Artýk yedekleme 
BACKUP LOG AdventureWorks2019
TO DISK = 'C:\SQLBackups\AdventureWorks_Log.trn'
WITH NAME = 'AdventureWorks Log Backup';

--Proje 2 B iþlemi
-- yedekleme yapýyoruz
BACKUP DATABASE AdventureWorks2019
TO DISK = 'C:\SQLBackups\AdventureWorks_Full.bak'
WITH INIT, NAME = 'Test Backup Before Delete';

--seçtiðimiz satýrý siliyoruz
DELETE FROM Person.EmailAddress
WHERE BusinessEntityID = 3;

--sildiðimizden emin olmak için kontrol ediyoruz
SELECT  * FROM Person.EmailAddress;

--geri yükleme yapýyoruz
USE master;
ALTER DATABASE AdventureWorks2019 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

RESTORE DATABASE AdventureWorks2019
FROM DISK = 'C:\SQLBackups\AdventureWorks_Full.bak'
WITH REPLACE;

ALTER DATABASE AdventureWorks2019 SET MULTI_USER;

--yüklediðimiz satýrýn geldiðini kontrol ediyoruz
USE AdventureWorks2019;
SELECT * FROM Person.EmailAddress WHERE BusinessEntityID = 3;

--logical namesi öðreniyoruz 
RESTORE FILELISTONLY
FROM DISK = 'C:\SQLBackups\AdventureWorks_Full.bak';

--geri yükleme yapýyoruz 
RESTORE DATABASE AdventureWorks_Test
FROM DISK = 'C:\SQLBackups\AdventureWorks_Full.bak'
WITH MOVE 'AdventureWorks2019' TO 'C:\SQLBackups\AdventureWorks_Test.mdf',
     MOVE 'AdventureWorks2019_Log' TO 'C:\SQLBackups\AdventureWorks_Test.ldf',
     REPLACE;

USE AdventureWorks_Test;
GO
SELECT TOP 5 * FROM Person.EmailAddress;

