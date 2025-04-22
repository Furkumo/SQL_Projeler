--Proje 1
--A Öncülü
--Performans analizi
SELECT * FROM Person.Person WHERE LastName LIKE '%a%';

CREATE NONCLUSTERED INDEX IX_LastName ON Person.Person(LastName);
SELECT * FROM Person.Person WHERE LastName LIKE '%a%';


--B Öncülü
--Sorgu iyileþtirme 
SELECT * FROM Person.Person
JOIN HumanResources.Employee ON Person.Person.BusinessEntityID = HumanResources.Employee.BusinessEntityID
WHERE LastName LIKE '%a%';

SELECT p.FirstName, p.LastName, e.JobTitle
FROM Person.Person AS p
JOIN HumanResources.Employee AS e ON p.BusinessEntityID = e.BusinessEntityID
WHERE p.LastName LIKE 'A%';


--C Öncülü
SELECT TOP 10
    qs.total_elapsed_time / qs.execution_count AS AvgElapsedTime,
    qs.execution_count,
    qt.text AS QueryText,
    db_name(qt.dbid) AS DatabaseName
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
ORDER BY AvgElapsedTime DESC;

--D Öncülü
CREATE LOGIN projeKullanici WITH PASSWORD = 'Proje123!'; --Login Oluþtur

USE AdventureWorks2019;
GO

CREATE USER projeKullanici FOR LOGIN projeKullanici; --Veri tabaný için kullanýcý oluþturma 

CREATE ROLE veriOkuyucu; --Rol tanýmý
ALTER ROLE veriOkuyucu ADD MEMBER projeKullanici;

GRANT SELECT ON Person.Person TO projeKullanici; --Yetki Verme 

DENY INSERT, UPDATE, DELETE ON Person.Person TO projeKullanici;--Yetki sýnýrlama

