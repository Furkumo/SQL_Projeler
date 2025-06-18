--Proje 6
--A öncülü
--yükseltme öncesi yedekleme 
BACKUP DATABASE AdventureWorks2019
TO DISK = 'C:\Backup\AdventureWorks.bak';

--yükseltme kontrolü 
SELECT SERVERPROPERTY('ProductVersion');
SELECT SERVERPROPERTY('ProductLevel');

--B öncülü
CREATE TRIGGER track_ddl_changes
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
    DECLARE @EventData XML = EVENTDATA();
    INSERT INTO SchemaChangeLog (EventType, ObjectName, EventData, EventDate)
    VALUES (
        @EventData.value('(/EVENT_INSTANCE/EventType)[1]', 'VARCHAR(100)'),
        @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'VARCHAR(100)'),
        @EventData,
        GETDATE()
    );
END;

CREATE TABLE SchemaChangeLog (
    EventType VARCHAR(100),
    ObjectName VARCHAR(100),
    EventData XML,
    EventDate DATETIME
);

SELECT * FROM SchemaChangeLog
ORDER BY EventDate DESC;


--C Öncülü
SELECT TOP 10 * FROM Person.Person;

RESTORE DATABASE AdventureWorks
FROM DISK = 'C:\Backup\AdventureWorks.bak';
