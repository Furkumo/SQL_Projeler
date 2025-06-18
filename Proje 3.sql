--a öncülü
-- SQL Server Authentication ile kullanýcý oluþturma
CREATE LOGIN furk WITH PASSWORD = '5306';
USE [AdventureWorks2019];
CREATE USER furk FOR LOGIN furk;
ALTER ROLE db_datareader ADD MEMBER furk;



-- b öncülü
-- Veritabaný þifreleme durumunu kontrol et
SELECT
    name,
    is_encrypted
FROM
    sys.databases
WHERE
    name = 'AdventureWorks2019';


-- c öncülü

-- Tehlikeli: Doðrudan string birleþtirme
-- Güvenli: Parametreli sorgular
USE AdventureWorks2019;
GO

DECLARE @kullaniciId INT = 1;
SELECT * FROM Kullanici WHERE Id = @kullaniciId;
