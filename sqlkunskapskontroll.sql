USE AdventureWorks2022;
GO

--- Jobtitel samt antal anställda i företaget---
SELECT A.BusinessEntityID, -- Tabell
	A.JobTitle, 
	B.DepartmentID,
	C.Name, 
	C.GroupName,
	B.ShiftID, 
	B.StartDate, 
	B.EndDate 
FROM HumanResources.Employee as A INNER JOIN HumanResources.EmployeeDepartmentHistory as B  -- Schema
	ON A.BusinessEntityID = B.BusinessEntityID  --- inner join Väler radar från både tabblerna och matchar med varandra
LEFT JOIN HumanResources.Department as C
	on B.DepartmentID = C.DepartmentID  --- väljer tabellen från C och B. Inkludera tabeller från B och  tabeller från C som Matchar med B
ORDER BY A.BusinessEntityID;


--- visa all data som finns med i sales.salesorderheader---
SELECT * FROM Sales.SalesOrderHeader;

--- Information om order  ---
SELECT SalesOrderID, --- Väljer kolummen från tabell SalesOrderHeader
	   OrderDate, --- Väljer kolummen 
	   DueDate,
	   TotalDue      --- Väljer kolummen 
FROM Sales.SalesOrderHeader --- Tabellen "SalesOrderHeader" hämtas från schemat sales
ORDER BY TotalDue DESC;  --- Inludera sortera DESC Anordna från högsta till lägsta



--- Vilka produkter som företaget säljer---
SELECT ProductDescriptionID,  --- Väljer kolummen ProductDescriptionID,
		Description			   ---- Description från tabellen ProductDescription
FROM Production.ProductDescription; --- Denna raden hämtas tabellen ProductDescription från schemat production



--- Var på kartan företaget säljer varor ----
SELECT * FROM Sales.SalesTerritory;

--- Där företaget har sålt flest produkter----
SELECT [Group], -- Väljer kolumm
		[SalesYTD],   --- Totala sålda produkter början till nu 
	SUM(SalesLastYear) as TotalSales  --- Totala sålda produkter Alias Totalsales
FROM Sales.SalesTerritory --- Från tabellen SalesTerritory i shemat sales
GROUP BY [Group], [SalesYTD]
ORDER BY TotalSales DESC;  --- Flest sålda produkter hamnar längst upp på listan 



-- Information om säljare samt antal produkter de har sålt---
SELECT * FROM Person.Person;
SELECT * FROM Sales.SalesPerson;


-- Information om säljare samt antal produkter de har sålt---
SELECT TOP 10 --- Väljer top 10
	A.FirstName, 
	A.LastName, 
	B.CommissionPct, 
	B.SalesYTD, 
	B.SalesLastYear
FROM Person.Person as A INNER JOIN Sales.SalesPerson as B 
	ON A.BusinessEntityID = B.BusinessEntityID ---- Kombinerar och matchar värden mellan tabellerna 
ORDER BY SalesLastYear DESC; 

--- Samma som i förra men vi tar med bara de som har sålt mindre än  föregående året--- 
---JOIN: matcha BusinessEntityID i båda tabellerna---
SELECT 
	A.FirstName, 
	A.LastName, 
	B.CommissionPct, 
	B.SalesYTD, 
	B.SalesLastYear
FROM Person.Person as A INNER JOIN Sales.SalesPerson as B
	ON A.BusinessEntityID = B.BusinessEntityID  
WHERE B.SalesLastYear < 5000000 AND B.SalesYTD < 5000000  --- Ett filter för att hämta upp radar med förra året och året försäljning mindre är 5000000.
ORDER BY SalesLastYear; 

--- Information om kunder ----
SELECT BusinessEntityID,
	FirstName,
	LastName,
	EmailAddress,
	PhoneNumber,
	CountryRegionName
FROM Sales.vIndividualCustomer --- Från tabellen vIndividualCustomer i schemat Sales
WHERE BusinessEntityID = 4970;  --- Här kan vi hitta personen med BusinessEntityID


