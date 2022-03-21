USE MyGuitarShop;

--Assignment 5
--Wyatt Haak

--1
SELECT P.ProductCode, P.ProductName, P.ListPrice, P.DiscountPercent
FROM Products AS P
ORDER BY P.ListPrice DESC;

--2
SELECT C.FirstName + ', ' + C.LastName AS 'Customer Name'
FROM Customers AS C
WHERE C.LastName >= 'M'
ORDER BY C.LastName ASC;

--3
SELECT P.ProductName, P.ListPrice, P.DateAdded
FROM Products AS P
WHERE P.ListPrice > 500 AND P.ListPrice < 2000
ORDER BY P.DateAdded DESC;

--4
SELECT P.ProductName, P.ListPrice, P.DiscountPercent, 
(P.ListPrice * (P.DiscountPercent / 100)) AS [DiscountAmount], 
(P.ListPrice - (P.ListPrice * (P.DiscountPercent / 100))) AS [DiscountPrice]
FROM Products AS P
ORDER BY [DiscountPrice] DESC;

--5
SELECT O.ItemID, O.ItemPrice, O.DiscountAmount, O.Quantity, 
(O.ItemPrice * O.Quantity) AS [PriceTotal], 
(O.DiscountAmount * O.Quantity) AS [DiscountTotal], 
((O.ItemPrice - O.DiscountAmount) * O.Quantity) AS [ItemTotal]
FROM OrderItems AS O
WHERE ((O.ItemPrice - O.DiscountAmount) * O.Quantity) > 500
ORDER BY [ItemTotal] DESC;

--6
SELECT O.OrderID, O.OrderDate, O.ShipDate
FROM Orders AS O
WHERE O.ShipDate IS NULL;

--7
SELECT 100 AS 'Price', 0.07 AS 'TaxRate', 100 * 0.07 AS 'TaxAmount', 100 + (100 * 0.07) AS 'Total'

--8
SELECT C.CategoryName, P.ProductName, P.ListPrice
FROM Categories AS C, Products AS P
ORDER BY C.CategoryName, P.ProductName ASC;

--9
SELECT C.FirstName, C.LastName, 
A.Line1, A.City, A.[State], A.ZipCode
FROM Customers AS C, Addresses AS A
WHERE C.EmailAddress = 'allan.sherwood@yahoo.com'

--10
SELECT C.FirstName, C.LastName, 
A.Line1, A.City, A.[State], A.ZipCode
FROM Customers AS C, Addresses AS A
WHERE A.AddressID = C.ShippingAddressID

--11
SELECT (C.LastName + ' ' + C.FirstName) AS 'Customer', 
O.OrderDate AS 'Order', 
P.ProductName AS 'Product', 
OI.ItemPrice, OI.DiscountAmount, OI.Quantity 
FROM Customers AS C, Orders AS O, OrderItems AS OI, Products AS P 
ORDER BY C.LastName, O.OrderDate, P.ProductName;

--12
SELECT P1.ProductName, P1.ListPrice
FROM Products AS P1, Products P2
WHERE P1.ListPrice = P2.ListPrice AND P1.ProductID != P2.ProductID
ORDER BY P1.ProductName;

--13
SELECT C.CategoryName, P.ProductID
FROM Categories AS C LEFT JOIN Products AS P
	ON P.ProductID = NULL

--14
SELECT 'Shipped' AS [ShipStatus], O.OrderID, O.OrderDate
FROM Orders AS O
WHERE O.ShipDate IS NOT NULL
UNION
SELECT 'Not Shipped', O.OrderID, O.OrderDate
FROM Orders AS O
WHERE O.ShipDate IS NULL
ORDER BY O.OrderDate

--15
SELECT COUNT (O.OrderID) AS 'Num of orders', 
SUM (O.TaxAmount) AS 'Tax Amount'
FROM Orders AS O

--16
SELECT C.CategoryName, COUNT(*) AS [Product Count],
MAX(P.ListPrice) AS [Most Expensive Product]
FROM Categories AS C JOIN Products AS P
	ON C.CategoryID = P.CategoryID
GROUP BY C.CategoryName
ORDER BY [Product Count] DESC;

--17
SELECT C.EmailAddress, SUM(OI.ItemPrice * OI.Quantity) AS [Item Price Total],
SUM(OI.DiscountAmount * OI.Quantity) AS [Discount Amount Total]
FROM Customers AS C
JOIN Orders AS O 
	ON C.CustomerID = O.CustomerID
JOIN OrderItems AS OI
	ON O.OrderID = OI.OrderID
GROUP BY C.EmailAddress
ORDER BY [Item Price Total] DESC;

--18
SELECT C.EmailAddress, COUNT(O.OrderID) AS OrderCount,
SUM((OI.ItemPrice - OI.DiscountAmount) * OI.Quantity) AS OrderTotal
FROM Customers AS C
JOIN Orders AS O 
	ON C.CustomerID = O.CustomerID
JOIN OrderItems AS OI
	ON O.OrderID = OI.OrderID
GROUP BY C.EmailAddress
HAVING COUNT(O.OrderID) > 1
ORDER BY OrderTotal DESC;

--19
SELECT C.EmailAddress, COUNT(O.OrderID) AS OrderCount,
SUM((OI.ItemPrice - OI.DiscountAmount) * OI.Quantity) AS OrderTotal
FROM Customers AS C
JOIN Orders AS O 
	ON C.CustomerID = O.CustomerID
JOIN OrderItems AS OI
	ON O.OrderID = OI.OrderID
WHERE OI.ItemPrice > 400
GROUP BY C.EmailAddress
HAVING COUNT(O.OrderID) > 1
ORDER BY OrderTotal DESC;

--20
SELECT P.ProductName, SUM((OI.ItemPrice - OI.DiscountAmount) * Quantity) AS [ProductTotal]
FROM Products AS P
JOIN OrderItems AS OI 
	ON P.ProductID = OI.ProductID
GROUP BY P.ProductName WITH ROLLUP

--21
SELECT C.EmailAddress, COUNT(DISTINCT OI.ProductID) AS [NumberOfProducts]
FROM Customers AS C
JOIN Orders AS O 
	ON C.CustomerID = O.CustomerID
JOIN OrderItems AS OI
	ON O.OrderID = OI.OrderID
GROUP BY C.EmailAddress
HAVING COUNT(DISTINCT OI.ProductID) > 1
ORDER BY C.EmailAddress;