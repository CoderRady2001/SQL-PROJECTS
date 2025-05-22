#To drop a table we use
-- drop database database_name
#To drop a table we use 
-- drop table table_name
#To delete the data inside the table we use truncate
-- Truncate table table_name
#To alter a table like for example adding a new column we use
-- Alter table table_name add column_name datatype;
#To drop a column we use the following
-- Alter table drop column column_name;
#To rename a column in a table we us ethe following
-- alter table table name rename column old_name to new_name;


USE organization;
-- Querying single table
-- #1. Fetching all the data columns
select * from customers; 
-- #2. Fetching specific Columns from a table
select	customerName, city, postalCode from customers;
-- #3 Fetching Data from specific columns and then ranking it in either ascending or descending order- We use the Order by column name and then either Desc or Asc
select customerName, city,creditLimit
from customers
 order by creditlimit desc;
 
 #SELECTING ONLY DISTINCT VALUES
 
 SELECT DISTINCT city from customers;
 
 -- Use of Aliases-Aliases in SQL are temporary names given to tables or columns to make queries more readable and concise. They do not change the actual column or table name in the database.
 #4 We use AS for aliases
 Select customerName as Name, city as Hometown, creditLimit as creditscore
 from customers;
 
 #5 Using aliases for TABLES
 Select	c.customerName,p.amount
 from payments as p
 Join customers as c
 on c.customerNumber = P.customerNumber;
 
 #Filtering the output
 -- #6. Comparison output-
 
 Select	c.customerName,p.amount
 from payments as p
 Join customers as c
 on c.customerNumber = P.customerNumber
 where p.amount>=30000
 order by p.amount desc;
 
 #Example 2: Filter based on the neither factor:
 select customerName, city 
 from customers
 where city != "Nantes"
	and city !="Las Vegas";

#Example 3
select customerName, country 
from customers
where country='USA';

-- #7 Test Operators
select customerName,city 
from customers
where country like "France";

-- One can also use the ilike function which is not case sensitive unlike using the Like which is Case sensitive
select * from customers;

select customerName, state
from customers
where state like 'CA';

#using the ilike function

select c.customerNumber,p.amount,c.state
from customers as c
join payments as p
on c.customerNumber=p.customerNumber
where c.state like '';

#Using the between to filter out

select orderNumber,round(quantityOrdered*priceEach,2)as TotalPrice 
from orderdetails;

#Example 2
select customerName, creditLimit
from customers
where creditLimit between 71800 and 100000
order by creditLimit desc;

#Example 3
-- I will select the customerName, city and the addressLine2 if the addressLine2 does not have a missing value AND IS NOT BLANK

select customerName, city, addressLine2 
from customers
where addressLine2 is not Null and addresSLine2 <> '';

#USING THE AND function- By using AND, it returns the values only if the condition is met

-- For example:
select o.orderNumber,o.status,od.quantityOrdered
from orders as o
join orderdetails as od
where  o.status='shipped' and od.quantityOrdered >30 
order by od.quantityOrdered desc;

#USING THE OR FUNCTION-is a logical operator in SQL that allows you to select rows that satisfy either of two conditions.
select o.orderNumber,o.status,od.quantityOrdered,o.comments
from orders as o
join orderdetails as od
WHERE o.status="cancelled"
and(od.quantityOrdered<30 or o.comments like 'Cautious' )
order by od.quantityOrdered desc;

#We can also use the NOT function to return values which do not match the Criteria set
-- Example
select customerName,country 
from customers
where creditLimit >100000 
AND country <> 'France';

#example 2
select o.orderNumber, o.status,od.quantityOrdered,format(od.quantityOrdered*od.priceEach,2) as Totals
from orders as o
Join orderdetails as od
on o.orderNumber=od.orderNumber
where o.status='shipped'
order by Totals desc
limit 10;

#EXAMPLE 3
SELECT c.customerName,
p.checkNumber,
round(sum(p.amount),2) as Salary_paid
from customers as c
Join payments as p
on p.customerNumber=c.customerNumber
group by c.customerName,p.checkNumber
having sum(p.amount) > 50000
order by Salary_paid desc;

-- USING THE IN function to fetch data which contains only data which contains only the mentioned values

select customerName, creditLimit, state
from customers
where state in ('NV','CA','NY','PA')
	AND creditLimit>=100000
    order by creditLimit asc;
    
-- Using the lIMIT function to display a number of rows
use organization;
select * from customers
limit 100;

-- Arithmetic in SQL
SELECT customerName,
salesRepEmployeeNumber + creditLimit as Total
from customers;

-- example 2
SELECT customerName,
(salesRepEmployeeNumber + creditLimit )/2 as Total
from customers;
 
-- AGGREGATE FUNCTIONS
#1: SQL COUNT
-- Counting all rows
select count(*) from customers; #This count(*) is used to count all the rows

select count(CustomerName) as TotalCustomers #This count(column name) is used to count all the rows in a specific column
from customers;

#2. SQL SUM
select * from orderdetails;
select round(sum(quantityOrdered*PriceEach),2) as Total_Sales 
from orderdetails;

#3. SQL Max/Min
select max(priceEach) AS Highest_Price,min(priceEach) as lowest_price
from orderdetails;

#4. SQL AVG
SELECT AVG(quantityOrdered) as Avg_Qty_Ordered from orderdetails;

#example 2
select round(avg(creditLimit),2)from customers;

 #5 SQL Group by-- we can use the group by to group all the aggregates by seperating data into groups
 -- example
 
 select status, count(orderNumber)  as Total_Orders
 from orders
 group by status;
 
#Example 2
select w.warehouseName,sum(p.quantityInstock) as Total_Stock
from warehouses as w
join products as p
on w.warehouseCode=p.warehouseCode
group by warehouseName
order by Total_Stock desc
limit 4;

-- USE OF THE CASE
select customerName,
state,
country,
case when country='USA' then 'Yes'
	else NULL end as 'USA RESIDENT'
from customers
where Country !='USA';

#JOINING TABLES
#1: JOIN or Inner Join- The INNER JOIN keyword selects records that have matching values in both tables
-- For example
use organization;

select p.productCode,
p.productName,
(od.quantityOrdered*od.priceEach) as Total_Sales
from products as p
Join orderdetails as od
on p.productCode=od.productCode;

#2: SQL LEFT JOIN Keyword- The LEFT JOIN keyword returns all records from the left table (table1), and the matching records from the right table (table2). The result is 0 records from the right side, if there is no match.
select p.productName,
p.productCode
from products as p
left join orderdetails as od
on p.productCode=od.productCode;

#3: SQL RIGHT JOIN keyword-- The RIGHT JOIN keyword returns all records from the right table (table2), and the matching records from the left table (table1). The result is 0 records from the left side, if there is no match.

select p.customerNumber
,c.customerName,
sum(p.amount) as Total_Salary
from payments as p
Right Join customers as c 
on p.customerNumber = c.customerNumber
group by p.customerNumber,c.customerName;

#4: SQL FULL OUTER JOIN Keyword-The FULL OUTER JOIN keyword returns all records when there is a match in left (table1) or right (table2) table records.

SELECT 
    customers.customerNumber,
    MIN(payments.checkNumber) AS checkNumber,
    SUM(payments.amount) AS Total_Pay
FROM customers 
LEFT JOIN payments 
ON payments.customerNumber = customers.customerNumber
GROUP BY customers.customerNumber

UNION

SELECT 
    payments.customerNumber,
    MIN(payments.checkNumber),
    SUM(payments.amount)
FROM payments
LEFT JOIN customers 
ON payments.customerNumber = customers.customerNumber
GROUP BY payments.customerNumber;

#NATURAL JOIN
SELECT 
    customerNumber,
    checkNumber,
    avg(amount) as Total_Pay
FROM payments
natural jOIN customers
group by customerNumber,checkNumber;

#SQL EXISTS--- The EXISTS operator is used to test for the existence of any record in a subquery.

select customerName
from customers
where exists(select 1 from payments where payments.customerNumber=customers.customerName and checkNumber='BO864823');

# CREATING VIEWS
use organization;
select * from customers;

Create view Highest_Paid_Customers as
select c.customerName,
p.paymentDate,
sum(p.amount) as Total_Salary
from customers as c
Join payments as p on c.customerNumber=p.customerNumber
group by c.customerName,p.paymentDate
order by Total_Salary Desc 
limit 10;
select * from Highest_Paid_Customers;

#SUBQUERY IN WHERE
USE organization;
select orderNumber,
datediff(ShippedDate,RequiredDate) as Days_To_Ship,
Case when shippedDate>=RequiredDate then 'On_Time'
Else 'late' End as Shipping_Status
from orders;

select o.orderNumber,o.status,od.quantityOrdered
from orders as o
join orderdetails as od
on od.orderNumber=o.orderNumber
where od.orderNumber in(select od.orderNumber from orderdetails where od.quantityOrdered<=50);

#example 2
SELECT 
    c.customerName,
    c.city,
    round(SUM(p.amount),0) AS Total_pay,
    CASE 
        when  round(SUM(p.amount),0)<= 100000 THEN 'Low_Sales' 
        ELSE 'Low_Sales' 
    END AS Payment_Status
FROM customers AS c
JOIN payments AS p ON c.customerNumber = p.customerNumber
GROUP BY c.customerName, c.city;

#Example 3
SELECT checkNumber, amount,
       (SELECT AVG(amount) FROM payments) AS Avg_Sales,
       CASE 
           WHEN amount > (SELECT AVG(amount) FROM payments) THEN 'Above Avg'
           ELSE 'Below Avg'
       END AS Payment_Category
FROM payments;

#SQL String Functions (LEFT, RIGHT, POSITION, CONCAT, LOWER, REPLACE)
#1: CHAR_lENGTH- Returns the length of a string (in characters)
SELECT customerName,char_length(customerName)
from customers;

#2:LEFT-- Extracts a number of characters from a string (starting from left)

select customerName,left(customerName, 5)
from customers;

#3: RIGHT--Extracts a number of characters from a string (starting from right)

SELECT customerName, right(customerName,7) from customers;

#4:POSITION--cHECKS THE POSITION WHERE A CHARACTER IS AT

SELECT customerName,position(' 'in customerName) from customers;
-- we can use the position to split a column
SELECT customerName,left(customerName,position(' ' in customerName)) as First_Name, Right(customerName,char_length(customerName)-position(' ' in customerName)) as lastName from customers;

#5:CONCAT-- This is used to merge columns

select * from customers;

select customerName, concat(city," ",state," ","-",postalCode) as Address_2 from customers;

#UPPER- This capitalizes every single word of the mentioned column
select upper(contactLastName) as capital_FirstName
from customers;

#lOWER- small letter for each WORD
SELECT lower(contactLastName) as LastName
from customers;

#example 2
select contactLastName
from customers
where lower(contactLastName) LIKE '%c%' ;

#REPLACE - Replacing content string in column with your desired input

SELECT 
    customerName,
    COALESCE(NULLIF(addressLine2, ''), 'Not_Applicable') AS AddressLine2
FROM customers;
-- UPDATING VALUES IN A TABLE IN SQL
UPDATE customers
SET addressLine2 = 'Not_Available'
WHERE addressLine2 = '' OR addressLine2 IS NULL;







