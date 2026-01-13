USE Customers_Orders_Products;

CREATE TABLE Customers (
CustomerID INT PRIMARY KEY,
Name VARCHAR(50),
Email VARCHAR(100)
);

CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustomerID INT,
ProductName VARCHAR(50),
OrderDate DATE,
Quantity INT,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
Price DECIMAL(10, 2)
);

INSERT INTO Customers (CustomerID, Name, Email)
VALUES
(1, 'John Doe', 'johndoe@example.com'),
(2, 'Jane Smith', 'janesmith@example.com'),
(3, 'Robert Johnson', 'robertjohnson@example.com'),
(4, 'Emily Brown', 'emilybrown@example.com'),
(5, 'Michael Davis', 'michaeldavis@example.com'),
(6, 'Sarah Wilson', 'sarahwilson@example.com'),
(7, 'David Thompson', 'davidthompson@example.com'),
(8, 'Jessica Lee', 'jessicalee@example.com'),
(9, 'William Turner', 'williamturner@example.com'),
(10, 'Olivia Martinez', 'oliviamartinez@example.com'),
(11, 'James Anderson', 'jamesanderson@example.com'),
(12, 'Kelly Clarkson', 'kellyclarkson@example.com');

INSERT INTO Products (ProductID, ProductName, Price)
VALUES
(1, 'Product A', 10.99),
(2, 'Product B', 8.99),
(3, 'Product C', 5.99),
(4, 'Product D', 12.99),
(5, 'Product E', 7.99),
(6, 'Product F', 6.99),
(7, 'Product G', 9.99),
(8, 'Product H', 11.99),
(9, 'Product I', 14.99),
(10, 'Product J', 4.99),
(11, 'Product K', 3.99),
(12, 'Product L', 15.99);

INSERT INTO Orders (OrderID, CustomerID, ProductName, OrderDate, Quantity)
VALUES
(1, 1, 'Product A', '2023-07-01', 5),
(2, 2, 'Product B', '2023-07-02', 3),
(3, 3, 'Product C', '2023-07-03', 2),
(4, 4, 'Product A', '2023-07-04', 1),
(5, 5, 'Product B', '2023-07-05', 4),
(6, 6, 'Product C', '2023-07-06', 2),
(7, 7, 'Product A', '2023-07-07', 3),
(8, 8, 'Product B', '2023-07-08', 2),
(9, 9, 'Product C', '2023-07-09', 5),
(10, 10, 'Product A', '2023-07-10', 1),
(11, 11, 'Product D', '2023-07-10', 3),
(12, 12, 'Product E', '2023-07-11', 6),
(13, 5, 'Product G', '2023-07-12', 2),
(14, 4, 'Product H', '2023-07-13', 4),
(15, 6, 'Product I', '2023-07-14', 3)

SELECT * FROM Products
SELECT * FROM Orders
SELECT * FROM Customers

---Task 1---

--1. Write a query to retrieve all records from the Customers table.

SELECT * FROM Customers

--2. Write a query to retrieve the names and email addresses of customers whose names start with 'J'.

SELECT Name,Email
FROM Customers
WHERE Name LIKE 'J%';

--3. Write a query to retrieve the order details (OrderID, ProductName,Quantity) for all orders.

SELECT OrderID,ProductName,Quantity 
FROM Orders

--4.Write a query to calculate the total quantity of products ordered.

SELECT SUM(Quantity) AS Total_Quantity
FROM Orders

--5. Write a query to retrieve the names of customers who have placed an order.

SELECT C.Name
FROM Orders AS O
JOIN Customers AS C
ON
O.CustomerID = C.CustomerID;

--6. Write a query to retrieve the products with a price greater than $10.00.

SELECT ProductName,Price
FROM Products
WHERE Price > 10;

--7. Write a query to retrieve the customer name and order date for all orders placed on or after '2023-07-05'.

SELECT Name,OrderDate 
FROM Orders
JOIN Customers
ON
Orders.CustomerID = Customers.CustomerID
WHERE OrderDate >= '2023-07-05';

--8. Write a query to calculate the average price of all products.

SELECT AVG(Price) FROM Products;

--9. Write a query to retrieve the customer names along with the total quantity of products they have ordered.

SELECT O.CustomerID,Name,SUM(Quantity) AS Total_Quantity
FROM Orders AS O
JOIN Customers AS C
ON
O.CustomerID = C.CustomerID
GROUP BY Name,O.CustomerID;

--10. Write a query to retrieve the products that have not been ordered.

SELECT P.ProductID, P.ProductName
FROM Products P
LEFT JOIN Orders O 
ON P.ProductName = O.ProductName
WHERE O.OrderID IS NULL;

---Task 2---

--1. Write a query to retrieve the top 5 customers who have placed the highest total quantity of orders.

SELECT TOP 5
C.Name,C.CustomerID,SUM(O.Quantity) AS Total_Quantity
FROM Customers AS C
JOIN Orders AS O
ON
C.CustomerID = O.CustomerID
GROUP BY C.Name,C.CustomerID
ORDER BY Total_Quantity DESC

--2. Write a query to calculate the average price of products for each product category.

--Sol: SELECT ProductCategory,AVG(Price) AS AvgPrice FROM Products GROUP BY ProductCategory;

--3. Write a query to retrieve the customers who have not placed any orders.

SELECT C.CustomerID,C.Name
FROM Customers AS C
LEFT JOIN Orders O 
ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL;

--4. Write a query to retrieve the order details (OrderID, ProductName,Quantity) for orders placed by customers whose names start with 'M'.

SELECT O.OrderID,O.ProductName,O.Quantity
FROM Customers AS C
LEFT JOIN Orders O 
ON C.CustomerID = O.CustomerID
WHERE C.Name LIKE 'M%'

--5. Write a query to calculate the total revenue generated from all orders.

SELECT SUM(Quantity * Price) AS Total_Revenue
FROM Orders
JOIN Products
ON
Orders.ProductName = Products.ProductName

--6. Write a query to retrieve the customer names along with the total revenue generated from their orders.

SELECT C.CustomerID,C.Name,SUM(O.Quantity * P.Price) AS CustomerRevenue
FROM Orders O
JOIN Products P 
ON o.ProductName = P.ProductName
JOIN Customers C 
ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.Name
ORDER BY CustomerRevenue DESC;

--7. Write a query to retrieve the customers who have placed at least one order for each product category.

SELECT C.Name,O.Quantity
FROM Orders O
JOIN Products P 
ON o.ProductName = P.ProductName
JOIN Customers C 
ON O.CustomerID = C.CustomerID
WHERE Quantity >= 1;

--8. Write a query to retrieve the customers who have placed orders on consecutive days.

WITH OrderedDates AS (
    SELECT 
        CustomerID,
        OrderDate,
        LAG(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS PrevOrderDate
    FROM Orders
)
SELECT DISTINCT OD.CustomerID, CU.Name
FROM OrderedDates OD
JOIN Customers CU ON OD.CustomerID = CU.CustomerID
WHERE DATEDIFF(DAY, OD.PrevOrderDate, OD.OrderDate) = 1;

--9. Write a query to retrieve the top 3 products with the highest average quantity ordered.

SELECT TOP 3
P.ProductName,AVG(Quantity) AS Avg_Quantity
FROM Orders O
JOIN Products P 
ON o.ProductName = P.ProductName
JOIN Customers C 
ON O.CustomerID = C.CustomerID
GROUP BY P.ProductName
ORDER BY Avg_Quantity DESC


--10. Write a query to calculate the percentage of orders that have a quantity greater than the average quantity.


SELECT 
    CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Orders) AS DECIMAL(5,2)) AS PercentageAboveAverage
FROM Orders
WHERE Quantity > (SELECT AVG(Quantity) FROM Orders);