USE MyGuitarShop;
--Script 1
DECLARE @AllProducts int;

SET @AllProducts =
	(SELECT COUNT(P.ProductID)
	 FROM Products AS P);

IF @AllProducts >= 7
	BEGIN
		PRINT 'The number of products is greater than or equal to 7';
	END;
ELSE
	BEGIN
		PRINT 'The number of products if less than 7';
	END;
GO

USE MyGuitarShop;
--Script 2
DECLARE @AllProductsAgain int;
DECLARE @AvgListPrice money;

SET @AllProductsAgain =
	(SELECT COUNT(P.ProductID)
	 FROM Products AS P);

SET @AvgListPrice =
	(SELECT AVG(P.ListPrice)
	 FROM Products AS P);

IF @AllProductsAgain >= 7
	BEGIN
		PRINT 'Total Products = ' + CONVERT(varchar,@AllProductsAgain,1) 
		+ ' Average Listing Price = $' + CONVERT(varchar,@AvgListPrice,1);
	END;
ELSE
	BEGIN
		PRINT 'The number of products if less than 7';
	END;