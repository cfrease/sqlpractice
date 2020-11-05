/*https://github.com/emilj858/SQL-Exercises/blob/master/sql-exercises.sql*/

/* 1.  Write a query to return all category names with their descriptions from the Categories table. */ 
SELECT categoryname, description
FROM categories

/* 2. Write a query to return the contact name, customer id, company name and city name of all Customers in London */
SELECT contactname, companyname, customerid
FROM customers
WHERE city = 'London'

/* 3. Write a query to return all available columns in the Suppliers tables for the marketing managers and sales representatives that have a FAX number */
SELECT *
FROM suppliers
WHERE contacttitle = 'Sales Representative' OR contacttitle = 'Marketing Manager' AND fax != null

/* 4. Write a query to return a list of customer id's from the Orders table with required dates between Jan 1, 1997 and Dec 31, 1997 and with freight under 100 units. */
SELECT customerid
FROM orders
WHERE requireddate BETWEEN '1996-01-01' AND '1996-12-31' AND freight < 100

/* 5. Write a query to return a list of company names and contact names of all customers from Mexico, Sweden and Germany. */
SELECT companyname, contactname
FROM customers
WHERE country IN ('Mexico', 'Sweden', 'Germany')