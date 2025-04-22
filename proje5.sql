--5.Proje

--A öncülü
-- `Person.Person` tablosunda e-posta adresi eksik olanlarý listele
SELECT BusinessEntityID,EmailAddressID ,EmailAddress,ModifiedDate
FROM Person.EmailAddress
WHERE EmailAddress IS NULL;

-- `Person.EmailAddress` tablosundaki eksik e-posta adreslerini `unknown` ile güncelle
UPDATE Person.EmailAddress
SET EmailAddress = 'unknown'
WHERE EmailAddress IS NULL;

SELECT * 
FROM Person.EmailAddress;

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Person'
  AND TABLE_SCHEMA = 'Person'
  AND COLUMN_NAME = 'ModifiedDate';

-- `Person.Person` tablosuna `FormattedModifiedDate` sütunu ekleme
ALTER TABLE Person.Person
ADD FormattedModifiedDate VARCHAR(10);



--B Öncülü
-- ModifiedDate sütununu doðru formata dönüþtürme
SELECT BusinessEntityID, FirstName, LastName, 
       CONVERT(VARCHAR(10), ModifiedDate, 120) AS FormattedModifiedDate
FROM Person.Person;

-- Yeni sütunu doldurma (tarih verisini dönüþtürme)
UPDATE Person.Person
SET FormattedModifiedDate = CONVERT(VARCHAR(10), ModifiedDate, 120);

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Person'
  AND TABLE_SCHEMA = 'Person'
  AND COLUMN_NAME = 'FormattedModifiedDate';



--C Öncülü
-- `Person.PersonBackup` tablosundaki verileri `Person.Person` tablosuna yükleme 
INSERT INTO Person.Person (BusinessEntityID, PersonType, NameStyle, Title, FirstName, LastName)
SELECT BusinessEntityID, PersonType, NameStyle, Title, FirstName, LastName
FROM Person.PersonBackup
WHERE NOT EXISTS (
    SELECT 1 
    FROM Person.Person
    WHERE Person.Person.BusinessEntityID = Person.PersonBackup.BusinessEntityID
);
--yedeklenen verileri göstermek için 
SELECT * 
FROM Person.PersonBackup;



--D Öncülü
-- Eksik e-posta adresi olan verileri raporlama
SELECT BusinessEntityID, EmailAddress
FROM Person.EmailAddress
WHERE EmailAddress = 'unknown';


