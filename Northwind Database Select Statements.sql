USE Northwind;

SELECT C.CustomerID AS 'Customer ID', C.CompanyName AS 'Company Name'
FROM Customers as C
ORDER BY 'Customer ID', C.CompanyName;

SELECT CompanyName, Country
FROM Customers
WHERE Country = 'Germany';

SELECT OD.UnitPrice, AVG(OD.Discount)
FROM [Order Details] AS OD
GROUP BY OD.UnitPrice;

SELECT *
FROM Employees;

SELECT *
FROM EmployeeTerritories;

SELECT *
FROM Region;

SELECT E.LastName, ET.TerritoryID, T.RegionID, R.RegionDescription, 
COUNT(*) AS 'Number of Territories'
FROM Employees AS E
INNER JOIN EmployeeTerritories AS ET
	ON E.EmployeeID = ET.EmployeeID
INNER JOIN Territories AS T
	ON ET.TerritoryID = T.TerritoryID
INNER JOIN Region AS R
	ON R.RegionID = T.RegionID
WHERE E.EmployeeID = 2
GROUP BY E.LastName, ET.TerritoryID, T.RegionID, R.RegionID, R.RegionDescription;

SELECT E.LastName, R.RegionDescription,
COUNT(*) AS 'Number of Territories'
FROM Employees AS E
INNER JOIN EmployeeTerritories AS ET
	ON E.EmployeeID = ET.EmployeeID
INNER JOIN Territories AS T
	ON ET.TerritoryID = T.TerritoryID
INNER JOIN Region AS R
	ON R.RegionID = T.RegionID
WHERE E.EmployeeID = 2
GROUP BY E.LastName, R.RegionDescription
HAVING R.RegionDescription = 'Eastern';
