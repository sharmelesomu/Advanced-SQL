-- SQL JOINS
-- joins are used combines rows of two tables
drop table Supplier;
drop table Products;
-- INNER JOIN

CREATE TABLE Supplier(
Supplier_ID int,
Supplier_name varchar(20),
primary key (Supplier_ID)
);

CREATE TABLE Product(
Product_ID int,
Product_name varchar(20),
Supplier_ID int,
primary key (Product_ID),
foreign key (Supplier_ID) references Supplier(Supplier_ID)
);

insert into Supplier values (101,'Ganesh'), (102,'Anil'), (103,'Kumar');
insert into Supplier values (104,'Gayathri'), (105,'Arjun'), (106,'Angela');
select * from Supplier;

insert into Product values (1001,'Apple',102), (1002,'Orange',102), (1003,'Pear',103),(1004,'Litchi',101), (1005,'Lemon',102), (1006,'Kiwi',103);
insert into Product values (1007,'Apple',104), (1008,'Orange',104), (1009,'Pear',106),(1010,'Litchi',106), (1011,'Lemon',106), (1012,'Kiwi',104);
select * from Product;

select Supplier_name,Product_name from Supplier S inner join Product P where S.Supplier_ID=P.Supplier_ID; -- it tries to fetch the common elements bettween the two table

CREATE TABLE Supplier1(
Supplier_ID int,
Supplier_name varchar(20),
primary key (Supplier_ID)
);

CREATE TABLE Product1(
Product_ID int,
Product_name varchar(20),
Supplier_ID int,
primary key (Product_ID)
-- foreign key (Supplier_ID) references Supplier(Supplier_ID)
);

insert into Supplier1 values (101,'Ganesh'), (102,'Anil'), (103,'Kumar');
insert into Supplier1 values (104,'Gayathri'), (105,'Arjun'), (106,'Angela');
select * from Supplier1;

insert into Product1 values (1001,'Apple',102), (1002,'Orange',102), (1003,'Pear',103),(1004,'Litchi',101), (1005,'Lemon',102), (1006,'Kiwi',103);
insert into Product1 values (1007,'Apple',104), (1008,'Orange',104), (1009,'Pear',106),(1010,'Litchi',106), (1011,'Lemon',106), (1012,'Kiwi',104);
insert into Product1 values (1013,'Apple',107), (1014,'Orange',108), (1015,'Pear',109),(1016,'Litchi',110), (1017,'Lemon',111), (1018,'Kiwi',112);
select * from Product1;

-- INNER JOIN
select P.Supplier_ID,Supplier_name,Product_name from Supplier1 S inner join Product1 P where S.Supplier_ID=P.Supplier_ID; -- it tries to fetch the common elements bettween the two table

-- LEFT JOIN
select S.Supplier_ID,Supplier_name,Product_name from Supplier1 S left join Product1 P ON S.Supplier_ID = P.Supplier_ID; -- All the elements from the left table and common element from the right table

-- RIGHT JOIN
select P.Supplier_ID,Supplier_name,Product_name from Supplier1 S right join Product1 P ON S.Supplier_ID = P.Supplier_ID; -- All the elements from the right table and common element from the left table

-- CROSS JOIN / CARTESIAN JOIN
select * from Supplier1 S cross join Product1 P; -- cross join/ cartesian product - every row from the first table is combined with every row from the second table.

-- UNION / FULL OUTER JOIN
-- does not work select * from Supplier1 S union Product1 P where S.Supplier_ID=P.Supplier_ID; 
-- mysql doesnot support full outer join we can use union instead
-- UNION requires both tables to have the same number of columns and matching data types in corresponding positions.
-- union on left and right join will give full outer join
select * from Supplier1 S left join Product1 P ON S.Supplier_ID = P.Supplier_ID;
select * from Supplier1 S right join Product1 P ON S.Supplier_ID = P.Supplier_ID;
select * from Supplier1 S left join Product1 P ON S.Supplier_ID = P.Supplier_ID
union
select * from Supplier1 S right join Product1 P ON S.Supplier_ID = P.Supplier_ID;

-- LEFT EXCLUSIVE JOIN
-- find the suppliers only available in supplier table and not in products table

select * from Supplier1 S left join Product1 P on S.Supplier_ID = P.Supplier_ID; -- left join
select * from Supplier1 S left join Product1 P on S.Supplier_ID = P.Supplier_ID where P.Supplier_ID is null; -- (voila) to select supplier id only in supplier table we mention product table supplier id as null
select S.Supplier_ID from Supplier1 S left join Product1 P on S.Supplier_ID = P.Supplier_ID where P.Supplier_ID is null;

select * from Supplier1 S right join Product1 P on S.Supplier_ID = P.Supplier_ID where S.Supplier_ID is null; -- practice
-- RIGHT EXCLUSIVE JOIN
-- find the suppliers only available in product table and not in supplier table

select * from Supplier1 S right join Product1 P on S.Supplier_ID = P.Supplier_ID; -- right join
select * from Supplier1 S right join Product1 P on S.Supplier_ID = P.Supplier_ID where S.Supplier_ID is null; -- to select supplier id only in product table we mention supplier table supplier id as null
select P.Supplier_ID from Supplier1 S right join Product1 P on S.Supplier_ID = P.Supplier_ID where S.Supplier_ID is null;


-- FULL OUTER JOIN WITH EXCLUSION
-- to list suppliers in seperate tables (non common supplierid - anti inner join)
-- suppliers that are present only in table A or table B, they are not in both table/ not common eg(105 - table A, 107... -table B)

select S.Supplier_ID from Supplier1 S left join Product1 P on S.Supplier_ID = P.Supplier_ID where P.Supplier_ID is null
union
select P.Supplier_ID from Supplier1 S right join Product1 P on S.Supplier_ID = P.Supplier_ID where S.Supplier_ID is null;

select * from Supplier1 S left join Product1 P on S.Supplier_ID = P.Supplier_ID where P.Supplier_ID is null
union
select * from Supplier1 S right join Product1 P on S.Supplier_ID = P.Supplier_ID where S.Supplier_ID is null;

-- DATA / TIME FUNCTIONS

-- Mysql provides several data and time functions. they are helpful in storing, retriving and manipulating time and date data.
-- Date and Time formats in my sql
-- Mysql stores date in the format YYYY-MM-DD. eg, 2025-04-01
-- Mysql stores date and time in the format YYYY-MM-DD HH:MM:SS. eg, 2025-04-01 11:43:23
-- Mysql stores year in YY or YYYY format. eg, 25 or 2025

-- Key date and time functions
select current_date(); -- get the current date in YYYY-MM-DD Format
select curdate(); -- get the current date in YYYY-MM-DD Format
select curtime(); -- gets the current time in HH:MM:SS
select current_time(); -- gets the current time in HH:MM:SS
select now(); -- gets the current date and time in YYYY-MM-DD HH:MM:SS.
select date('2025-04-01 11:48:11'); -- date part from date time value
select date(now());

-- DATE_ADD() - adds a specific date interval to date
-- DATE_SUB() - subtracts a specific date interval from date
SELECT DATE_ADD(DATE(NOW()), INTERVAL 2 DAY);
SELECT DATE_SUB(DATE(NOW()), INTERVAL 2 DAY);

SELECT DATEDIFF('2025-04-01','2025-03-01'); -- extracts the number of days between two dates
-- DATE FORMAT - format the date as per our requirement %Y - 2025, %y - 25, %m - 03, %d- 13, %W - day name, %a - abbreviated day name, %b- abbreviated month name
-- %p - am or pm, %H:%i:%s - HH:MM:SS
SELECT DATE_FORMAT(NOW(),'%Y,%b,%W,%a,%m,%d,%p,%H:%i:%s');
SELECT DATE_FORMAT(NOW(),'%b,%M,%m'); -- abbreviation, Month name, Month number
SELECT DATE_FORMAT(NOW(),'%a,%W,%w'); -- abbreviation, Weekday name, Week number
SELECT DATE_FORMAT(NOW(),'%h:%i:%s'); -- HH:MM:SS

SELECT YEAR(NOW()); -- 01/04/2025 2025
SELECT DAY(NOW()); -- 01
SELECT MONTH(NOW()); -- 04

-- STRING FUNCTION
SELECT CONCAT('Sharmele',' ','Somu',' ','Selvendran'); -- accepts any number of arguments
SELECT LENGTH('Sharmele Somu');
SELECT CHAR_LENGTH('Sharmele Somu');
SELECT LEFT('Sharmele',2); -- extract the number of charaters from the left
SELECT RIGHT('SHARMELE',2); -- extract the number of charaters from the right
SELECT SUBSTRING('SHARMELE',1,3); -- string, starting position, no of chars
SELECT SUBSTR('SHARMELE',1,3);
SELECT REPLACE('SHARMELE SOMU SELVENDRAN','SHARMELE','SHARME'); -- string, old string, new string
SELECT TRIM(' Hello World   '); -- removes leading and trailing spaces
SELECT CONCAT_WS('*','str1','str2','str3'); -- char followed by strings
SELECT INSTR('str1*str2*str3*str3','str3'); -- finds the position of 1st occurence of sub string
select CHARINDEX('t','fruit'); -- SQL SERVER FN - first occurence of character in string
SELECT ASCII('Sharmele'); -- 83 ASCII Value of 1st character
SELECT ASCII('S'); -- 83
SELECT CHAR(65); -- returns the character for the corresponding ASCII value
SELECT DATALENGTH('Sharmele Somu'); -- returns length of an expression in bytes - function does not exist in mysql
SELECT DIFFERENCE('Sharmele','Sharme'); -- returns difference as an integer - function does not exist in mysql
SELECT LEN('Sharmele'); -- returns length of string excluding trailing zeros

-- ARITHMETIC FUNCTIONS
-- Below are some of the arithmetic functions performed on numeric data.

SELECT ABS(-123.5); -- returns the absolute value of any number. removes negative sign
SELECT ROUND(23.44); -- 23
SELECT ROUND(23.54); -- 24
SELECT ROUND(23.446,2); -- 23.45 rounds to 2 decimal points
SELECT CEIL(4.3); -- 5 - rounds to greater nearest whole number
SELECT FLOOR(4.7); -- 4 - rounds to the same or smallest nearest whole number
SELECT MOD(3,2); -- returns the remainder
SELECT POW(2,3); -- returns result of a number raised to the power
SELECT POWER(2,3);
SELECT SQRT(25);
-- COUNT counts the number of entries in the column
-- AVG finds the average of all the entries in a column
SELECT ACOS(-0.25); -- returns cosine of a number. it should be between -1 to 1 else null is returned

-- WINDOW FUNCTIONS
-- GROUP BY and Window Functions serve different purposes and generally cannot be used together inside a window function.
-- A window function operates over a subset ("window") of rows, which is defined using the OVER() clause.

select * from globalorders;
-- ROW_NUMBER() - assigns a unique integer to each row starting at 1
select order_ID, Country, Sales, Quantity, Profit, ROW_NUMBER() OVER(ORDER BY PROFIT DESC) AS POPULARITY from globalorders;
-- RANK() - Assigns a rank to each row, tied rows share the same rank and the next rank is skipped eg. 5,5,7
-- DENSE RANK() - ranks are shared but not skipped eg. 5,5,6
-- PERCENT_RANK() - calculates the relative standing of a row within a group. (rank of current row-1/total rows in partition-1)
select order_ID, Country, Sales, Quantity, Profit, ROW_NUMBER() OVER(ORDER BY PROFIT DESC) AS POPULARITY, RANK() OVER(ORDER BY Sales DESC) AS SALES_RANK from globalorders; 
select order_ID, Country, Sales, Quantity, Profit, PERCENT_RANK() OVER(partition by Country ORDER BY PROFIT DESC) AS PERCENTAGE_RANK from globalorders;
-- NTILE - divides the result into specified number of buckets and assigns a number to it
select order_ID, Country, Sales, Quantity, Profit, NTILE(4) OVER(partition by Country ORDER BY PROFIT DESC) AS NTILE_NO from globalorders;
-- LEAD - returns the result from the following rows depending on the offset
select order_ID, Country, Sales, Quantity, Profit, LEAD(Profit,2) OVER(partition by Country ORDER BY PROFIT DESC) AS NEXT_NEXT_PROFIT from globalorders;
-- LAG - returns the result from the previous rows depending on the offset
select order_ID, Country, Sales, Quantity, Profit, LAG(Profit,1) OVER(partition by Country ORDER BY PROFIT DESC) AS PREVIOUS_PROFIT from globalorders;
-- SUM, AVG - finds sum and avg over a window
select Country, profit, SUM(Profit) OVER(partition by Country ORDER BY PROFIT DESC) AS RUNNING_TOTAL_PROFIT_PER_COUNTRY from globalorders;
-- The average is recalculated each time a new row is included in the running total. Each country is treated separately because of PARTITION BY Country.
-- 1000+800+500/3 will be computed for the top 3 rows
select Country, profit, AVG(Profit) OVER(partition by Country ORDER BY PROFIT DESC) AS RUNNING_AVERAGE_PROFIT_PER_COUNTRY from globalorders;
-- for calculating average at any row, it only considers 2 preceding row
select Country, profit, AVG(Profit) OVER(partition by Country ORDER BY PROFIT DESC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS RUNNING_AVERAGE_PROFIT_PER_COUNTRY from globalorders;
select Country, profit, AVG(Profit) OVER(partition by Country ORDER BY PROFIT DESC ROWS RANGE BETWEEN INTERVAL 7 PRECEDING AND CURRENT ROW) AS RUNNING_AVERAGE_PROFIT_PER_COUNTRY from globalorders;

SELECT Country, Profit, FIRST_VALUE(Profit) OVER (PARTITION BY Country ORDER BY Profit DESC) AS Highest_Profit FROM globalorders;
SELECT Country, Profit, NTH_VALUE(Profit,2) OVER (PARTITION BY Country ORDER BY Profit DESC) AS Second_Highest_Profit FROM globalorders;
-- The CUME_DIST() (Cumulative Distribution) function calculates the cumulative probability of a value within a partition. 
-- It tells you the proportion of values less than or equal to the current row's value.
SELECT Country, Profit, CUME_DIST() OVER (PARTITION BY Country ORDER BY Profit ASC) AS Cumulative_Dist FROM globalorders;
-- PERCENTILE_CONT, PERCENTILE_DISC

-- AGGREGATE FUNCTIONS
SELECT COUNT(*) FROM globalorders where Country='United States';
SELECT
(SELECT SUM(Profit) from globalorders) AS TOTALPROFIT,
(SELECT SUM(Profit) FROM globalorders where Country = 'United States') AS COUNTRYPROFIT;

SELECT (SELECT AVG(Profit) from globalorders) AS AVG_PROFIT;
SELECT MAX(PROFIT) from globalorders;
SELECT MIN(PROFIT) from globalorders;
SELECT * FROM globalorders;
SELECT GROUP_CONCAT(" ",Customer_Name) from globalorders where State='New York';
-- varaince is the dispersion ov values from the mean
SELECT VARIANCE(Profit) from globalorders;
SELECT STDDEV(Profit) from globalorders; -- SQRT Variance
SELECT SQRT('1121637.282205263');
-- Variance= ∑(x−xˉ)^2/n, STDDEV = SQRT Variance, high varaiance - data is spread out, low variance - data is close to average

-- CASCADE can be used for tables having hierarchial relationships (Parent-Child)
-- Star Schema has fact and dimension tables. Fact table contains the measures and dimension table contains the descriptive content like product name, category eg, laptop belongs to electronics

CREATE TABLE PARENT(
ID INT Primary key
);

CREATE TABLE CHILD(
ChildID INT Primary Key,
ParentID INT,
foreign key(ParentID) references PARENT(ID) on delete cascade);

INSERT INTO PARENT VALUES(1);
INSERT INTO PARENT VALUES(2);
INSERT INTO PARENT VALUES(3);

INSERT INTO CHILD VALUES(101,1);

select * from parent;
select * from child;

DELETE FROM PARENT where ID=1;

-- update cascade can be used when any change in the parent table should change the child table as well.
-- coalesce function returns the first not null value in an expression
SELECT COALESCE(NULL,"Hello","World");

-- coalesce function check for null values in multiple columns. if bonus is null, it checks in commissions, if commissions is also null then it returns 0.
-- coalesce(bonus,commission,0)
-- coalesce(SUM(sales),0) - returns 0 if the sales is NULL. can be used in aggregation, joins and conditional expressions.​
 
