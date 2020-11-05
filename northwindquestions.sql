--Make a list of products that are out of stock. 
SELECT productname
FROM products
WHERE unitsinstock = 0

--Make a list of products that are out of stock and have not been discontinued. Include the suppliers’ names. 
SELECT productname
FROM products
WHERE unitsinstock = 0 AND discontinued = 0

--Make a list of products that need to be re-ordered i.e. where the units in stock and the units on order is less than the reorder level. 
SELECT productname
FROM products
WHERE (unitsinstock + unitsonorder) < reorderlevel

--Make a list of products and the number of orders in which the product appears.  
--Put the most frequently ordered item at the top of the list and so on to the least frequently ordered item.  
SELECT p.productid, p.productname, count(p.productid) AS orders
FROM products AS p
JOIN order_details AS o
ON p.productid = o.productid
GROUP BY p.productid
ORDER BY orders DESC

--Make a list of products and total up the number of actual items ordered.  
--Put the most frequently ordered item at the top of the list and so on to the least frequently ordered item.
SELECT p.productid, p.productname, sum(o.quantity) AS q
FROM products AS p
JOIN order_details AS o
ON p.productid = o.productid
GROUP BY p.productid
ORDER BY q DESC

--Make a list of categories and suppliers who supply products within those categories.  
SELECT DISTINCT(c.categoryid), c.categoryname, s.supplierid, s.companyname
FROM products AS p
JOIN suppliers AS s
ON p.supplierid = s.supplierid
JOIN categories as c
ON p.categoryid = c.categoryid
ORDER BY s.companyname

--Make a complete list of customers, the OrderID and date of any orders they have made. 
SELECT c.customerid, c.companyname, o.orderdate
FROM customers AS c
LEFT JOIN orders AS o
ON c.customerid = o.customerid

--Create a query that determines the customer who has placed the maximum number of orders. 
WITH T1 AS (SELECT o.customerid, c.companyname, COUNT(o.orderid) AS mycount
FROM orders AS o
JOIN customers AS c
ON o.customerid = c.customerid
GROUP BY o.customerid, c.companyname)

SELECT companyname, mycount
FROM T1
WHERE mycount = (SELECT MAX(mycount) FROM T1)
GROUP BY companyname, mycount
