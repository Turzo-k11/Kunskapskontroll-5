USE AdventureWorks2022;
GO

--- Jobtitel samt antal anst�llda i f�retaget---
SELECT A.BusinessEntityID, -- Tabell
	A.JobTitle, 
	B.DepartmentID,
	C.Name, 
	C.GroupName,
	B.ShiftID, 
	B.StartDate, 
	B.EndDate 
FROM HumanResources.Employee as A INNER JOIN HumanResources.EmployeeDepartmentHistory as B  -- Schema
	ON A.BusinessEntityID = B.BusinessEntityID  --- inner join V�ler radar fr�n b�de tabblerna och matchar med varandra
LEFT JOIN HumanResources.Department as C
	on B.DepartmentID = C.DepartmentID  --- v�ljer tabellen fr�n C och B. Inkludera tabeller fr�n B och  tabeller fr�n C som Matchar med B
ORDER BY A.BusinessEntityID;


--- visa all data som finns med i sales.salesorderheader---
SELECT * FROM Sales.SalesOrderHeader;

--- Information om order  ---
SELECT SalesOrderID, --- V�ljer kolummen fr�n tabell SalesOrderHeader
	   OrderDate, --- V�ljer kolummen 
	   DueDate,
	   TotalDue      --- V�ljer kolummen 
FROM Sales.SalesOrderHeader --- Tabellen "SalesOrderHeader" h�mtas fr�n schemat sales
ORDER BY TotalDue DESC;  --- Inludera sortera DESC Anordna fr�n h�gsta till l�gsta



--- Vilka produkter som f�retaget s�ljer---
SELECT ProductDescriptionID,  --- V�ljer kolummen ProductDescriptionID,
		Description			   ---- Description fr�n tabellen ProductDescription
FROM Production.ProductDescription; --- Denna raden h�mtas tabellen ProductDescription fr�n schemat production



--- Var p� kartan f�retaget s�ljer varor ----
SELECT * FROM Sales.SalesTerritory;

--- D�r f�retaget har s�lt flest produkter----
SELECT [Group], -- V�ljer kolumm
		[SalesYTD],   --- Totala s�lda produkter b�rjan till nu 
	SUM(SalesLastYear) as TotalSales  --- Totala s�lda produkter Alias Totalsales
FROM Sales.SalesTerritory --- Fr�n tabellen SalesTerritory i shemat sales
GROUP BY [Group], [SalesYTD]
ORDER BY TotalSales DESC;  --- Flest s�lda produkter hamnar l�ngst upp p� listan 



-- Information om s�ljare samt antal produkter de har s�lt---
SELECT * FROM Person.Person;
SELECT * FROM Sales.SalesPerson;


-- Information om s�ljare samt antal produkter de har s�lt---
SELECT TOP 10 --- V�ljer top 10
	A.FirstName, 
	A.LastName, 
	B.CommissionPct, 
	B.SalesYTD, 
	B.SalesLastYear
FROM Person.Person as A INNER JOIN Sales.SalesPerson as B 
	ON A.BusinessEntityID = B.BusinessEntityID ---- Kombinerar och matchar v�rden mellan tabellerna 
ORDER BY SalesLastYear DESC; 

--- Samma som i f�rra men vi tar med bara de som har s�lt mindre �n  f�reg�ende �ret--- 
---JOIN: matcha BusinessEntityID i b�da tabellerna---
SELECT 
	A.FirstName, 
	A.LastName, 
	B.CommissionPct, 
	B.SalesYTD, 
	B.SalesLastYear
FROM Person.Person as A INNER JOIN Sales.SalesPerson as B
	ON A.BusinessEntityID = B.BusinessEntityID  
WHERE B.SalesLastYear < 5000000 AND B.SalesYTD < 5000000  --- Ett filter f�r att h�mta upp radar med f�rra �ret och �ret f�rs�ljning mindre �r 5000000.
ORDER BY SalesLastYear; 

--- Information om kunder ----
SELECT BusinessEntityID,
	FirstName,
	LastName,
	EmailAddress,
	PhoneNumber,
	CountryRegionName
FROM Sales.vIndividualCustomer --- Fr�n tabellen vIndividualCustomer i schemat Sales
WHERE BusinessEntityID = 4970;  --- H�r kan vi hitta personen med BusinessEntityID


