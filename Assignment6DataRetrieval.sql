USE MyGuitarShop;

--Assignment 6
--Wyatt Haak

--1
SELECT DISTINCT C.CategoryName
FROM Categories AS C
WHERE C.CategoryID IN
	(SELECT P.CategoryID
	 FROM Products AS P)
ORDER BY C.CategoryName

--2
SELECT P.ProductName, P.ListPrice
FROM Products AS P
WHERE P.ListPrice >
	(SELECT AVG(P2.ListPrice)
	 FROM Products AS P2
	 WHERE P2.ListPrice > 0)
ORDER BY P.ListPrice DESC;

--3
SELECT C.CategoryName
FROM Categories as C
WHERE NOT EXISTS
	(SELECT *
	 FROM Products as P
	 WHERE P.CategoryID = C.CategoryID)

--4 Part 1
SELECT C.EmailAddress, OI.OrderID, SUM((OI.ItemPrice - OI.DiscountAmount) * OI.Quantity) AS [Order Total]
FROM OrderItems AS OI 
JOIN Orders AS O
	ON OI.OrderID = O.OrderID
JOIN Customers AS C
	ON O.CustomerID = C.CustomerID
GROUP BY C.EmailAddress, OI.OrderID

--4 Part 2
SELECT [Email Orders].EmailAddress, 
MAX([Email Orders].[Order Total]) AS [Largest Order]
FROM 
	(SELECT C.EmailAddress, OI.OrderID, SUM((OI.ItemPrice - OI.DiscountAmount) * OI.Quantity) AS [Order Total]
	 FROM OrderItems AS OI 
	 JOIN Orders AS O
		ON OI.OrderID = O.OrderID
	 JOIN Customers AS C
		ON O.CustomerID = C.CustomerID
	 GROUP BY C.EmailAddress, OI.OrderID) AS [Email Orders]
GROUP BY [Email Orders].EmailAddress

--5
SELECT P1.ProductName, P1.DiscountPercent
FROM Products AS P1
WHERE NOT EXISTS
	(SELECT *
	 FROM Products AS P2
	 WHERE P2.DiscountPercent = P1.DiscountPercent
	 AND P2.ProductName != P1.ProductName)
ORDER BY P1.ProductName

--6
SELECT C.EmailAddress, O.OrderId, [Oldest Orders].[Oldest Order Date]
FROM Customers AS C JOIN
	(SELECT O1.CustomerID, MIN(O1.OrderDate) AS [Oldest Order Date]
	 FROM Orders AS O1
	 GROUP BY O1.CustomerID) AS [Oldest Orders]
	ON C.CustomerID = [Oldest Orders].CustomerID
JOIN Orders AS O
	ON [Oldest Orders].[Oldest Order Date] = O.OrderDate