create database Walmart;
use Walmart;

select * from walmart;
#Find the total number of unique users in the dataset.
select count(distinct User_ID) from Walmart;

-- List the top 5 most frequently purchased product categories.
select Product_Category,count(User_ID) FROM walmart
group by Product_Category
order by count(User_ID) DESC
LIMIT 5;

-- Find the average purchase amount by gender.

SELECT Gender, avg(Purchase)
from Walmart
group by Gender;

-- Determine the total purchase amount made by users aged between 25 and 35.
select sum(Purchase)
from Walmart
where Age='26-35';

-- Show the number of users by marital status and city category.

select Marital_Status,City_Category,count(Distinct User_ID)
FROM walmart
group by Marital_Status,City_Category;

#What is the average number of years users have stayed in their current city by occupation?

SELECT User_ID,Occupation,avg(Stay_In_Current_City_Years)
from Walmart
group by User_ID,Occupation;


#Identify the top 3 occupations with the highest total purchase value.

select Occupation, sum(Purchase) as Total_Spent
from Walmart
group by Occupation
Order BY Total_Spent desc
Limit 3;

SELECT Occupation, SUM(Purchase) AS total_spent
FROM Walmart
GROUP BY Occupation
ORDER BY total_spent DESC
LIMIT 3;

#Find out how many purchases were made by each age group.
Select Age,count(Product_ID) as Total_Purchases
FROM Walmart
group by Age
ORDER by count(Product_ID) DESC;

SELECT Age, COUNT(*) AS purchase_count
FROM Walmart
GROUP BY Age
ORDER BY purchase_count DESC;

#List all users who have made more than 10 purchases, sorted by total amount spent.
SELECT User_ID,count(Product_ID) as Total_Purchases,sum(Purchase) as Total_Amount_Spent
from Walmart
group by User_ID
having count(Product_ID) > 10
order by sum(Purchase) desc;

#For each product category, calculate the average purchase value and the number of users.
select Product_Category,
		avg(Purchase) as Avg_Purchases,
        count(distinct User_ID) as Total_Users
FROM Walmart
group by Product_Category;

 SELECT Product_Category, 
       AVG(Purchase) AS avg_purchase, 
       COUNT(DISTINCT User_ID) AS user_count
FROM Walmart
GROUP BY Product_Category
ORDER BY avg_purchase DESC;

SELECT * FROM Walmart;

#Find the top 3 users with the highest total purchase in each city category.
select User_ID,
		Product_Category,
		sum(Purchase) as Total_Purchase
from Walmart
group by User_ID,Product_Category
order by Total_Purchase Desc
limit 3;

#Determine the gender and age group with the highest average purchase.
select Gender,Age, avg(Purchase) as Avg_Purchase
from walmart
group by Gender, Age
order by Avg_Purchase desc
limit 1;

SELECT Gender, Age, AVG(Purchase) AS avg_purchase
FROM Walmart
GROUP BY Gender, Age
ORDER BY avg_purchase DESC
LIMIT 1;

#For each user, calculate their total purchases, and show how they rank overall.
SELECT 
    User_ID,
    SUM(Purchase) AS total_purchase,
    RANK() OVER (ORDER BY SUM(Purchase) DESC) AS purchase_rank
FROM Walmart
GROUP BY User_ID
ORDER BY purchase_rank;

#Find the product category that has the most purchases from users who have stayed more than 3 years in their current city.
select Product_Category, count(*)
FROM walmart
WHERE Stay_In_Current_City_Years= '4+'
group by Product_Category
LIMIT 1;

# Create a report showing total and average purchases per occupation, but only for male users aged 26–35.
select Occupation, 
		sum(Purchase),
		avg(Purchase)
from Walmart
where Gender='M' and Age='26-35'
group by Occupation;

#. Identify users who have made purchases in at least 3 different product categories.
select * from Walmart;

select User_ID, 
	COUNT(Product_Category) as Total_Products
from Walmart
group by User_ID
having Total_Products>=3;

SELECT User_ID
FROM Walmart
GROUP BY User_ID
HAVING COUNT(DISTINCT Product_Category) >= 3;

#Determine the most popular product category for each marital status group.
select Marital_Status,max(distinct Product_Category) as Highest_Product_Category
from Walmart
Group by Marital_Status
Order by Highest_Product_Category desc
Limit 1;

#For each occupation, show the percentage of total purchase value contributed by female users.
SELECT 
    Occupation,
    ROUND(
        SUM(CASE WHEN Gender = 'F' THEN Purchase ELSE 0 END) * 100.0 / SUM(Purchase), 2
    ) AS female_purchase_percent
FROM Walmart
GROUP BY Occupation
ORDER BY female_purchase_percent DESC;


#Finding Duplicates

select User_ID,count(User_ID) AS DUPLICATES
FROM walmart
group by User_ID
HAVING DUPLICATES>1
ORDER BY DUPLICATES DESC;

-- Use of the Row labelling.
SELECT 
    User_ID,
    COUNT(User_ID) AS DUPLICATES,
    ROW_NUMBER() OVER (ORDER BY COUNT(User_ID) DESC) AS Highest_duplicated_Position
FROM Walmart
GROUP BY User_ID
HAVING COUNT(User_ID) > 1;

-- use of the Rank
SELECT 
    User_ID,
    COUNT(User_ID) AS DUPLICATES,
    RANK() OVER (ORDER BY COUNT(User_ID) DESC) AS Highest_duplicated_Position
FROM Walmart
GROUP BY User_ID
HAVING COUNT(User_ID) > 1;

-- use of the Dense Rank
SELECT 
    User_ID,
    COUNT(User_ID) AS DUPLICATES,
    dense_rank() OVER (ORDER BY COUNT(User_ID) DESC) AS Highest_duplicated_Position
FROM Walmart
GROUP BY User_ID
HAVING COUNT(User_ID) > 1;

-- USING THE PARTITION BY
SELECT User_ID, Gender,sum(Stay_In_Current_City_Years) as Total_Stay,
dense_rank() over(partition by Gender order by sum(Stay_In_Current_City_Years) desc) as Highest_Stays
from Walmart
group by User_ID,Gender
where Highest_Stays >=3 ;

SELECT *
FROM (
    SELECT 
        User_ID,
        Gender,
        SUM(CAST(CASE 
            WHEN Stay_In_Current_City_Years = '4+' THEN 4 
            ELSE Stay_In_Current_City_Years 
        END AS UNSIGNED)) AS Total_Stay,
        DENSE_RANK() OVER (PARTITION BY Gender ORDER BY 
            SUM(CAST(CASE 
                WHEN Stay_In_Current_City_Years = '4+' THEN 4 
                ELSE Stay_In_Current_City_Years 
            END AS UNSIGNED)) DESC) AS Highest_Stays
    FROM Walmart
    GROUP BY User_ID, Gender
) ranked_data
WHERE Highest_Stays >= 3;



-- Adding a column to represent the highest duplicated User_ID

UPDATE Walmart
SET User_ID='1000003'
WHERE User_ID='1000001';









