use AdventureWorks2019

--1. Przygotuj blok anonimowy, który:
--- znajdzie średnią stawkę wynagrodzenia pracowników, - wyświetli szczegóły pracowników, których stawka wynagrodzenia jest niższa niż średnia.
BEGIN 
	SELECT AVG(Rate) AS srednia_stawka_pracownikow FROM HumanResources.EmployeePayHistory
	SELECT JobTitle, Rate, FirstName, LastName FROM HumanResources.Employee join HumanResources.EmployeePayHistory ON HumanResources.EmployeePayHistory.BusinessEntityID= HumanResources.Employee.BusinessEntityID
	join Person.Person ON Person.BusinessEntityID = HumanResources.Employee.BusinessEntityID
	WHERE Rate < (SELECT avg(Rate) FROM HumanResources.EmployeePayHistory)
END	
--2. Utwórz funkcję, która zwróci datę wysyłki określonego zamówienia.
GO
CREATE OR ALTER FUNCTION data_wysylki(@x int)
	RETURNS VARCHAR(80)
	BEGIN
		DECLARE @ship DATETIME
		SELECT @ship = (SELECT ShipDate FROM Sales.SalesOrderHeader WHERE SalesOrderID = @x)
		RETURN @ship 
	END

GO
SELECT dbo.data_wysylki(43699)
	
--3. Utwórz procedurę składowaną, która jako parametr przyjmuję nazwę produktu, a jako rezultat wyświetla jego identyfikator, numer i dostępność.
GO
CREATE OR ALTER PROCEDURE produkt(@x varchar(255))
	AS SELECT Product.ProductID, LocationID, Name, Quantity from Production.Product join Production.ProductInventory ON Product.ProductID = ProductInventory.ProductID Where Product.Name = @x
	GO

	EXEC produkt 'Chainring Bolts'

--4. Utwórz funkcję, która zwraca numer karty kredytowej dla konkretnego zamówienia.
GO
CREATE OR ALTER FUNCTION karta(@x int)
	RETURNS VARCHAR(255)
	BEGIN
	DECLARE @numer VARCHAR(255)
	SELECT @numer = (SELECT CardNumber from Sales.CreditCard join Sales.SalesOrderHeader on Sales.CreditCard.CreditCardID = Sales.SalesOrderHeader.CreditCardID where SalesOrderID = @x)
	RETURN @numer
END	
GO

SELECT * from  Sales.SalesOrderHeader
SELECT dbo.karta(43679)		

--5. Utwórz procedurę składowaną, która jako parametry wejściowe przyjmuje dwie liczby, num1 i num2, a zwraca wynik ich dzielenia. Ponadto wartość num1 powinna zawsze być większa niż wartość num2. Jeżeli wartość num1 jest mniejsza niż num2, wygeneruj komunikat o błędzie „Niewłaściwie zdefiniowałeś dane wejściowe”.
GO
CREATE OR ALTER PROCEDURE dzielenie(@x float, @y float)
	AS BEGIN 
	if(@x<@y) print 'Niewłaściwie zdefiniowałeś dane wejściowe'
	else 
	DECLARE @wynik float
	SET @wynik = @x/@y
	SELECT @wynik
	RETURN
END
GO
EXEC dzielenie 12,9

--6. Napisz procedurę, która jako parametr przyjmie NationalIDNumber danej osoby, a zwróci stanowisko oraz liczbę dni urlopowych i chorobowych.
GO
CREATE OR ALTER PROCEDURE urlop(@x int)
	AS BEGIN 
	SELECT JobTitle, VacationHours/8 as VacationDays, SickLeaveHours/8 AS SickLeaveDays FROM HumanResources.Employee WHERE NationalIDNumber = @x
RETURN
END
GO

EXEC urlop 112457891

--7. Napisz procedurę będącą kalkulatorem walutowym. Wykorzystaj dwie tabele: Sales.Currency oraz Sales.CurrencyRate. Parametrami wejściowymi mają być: kwota, waluty oraz data (CurrencyRateDate). Przyjmij, iż zawsze jedną ze stron jest dolar amerykański (USD). Zaimplementuj kalkulację obustronną, tj:
--1400 USD → PLN lub PLN → USD
GO
CREATE OR ALTER PROCEDURE currency(@v1 char(3),@v2 char(3),@x float, @date datetime)
	AS BEGIN 
		DECLARE @rate float
		DECLARE @wynik float
		if @v1 = 'USD'
			BEGIN
			SELECT @rate = AverageRate FROM Sales.CurrencyRate Where ModifiedDate = @date AND ToCurrencyCode = @v2
			SET @wynik =@x*@rate
			END
		else if @v2 = 'USD'
			BEGIN
			SELECT @rate = AverageRate FROM Sales.CurrencyRate Where ModifiedDate = @date AND ToCurrencyCode = @v1
			SET @wynik=@x/@rate
			END
			
		PRINT @wynik
		RETURN
	END
GO

exec currency 'USD','JPY',1000,'2011-06-01 00:00:00.000';
exec currency 'JPY','USD',1000,'2011-06-01 00:00:00.000';
	SELECT * FROM Sales.CurrencyRate