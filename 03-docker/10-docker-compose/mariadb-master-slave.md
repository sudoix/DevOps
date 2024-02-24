
# MariaDB Master-Slave on docker with docker compose

Create docker compose file for MariaDB Master-Slave

```yaml

version: "3.5"
services:
  database_master:
    image: mariadb:11.3
    container_name: "database_master"
    restart: unless-stopped
    ports:
      - 3306:3306
    volumes:
      - mysqldata_master:/var/lib/mysql
      - ./master.cnf:/etc/my.cnf
    environment:
      - MYSQL_ROOT_PASSWORD=S3cret
      - MYSQL_USER=my_db_user
      - MYSQL_DATABASE=my_db
      - MYSQL_PASSWORD=S3cret
    networks:
      - mynetwork
  database_slave:
    image: mariadb:11.3
    container_name: "database_slave"
    restart: unless-stopped
    depends_on:
      - database_master
    ports:
      - 3307:3306
    volumes:
      - mysqldata_slave:/var/lib/mysql
      - ./slave.cnf:/etc/my.cnf
    environment:
      - MYSQL_ROOT_PASSWORD=S3cret
      - MYSQL_USER=my_db_user
      - MYSQL_DATABASE=my_db
      - MYSQL_PASSWORD=S3cret
    networks:
      - mynetwork
networks:
  mynetwork:
volumes:
  mysqldata_master:
  mysqldata_slave:

```

#### Create master and slave configuration file

vim master.cnf

```bash
[mysqld]
default_authentication_plugin=mysql_native_password
skip-host-cache
skip-name-resolve
datadir=/var/lib/mysql
socket=/var/run/mysqld/mysqld.sock
user=mysql
server-id=1
log_bin= 1
binlog_format=ROW
binlog_do_db=my_db
pid-file=/var/run/mysqld/mysqld.pid
[client]
socket=/var/run/mysqld/mysqld.sock
!includedir /etc/mysql/conf.d/
```

and slave file

vim slave.cnf

```bash
[mysqld]
default_authentication_plugin=mysql_native_password
skip-host-cache
skip-name-resolve
datadir=/var/lib/mysql
socket=/var/run/mysqld/mysqld.sock
user=mysql
server-id=2
log_bin = 1
binlog_do_db=my_db
pid-file=/var/run/mysqld/mysqld.pid
[client]
socket=/var/run/mysqld/mysqld.sock
!includedir /etc/mysql/conf.d/
```

### Run your docker compose file

Run it on your linux server with `docker-compose -f docker-compose_master-slave.yml up -d`

### on master node

Login with root user and password `S3cret` on master container


```bash

docker exec -it database_master bash

mariadb -u root -pS3cret

CREATE USER "mydb_slave_user"@"%" IDENTIFIED BY "mydb_slave_pwd";
GRANT REPLICATION SLAVE ON *.* TO "mydb_slave_user"@"%";
FLUSH PRIVILEGES;

SHOW MASTER STATUS;
+----------+----------+--------------+------------------+
| File     | Position | Binlog_Do_DB | Binlog_Ignore_DB |
+----------+----------+--------------+------------------+
| 1.000003 |     1402 | my_db        |                  |
+----------+----------+--------------+------------------+
1 row in set (0.00 sec)

```

### on slave node

Login with root user and password `S3cret` on slave container

```bash
docker exec -it database_slave bash

mariadb -u root -pS3cret

CHANGE MASTER TO MASTER_HOST='database_master';
CHANGE MASTER TO MASTER_HOST='database_master',MASTER_USER='mydb_slave_user',MASTER_PASSWORD='mydb_slave_pwd',MASTER_LOG_FILE='1.000003',MASTER_LOG_POS=1402; #change it on the master status table
START SLAVE;
```

### on master node

Login with root user and password `S3cret` on master container and create table

```bash
mariadb -u root -pS3cret

use my_db;

CREATE TABLE Person_Master (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);
```

Go to the slave node and check the database `my_db` tables

```bash
docker exec -it database_slave bash

mariadb -u root -pS3cret

use my_db;

show tables;

```

reference:
https://pierreabreu.medium.com/how-to-create-master-slave-mysql-8-with-docker-compose-yml-c137f45e28c7