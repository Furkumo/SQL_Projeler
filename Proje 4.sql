--a öncülü
SELECT name, is_read_only FROM sys.databases;

BACKUP LOG AdventureWorks2019 TO DISK = 'C:\Backup\AW_log.trn';

BACKUP DATABASE AdventureWorks2019
TO DISK = 'C:\Backup\AW_full.bak';

BACKUP LOG AdventureWorks2019
TO DISK = 'C:\Backup\AW_log.trn';

BACKUP LOG AdventureWorks2019 
TO DISK = 'C:\Backup\AW_tail.trn' 
WITH NO_TRUNCATE, NOFORMAT;

--b öncülü
ALTER DATABASE AdventureWorks2019 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

RESTORE DATABASE AdventureWorks2019
FROM DISK = 'C:\Backup\AW_full.bak'
WITH NORECOVERY,
MOVE 'AdventureWorks2019' TO 'C:\Backup\Data\AdventureWorks2019.mdf',
MOVE 'AdventureWorks2019_log' TO 'C:\Backup\Data\AdventureWorks2019_log.ldf';
