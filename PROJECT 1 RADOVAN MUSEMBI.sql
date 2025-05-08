CREATE DATABASE if not exists HOSPITAL;

use hospital;
CREATE TABLE if not exists PATIENTS(
Patient_id int not null primary key,
First_name varchar(50) Not Null,
last_name varchar(50) Not Null,
DOB YEAR not null
);
alter table PATIENTS modify Patient_id int auto_increment;

insert into PATIENTS(patient_id,First_name,last_name,DOB) 
VALUES
(1,"Radovan","Musembi",2001),
(2,"John","james",2002),
(3,"jules","januarius",2003),
(4,"billy","Mutua",2004),
(5,"blakes","Mutinda",2005),
(6,"Junior","mwangi",2007);

Update Patients 
set Patient_id=101
where Patient_id=1;

SELECT * FROM PATIENTS;

CREATE TABLE DOCTORS(
Doctor_id int Not Null primary key,
FirstName varchar(50) Not Null,
LastName Varchar(50) Not Null,
Specialization varchar(50)

);

insert into DOCTORS(Doctor_id,FirstName,LastName,Specialization)
values
(1,"Dr_James","Gachukia","Surgeon"),
(2,"Dr_Kimeu","Mark","Dentist"),
(3,"Dr_kamau","Blakes","Intern"),
(4,"Judy","Gacheki","Nurse"),
(5,"Kim","George","Radiographer"),
(6,"Irene","Mugo","Radiographer");


Create table appointments(
appointment_id int primary key Not Null,
patient_id int Not Null,
Doctor_id Int not Null,
Appointment_date date Not Null,
Appointment_status ENUM('Scheduled', 'Completed', 'Canceled') NOT NULL
);

Insert into appointments(appointment_id,patient_id,Doctor_id,Appointment_date,Appointment_status)
values
(234,1,1,"2024-2-3","Scheduled"),
(235,2,2,"2024-2-4","Scheduled"),
(245,3,3,"2024-2-5","completed"),
(246,4,4,"2024-2-6","Canceled"),
(247,5,5,"2024-2-7","Completed"),
(258,6,6,"2024-2-8","Scheduled");

select * from appointments;

-- QUESTIION A(a)
select ap.appointment_id,
Pat.First_name,
Pat.last_name,
Doc.FirstName,
Doc.LastName,
Doc.Specialization,
ap.Appointment_date,
ap.Appointment_status
From appointments as ap
Join patients as pat
on ap.patient_id=pat.patient_id
Join doctors as Doc on ap.Doctor_id=Doc.Doctor_id;

-- Question A(b): Creating an indexing strategy
delimiter $$
create index idenx_appointment_date on appointments(Appointment_date);

Begin
select * from appointments where Appointment_date="2024-2-4";idenx_appointment_date

end//

delimiter ;

-- QUESTION B 
Create database E_commerce;
USE E_commerce;
create table Customers(
Customer_id int primary key Not Null,
FirstName Varchar(50) Not Null,
lastName varchar(50) Not Null,
Email varchar(20) Not Null
);

create table orders(
Order_id int Primary key Not Null,
customer_id int Not Null,
Order_date date Not Null,
Total_Amount decimal(10,2) Not Null
);

create table order_details(
orderdetailID INT not Null primary key,
order_id int not Null,
product_id int Not Null,
quantity decimal(10,2) Not Null,
price int Not Null
);

-- QUESTION B(a)
select 
o.Order_id,
c.FirstName,
c.lastName,
o.Order_date,
o.Total_Amount
from orders as o
join Customers as c on c.customer_id=o.customer_id;

-- QUESTION C 
CREATE DATABASE x;
use X;

CREATE TABLE DEPARTMENTS(
DepartmentID INT AUTO_INCREMENT PRIMARY KEY Not Null,
departmentName varchar(20) Not Null
);

create table Employees(
employeeID INT AUTO_INCREMENT PRIMARY KEY ,
FirstName varchar(20) Not Null,
LastName varchar(20) Not Null,
DepartmentID int,
FOREIGN KEY(DepartmentID) REFERENCES DEPARTMENTS(DepartmentID) ON DELETE SET NULL
);

-- QUESTION C(a)
select emp.FirstName,
emp.LastName,
dep.departmentName
from Employees as emp 
inner join DEPARTMENTS AS dep
on emp.DepartmentID=dep.DepartmentID;

-- Question C(b)
SELECT 
    emp.FirstName,
    emp.LastName,
    dep.departmentName
FROM Employees AS emp
LEFT JOIN DEPARTMENTS AS dep 
ON emp.DepartmentID = dep.DepartmentID;

-- QUESTION C(c)
-- For INNER JOIN- Returns only matching rows between both tables,, For Left Join- Returns all rows from the left table and matches from the right table,, If no match is found,
-- INNER JOIN can be used in a company wwhich wants to match each employee and department. For LEFT JOIN- Can be used to show all employees, even those not assigned to a department

-- QUESTION C(d)
 SELECT 
    emp.FirstName,
    emp.LastName,
    dep.departmentName
FROM Employees AS emp
CROSS JOIN DEPARTMENTS AS dep;
 
-- QUESTION C(e)

SELECT 
    emp.FirstName AS Employee,
    emp.LastName AS EmployeeLastName,
    mng.FirstName AS Manager,
    mng.LastName AS ManagerLastName
FROM
    Employees AS emp,
	SELF JOIN
    Employees AS mng ON emp.ManagerID = mng.EmployeeID;
    
-- The reason why SELF JOIN is important is because a self-join is used when a table relates to itself

-- QUESTION D (a)
Delimiter $$
create procedure GetStudentStats(
in student_id INT,
OUT Total_courses int,
out Avg_GRADE DECIMAL(10,2)
)
Begin
select count(*) into Total_courses
from enrollments
where student_id=student_id;

select avg() into Avg_Grade
From enrollments
where student_id=student_id;

end//
Delimiter ;

-- QUESTION D(b)
-- To handle the cases where the student has not enrolled in any course, I will use the IFNULL, and also countercheck my data to ensure that all the students exist in the students table

-- Question D(C)
-- By using the stored Procedures, this makes it possible  to enhance data integrity, it also enhances security and also simplifies complex operations.

-- question E(a)
create database Administrator;
use Administrator;
create table products(
product_id int primary key Auto_increment,
ProductName varchar(50) not Null,
stock_Quantity_kg int not null

);

alter table products rename column stock_Quantity to stock_Quantity_kg;

Insert into products(product_id,ProductName,stock_Quantity) 
values
(1,"Sugar",1000),
(2,"Rice",1200),
(3,"milk",9000),
(4,"Tea_leaves",789),
(5,"MAIZE_FLOOR",788);

create table orders(
OrderID INT PRIMARY KEY auto_increment NOT NULL,
PRODUCT_ID INT NOT NULL,
Quantity_bags int not Null,
OrderDate date not null
);

alter table orders rename column Quantity to Quantity_bags;

INSERT INTO orders(OrderID,PRODUCT_ID,Quantity,OrderDate)
values
(101,1,10,"2024-5-07"),
(205,2,24,"2024-6-08"),
(206,3,29,"2024-12-09"),
(254,4,26,"2024-1-29"),
(276,5,56,"2024-7-30"),
(277,6,78,"2025-1-25");


create index idx_product_name  on products(ProductName);
select * from products where ProductName="Sugar";

show index from products;
-- The index will be useful since it will enable me in filtering and also in easy looking up.

-- QUESTION E(b)
-- In the scenario where there is a need to frequently search for orders placed  in a specific month, I will create an index on the orderDate column

use administrator;
CREATE INDEX idx_orders_month ON Orders(OrderDate);
-- The only DrawBack which can be encountered is that Each time I will insert a new order then MySQL must update the index, making these operations slightly slower.

-- QUESTION F(a)
Create database money_transactions;
use money_transactions;
create table credit_debit(
account_id int primary key,
Account_number int not null,
Acc_Name varchar(256) not null,
Acc_balance decimal(10,2) not null

);

insert into credit_debit( account_id,Account_number,Acc_Name,Acc_balance)
 values
(1,566667,"Musembi",90009.90),
(2,666262,"James",788877.09),
(3,566578,"Guten",776660.89),
(4,566654,"Eshter",9998.67),
(5,7766673,"tera",777786.56);

use money_transactions;
Delimiter $$

create procedure Moneytransfer(
in send_id int,
in receiver_id int,
in Amount decimal(10,2)

)

begin
declare exit handler for sqlexception
	BEGIN
    ROLLBACK;
    SIGNAL SQLSTATE '59000' SET MESSAGE_TEXT="FAILLED TRANSACTION,CHANGES ROLLED BACK.";
    END;
    START TRANSACTION;
    -- tHIS IS THE CODE FOR DEBITING FROM THE ACCOUNT OF THE SENDER
    UPDATE credit_debit
    set Acc_balance= Acc_balance-Amount
    where account_id=receiver_id;
    
    commit;
    
    
    end $$
    Delimiter ;
    
    Start transaction;
    
    update credit_debit
    set Acc_balance=Acc_balance+1756000
    where account_id=3;
    SELECT 
    *
FROM
    credit_debit;
    
-- QUESTION F(b)
-- The commIT statement is used in transactions since it saves all changes which are made during the transactions permanently to the database
-- Rollback on the other hand undoes all the challenges made during transactions.
 
-- QUESTION G(a)
create database BUSINESS;
USE BUSINESS;

CREATE TABLE CUSTOMERS(
CUSTOMER_ID INT PRIMARY KEY NOT NULL,
FIRST_NAME VARCHAR(250) NOT NULL,
LAST_NAME VARCHAR(250) NOT NULL,
DATE_VISITED DATE NOT NULL

);

CREATE TABLE EMPLOYEES(
EMPLOYEE_ID INT PRIMARY KEY NOT NULL,
FIRST_NAME VARCHAR(250) NOT NULL,
SECOND_NAME VARCHAR(250) NOT NULL,
DATE_EMPLOYED DATE NOT NULL

);

select FIRST_NAME,LAST_NAME, "CUSTOMERS" AS ROLES 
FROM CUSTOMERS
UNION
SELECT FIRST_NAME,SECOND_NAME, "EMPLOYEES" AS ROLES
FROM EMPLOYEES;

-- QUESTION F(b)

-- UNION ONLY RETURNS UNIQUE ROWS WHEREAS UNION ALL returns all the rows including the duplicates
-- some of the cases which UNION can be used include, combining two company tables which include it's employees for two years.
-- One can use UNION ALL to retrieve all the data for al the transactions in a company from two tables which were recorded two months consecutively.
