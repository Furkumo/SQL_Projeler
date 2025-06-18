SELECT 
    d.name AS DatabaseName,
    MAX(b.backup_finish_date) AS LastBackupDate,
    b.type AS BackupType
FROM 
    sys.databases d
LEFT JOIN 
    msdb.dbo.backupset b 
    ON d.name = b.database_name
GROUP BY 
    d.name, b.type
ORDER BY 
    LastBackupDate DESC;
