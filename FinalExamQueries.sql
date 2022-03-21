--Final Exam Queries
--Wyatt Haak

--1
SELECT COUNT(DISTINCT ProductName) AS UniqueProducts
FROM Production.Products

--2
SELECT (S.FirstName + ' ' + S.LastName) AS [Staff Full-Name], (SM.FirstName + ' ' + SM.LastName) AS [Manager Full-Name]
FROM Sales.Staff AS S 
INNER JOIN Sales.Staff AS SM
	ON S.StaffId = SM.ManagerId

--3
SELECT B.BrandName, COUNT(P.ProductId) AS [Count of Products]
FROM Production.Brands AS B
INNER JOIN Production.Products AS P
	ON B.BrandId = P.BrandId
GROUP BY B.BrandName

--4
SELECT (C.FirstName + ' ' + C.LastName) AS [Customer's Full Name],
	   (C.City + ' ' + C.[State]) AS [Customer's City and State],
	    C.Email AS [E-mail Address]
FROM Sales.Customers AS C
WHERE C.[State] = 'TX' OR C.[State] = 'CA'

--5
SELECT C.State, COUNT(C.CustomerId) AS [Number of Customers]
FROM Sales.Customers AS C
GROUP BY C.State

--6
SELECT (AVG(OI.Discount)) AS [Average Discount], B.BrandName
FROM Production.Brands AS B
JOIN Sales.Customers AS C
	ON C.CustomerId = B.BrandId
JOIN Sales.Orders AS O
	ON C.CustomerId = O.CustomerId
JOIN Sales.OrderItems AS OI
	ON OI.OrderId = O.OrderId
WHERE C.State = 'CA'
GROUP BY B.BrandName

--7
SELECT YEAR(O.OrderDate) AS [Year], 
	   C.CategoryName AS [Category],
	   SUM(OI.ListPrice) AS [Total sales]
FROM Production.Categories AS C
JOIN Production.Products AS P
	ON C.CategoryId = P.CategoryId
JOIN Sales.OrderItems AS OI
	ON OI.ProductId = P.ProductId
JOIN Sales.Orders AS O
	ON O.OrderId = OI.OrderId
WHERE YEAR(O.OrderDate) = 2017 OR YEAR(O.OrderDate) = 2018
GROUP BY YEAR(O.OrderDate), C.CategoryName

--8
SELECT S.StoreName, COUNT(OI.Quantity) AS [# of Children's Bicycles Sold in 2017]
FROM Sales.Stores AS S
JOIN Production.Stocks AS ST
	ON ST.StoreId = S.StoreId
JOIN Production.Products AS P
	ON P.ProductId = ST.ProductId
JOIN Production.Categories AS C
	ON P.CategoryId = C.CategoryId
JOIN Sales.OrderItems AS OI
	ON OI.ProductId = P.ProductId
JOIN Sales.Orders AS O
	ON O.OrderId = OI.OrderId
WHERE C.CategoryId = 1 AND YEAR(O.OrderDate) = 2017
GROUP BY S.StoreName

