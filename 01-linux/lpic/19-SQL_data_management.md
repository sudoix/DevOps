![34-mariadb](../../assets/34-mariadb.png)

# SQL data management

To install MariaDB on Ubuntu 20.04, you can follow these steps:

1. Install the `mariadb-server` package:

```
sudo apt update
sudo apt install mariadb-server
```

2. Start the MariaDB server:

```
sudo systemctl start mariadb
```

3. Check the status of the MariaDB server:

```
sudo systemctl status mariadb
sudo systemctl enable mariadb
```

4. To secure your MariaDB installation, run the following command:

```
sudo mysql_secure_installation
```

## restore database

login to your database and run the following command:

```
mysql -u root -p
```

```
source /PATH/TO/YOUR/DATABASE/DUMP.sql
```

The USE command in MariaDB is used to switch to a specific database. Once you switch to a database using the USE command, all the subsequent queries will be executed within that database.

Here's the syntax of the USE command:

```
USE DATABASE_NAME;
```

### SHOW

The SHOW command is used to retrieve information about databases, tables, columns, indexes, and other database objects. It provides useful insights into the structure and configuration of your database. Here are a few examples of how the SHOW command can be used:

```sql
SHOW DATABASES;
SHOW TABLES;
SHOW COLUMNS FROM TABLE_NAME;
SHOW INDEXES FROM TABLE_NAME;
```

### SELECT
The select statement is used to query the database and retrieve selected data. We can select everything in the table using * , or we can select from particular columns:

```sql
SELECT * FROM table_name;
SELECT * FROM city;
SELECT column1, column2 FROM table_name;
select name, info from city;
```

### WHERE
We can choose which data to display by using the WHERE :

```sql
SELECT * FROM table_name WHERE condition;
select * from city where CountryCode='IRN';
select * from city where CountryCode='IRN' and District='Teheran';
select * from city where CountryCode='IRN' or CountryCode='AFG';
select * from city where CountryCode='IRN' and District='Teheran' or CountryCode='AFG';
```

### ORDER BY
ORDERBY is used if we want to sort the data based on one field:

```sql
SELECT * FROM table_name ORDER BY column_name;
SELECT * FROM table_name ORDER BY column_name ASC;
SELECT * FROM table_name ORDER BY column_name DESC;

select * from city order by CountryCode;
select * from city order by CountryCode ASC;
```

### GROUP BY
GROUPBY is used if we want to group the data based on one field:

```sql
SELECT column_name FROM table_name GROUP BY column_name;
select CountryCode from city group by CountryCode;

```

## Creating, changing, and deleting data and tables

### INSERT
INSERT command add one or more rows of data to a table.

```sql
INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...);

INSERT INTO city (Name, CountryCode, District, Info) VALUES ('Malayer', 'IRN', 'Manizan', '{"Population": 100000}');
```

### UPDATE
UPDATE command to fix this mistake . It update row but which row? we should specified that with WHERE command.

```sql
UPDATE table_name SET column1 = value1, column2 = value2, ...
WHERE condition;
UPDATE city SET CountryCode = 'USA' WHERE Name = 'Malayer';
```

### DELETE
DELETE command to delete one or more rows of data from a table.

```sql
DELETE FROM table_name WHERE condition;
DELETE FROM city WHERE Name = 'Malayer';
```

### JOIN
In MariaDB, the JOIN command is used to combine rows from two or more tables based on a related column between them. It allows you to retrieve data from multiple tables in a single query by specifying how the tables are related.

```sql
SELECT * FROM table1
SELECT * FROM table2

SELECT * FROM city;
SELECT * FROM country;

SELECT columns FROM table1 JOIN table2 ON join_condition;
select * from city JOIN country on city.CountryCode=country.Code
select * from city JOIN country on city.CountryCode=country.Code limit 1;
```

### DROP
DROP command to delete a table from a database.

```sql
DROP TABLE table_name;
DROP TABLE city;
```

### TRUNCATE
TRUNCATE command to delete all the data from a table, but keep the table structure. 

```sql
TRUNCATE TABLE table_name;
TRUNCATE TABLE city;
```

