--a �nc�l�
-- SQL Server Authentication ile kullan�c� olu�turma
CREATE LOGIN furk WITH PASSWORD = '5306';
USE [AdventureWorks2019];
CREATE USER furk FOR LOGIN furk;
ALTER ROLE db_datareader ADD MEMBER furk;



-- b �nc�l�
-- Veritaban� �ifreleme durumunu kontrol et
SELECT
    name,
    is_encrypted
FROM
    sys.databases
WHERE
    name = 'AdventureWorks2019';


-- c �nc�l�

-- Tehlikeli: Do�rudan string birle�tirme
-- G�venli: Parametreli sorgular
USE AdventureWorks2019;
GO

DECLARE @kullaniciId INT = 1;
SELECT * FROM Kullanici WHERE Id = @kullaniciId;
