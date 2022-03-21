/*
1    Select CategoryName and Description from the Categories table sorted by
2    Select ContactName, CompanyName, ContactTitle, and Phone from the Customers table sorted by
3    Create a report showing employees' first and last names and hire dates sorted from newest to oldest employee.
4    Create a report showing Northwind's orders sorted by Freight from most expensive to Show OrderID, OrderDate, ShippedDate, CustomerID, and Freight.
5    Select CompanyName, Fax, Phone, HomePage and Country from the Suppliers table sorted by Country in descending order and then by CompanyName in ascending
6    Create a report showing all the company names and contact names of Northwind's customers in Buenos
7    Create a report showing the product name, unit price and quantity per unit of all products that are out of
8    Create a report showing the order date, shipped date, customer id, and freight of all orders placed on May 19,
9    Create a report showing the first name, last name, and country of all employees not in the United States.
10    Create a report that shows the employee id, order id, customer id, required date, and shipped date of all orders that were shipped later than they were
11    Create a report that shows the city, company name, and contact name of all customers who are in cities that begin with "A" or "B."
12    Create a report that shows all orders that have a freight cost of more than $500.00.
13    Create a report that shows the product name, units in stock, units on order, and reorder level of all products that are up for reorder
14    Create a report that shows the company name, contact name and fax number of all customers that have a fax
15    Create a report that shows the first and last name of all employees who do not report to anybody
16    Create a report that shows the company name, contact name and fax number of all customers that have a fax number. Sort by company
17    Create a report that shows the city, company name, and contact name of all customers who are in cities that begin with "A" or "B." Sort by contact name in descending order
18    Create a report that shows the first and last names and birth date of all employees born in the
19    Create a report that shows the product name and supplier id for all products supplied by Exotic Liquids, Grandma Kelly's Homestead, and Tokyo Hint: you will need to first do a separate SELECT on the Suppliers table to find the supplier ids of these three companies.
20    Create a report that shows the shipping postal code, order id, and order date for all orders with a ship postal code beginning with "02389".
21    Create a report that shows the contact name and title and the company name for all customers whose contact title does not contain the word "Sales".
22    Create a report that shows the first and last names and cities of employees from cities other than Seattle in the state of
23    Create a report that shows the company name, contact title, city and country of all customers in Mexico or in any city in Spain except
24    Write a SELECT statement that outputs the
25    Create a report that shows the units in stock, unit price, the total price value of all units in stock, the total price value of all units in stock rounded down, and the total price value of all units in stock rounded up. Sort by the total price value
26    In an earlier query, you saw a report that returned the age of each employee when hired. That report was not entirely accurate as it didn't account for the month and day the employee was born. Fix that report, showing both the original (inaccurate) hire age and the actual hire age. The result will look like this.
27   Create a report that shows the first and last names and birth month (as a string) for each employee born in the current
28    Create a report that shows the contact title in all lowercase letters of each customer
29    The above SELECT statement will return the following results
30    Create a report that shows all products by name that are in the Seafood
31    Create a report that shows all companies by name that sell products in CategoryID
32    Create a report that shows all companies by name that sell products in the Seafood
33    Create a report that shows the order ids and the associated employee names for orders that shipped after the required date. It should return the following. There should be 37 rows
34	Create a report that shows the total quantity of products (from the Order_Details table) Only show records for products for which the quantity ordered is fewer than 200. The report should return the following 5 rows.
35	Create a report that shows the total number of orders by Customer since December 31, 1996. The report should only return rows for which the NumOrders is greater than The report should return the following 5 rows.
36	Create a report that shows the company name, order id, and total price of all products of which Northwind has sold more than $10,000 There is no need for a GROUP BY clause in this report.
*/

USE Northwind;
--35
SELECT C.CompanyName, COUNT (*) as 'NumOrders'
FROM [Orders] AS O
INNER JOIN Customers AS C
	ON O.CustomerID = C.CustomerID
WHERE O.OrderDate > '1996-12-31'
GROUP BY C.CompanyName
HAVING COUNT(*) > 15;

--36
SELECT C.CompanyName, O.OrderID, SUM(OD.UnitPrice * OD.Quantity) AS 'Total Price'
FROM Customers AS C
INNER JOIN Orders AS O
	ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD
	ON O.OrderID = OD.OrderID
HAVING SUM(OD.UnitPrice * OD.Quantity) > 10000;

