![34-mariadb](../../.gitbook/assets/34-mariadb.png)

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

## login to your database

```
mysql -u root -p
```


## create database

```sql
create database `school`;
```

## create table

```sql
create table students(id int, name varchar(255));
```

## insert data

```sql
insert into students(id, name) values(1, 'John'), (2, 'Jane');
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

## Mariadb master slave

![mariadb-master-slave](../../.gitbook/assets/65-mariadb-master-slave.jpg)

Copying data from multiple databases is known as replication. The databases that are to be copied are known as master databases or servers. The replicated data might include multiple or single databases or data tables used from the desired database.

The primary features of MariaDB Replication are:


**Scalability** – When you have one or more slave servers, you can read data on them. It, thereby, reduces the load on the master server in which only accurate operations can be performed.
**Data Analysis** – You can effortlessly analyze data on the slave server, thereby reducing the burden on the master server when MariaDB replication is updated in place.
**Backup Assistant** – Backup Assistance allows you to replicate data, which can be used as backup data. This backup data further acts as stand-alone data in a stable state.
**Distribution Of Data** – When you have MariaDB replication in place, you tend to work locally on this data without even connecting to the master server. By connecting subsequently, you can merge the updated data with the master data.

#### Step 1 - Install MariaDB on All Nodes

First, you will need to install the MariaDB server package on both Master and Slave nodes. You can install it by running the following command:

```bash
sudo apt-get update
apt-get install mariadb-server -y
```

After installing the MariaDB server, start the MariaDB server service and enable it to start after system reboot:

```bash
systemctl start mariadb
systemctl enable mariadb
```
Next, you will need to secure the MariaDB installation and set a MariaDB root password. You can do it by running the mysql_secure_installation script:

```bash
mysql_secure_installation
```

Answer all the questions as shown below:

```bash
Enter current password for root (enter for none): Enter
Set root password? [Y/n] Y
Remove anonymous users? [Y/n] Y
Disallow root login remotely? [Y/n] Y
Remove test database and access to it? [Y/n] Y
Reload privilege tables now? [Y/n] Y
```

### MariaDB Master-Slave replication Step by Step
Data from a Master server is replicated across several MariaDB servers using Master-Slave replication. This ensures data redundancy and prevents data loss if the Master node goes down.

The replication setup is as follows:

Master node: IP 172.16.0.10
Slave node: IP 172.16.0.11

Add the IP addresses of the master and slave nodes to the /etc/hosts file.

```bash
172.16.0.10 db1
172.16.0.11 db2
```

#### Step 2 - Prepare the Master Node

MariaDB server uses a binary log file to perform the replication. By default, the binary log is disabled in the MariaDB default configuration. So you will need to edit the MariaDB configuration file and enable the binary log.

```bash
vim /etc/mysql/mariadb.conf.d/50-server.cnf
```
First, change the bind-address from localhost to your  priveate IP:

```bash
bind-address = 172.16.0.10
```
Next, add the following lines at the end of the file to enable the binary log:

```bash
server-id              = 1
log_bin                = /var/log/mysql/mysql-bin.log
max_binlog_size        = 100M
relay_log = /var/log/mysql/mysql-relay-bin
relay_log_index = /var/log/mysql/mysql-relay-bin.index
```

Save and close the file when you are finished then restart the MariaDB service to apply the changes:

```bash
systemctl restart mariadb
```

At this point, MariaDB is configured and listens on port 3306. You can check it with the following command:

```bash
ss -ntlp | grep 3306
```

You should get the following output:

```bash
LISTEN 0      80       172.16.0.10:3306      0.0.0.0:*    users:(("mariadbd",pid=3499,fd=22))
```

### Step 3 - Create a Replication User on Master Node

Next, you will need to create a replication user on the Master node. The Slave node will use this user to connect to the Master server and request binary logs.

To create a replication user, connect to the MariaDB with the following command:

```bash
mysql -u root -p
```

Provide your MariaDB root password and hit Enter. Once you are connected, you should get the following shell:

```bash
MariaDB [(none)]>
```

Next, create a replication user and set a password:

```bash
MariaDB [(none)]> CREATE USER 'replication'@'%' identified by 'securepassword';
```

Next, grant replication slave privilege to the user with the following command:

```bash
MariaDB [(none)]> GRANT REPLICATION SLAVE ON *.* TO 'replication'@'%';
```

Next, flush the privileges to apply the changes:

```bash
MariaDB [(none)]> FLUSH PRIVILEGES;
```

Next, verify the Master status using the following command:

```bash
MariaDB [(none)]> SHOW MASTER STATUS;
```

You should get the binary log file name and position in the following output:

```bash
+------------------+----------+--------------+------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB |
+------------------+----------+--------------+------------------+
| mysql-bin.000001 |      786 |              |                  |
+------------------+----------+--------------+------------------+
```

Finally, exit from the MariaDB console using the following command:

```bash
MariaDB [(none)]> EXIT;
```
`Note: Please remember File and Position value from the above output. You will need this value on the Slave server.`

### Step 4 - Prepare the Slave Node for Replication

Next, you will need to enable the relay log and replication on the Slave node. You can do it by editing the MariaDB main configuration file:

```bash
vim /etc/mysql/mariadb.conf.d/50-server.cnf
```
First, change the bind-address from localhost to your  priveate IP:

```bash
bind-address = 172.16.0.11
```

Next, add the following lines at the end of the file to enable relay log and replication:

```bash
server-id              = 2
log_bin                = /var/log/mysql/mysql-bin.log
max_binlog_size        = 100M
relay_log = /var/log/mysql/mysql-relay-bin
relay_log_index = /var/log/mysql/mysql-relay-bin.index
```

Save and close the file then restart the MariaDB service to apply the changes:

```bash
systemctl restart mariadb
```

Next, you will need to set up the Slave node to replicate the Master node.

First, connect to the MariaDB with the following command:

```bash
mysql -u root -p
```

Once you are connected, stop the Slave with the following command:

```bash
MariaDB [(none)]> STOP SLAVE;
```

Next, set up the slave to replicate the master with the following command:

```bash
MariaDB [(none)]> CHANGE MASTER TO MASTER_HOST = 'MASTER_IP OR NAME', MASTER_USER = 'replication', MASTER_PASSWORD = 'securepassword', MASTER_LOG_FILE = 'mysql-bin.000001', MASTER_LOG_POS = 786;
```

`MASTER_IP` is the IP address of the Master node.
`replication` is the replication user.
`securepassword` is the replication user password.
`mysql-bin.000001` is the binary log file name.
`786` is the binary log file position.

Next, start the Slave with the following command:

```bash
MariaDB [(none)]> START SLAVE;
```

### Step 5 - Verify MariaDB Replication

At this point, MariaDB Master and Slave node is configured. Now, you will need to test whether the replication is working or not.

First, go to the Master node and connect to the MariaDB console:

```bash
mysql -u root -p
```

Once you are connected, create a database named testdb:

```bash
MariaDB [(none)]> CREATE DATABASE schooldb;
```

Next, switch the database to schooldb and create a table named students:

```bash
MariaDB [(none)]> USE schooldb;
MariaDB [(schooldb)]> CREATE TABLE students (id INT, name VARCHAR(255));
MariaDB [(schooldb)]> INSERT INTO students (id, name) VALUES (1, 'John'), (2, 'Jane');
MariaDB [(schooldb)]> SELECT * FROM students;
+------+------+
| id   | name |
+------+------+
|    1 | John |
|    2 | Jane |
+------+------+

MariaDB [(schooldb)]>
```

`Now, go to the Slave node and connect to the MariaDB with the following command:`

```bash
mysql -u root -p
```

Once you are connected, check the Slave status with the following command:

```bash
MariaDB [(none)]> SHOW SLAVE STATUS;
```

If everything is fine, you should get the following output:

```bash
                Slave_IO_State: Waiting for master to send event

```

Now, list all databases using the following command:

```bash
MariaDB [(none)]> SHOW DATABASES;
```

You can see that the schooldb database is replicated from the Master node:

```bash
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| schooldb           |
+--------------------+
```
Now, switch the database to schooldb and list all tables using the following command:

```bash
MariaDB [(none)]> USE schooldb;
MariaDB [(schooldb)]> SHOW TABLES;
+--------------------+
| Tables_in_schooldb |
+--------------------+
| students           |
+--------------------+
```
You can also verify the tables data using the following command:

```bash
MariaDB [(schooldb)]> SELECT * FROM students;
+------+------+
| id   | name |
+------+------+
|    1 | John |
|    2 | Jane |
+------+------+
```

keep learning

https://mariadb.com/kb/en/setting-up-replication/