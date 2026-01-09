---
layout: cheatsheet
title: MySQL/MariaDB Command Cheatsheet
description: Essential MySQL and MariaDB commands for database management
---

# MySQL/MariaDB Command Cheatsheet

A comprehensive reference for MySQL and MariaDB database commands.

## Connection

### Connect to MySQL
```bash
mysql -u username -p                    # Connect with password prompt
mysql -u username -ppassword            # Connect with password (insecure)
mysql -u username -p -h hostname        # Connect to remote host
mysql -u username -p database_name      # Connect to specific database
mysql -u root -p -P 3306                # Specify port
```

### Connection from Command Line
```bash
mysql -u root -p -e "SHOW DATABASES;"   # Execute query
mysql -u root -p < script.sql           # Execute SQL file
mysqldump -u root -p database > backup.sql  # Backup database
```

## Database Operations

### Create and Drop
```sql
CREATE DATABASE database_name;
CREATE DATABASE IF NOT EXISTS database_name;
CREATE DATABASE database_name CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP DATABASE database_name;
DROP DATABASE IF EXISTS database_name;
```

### Show and Use
```sql
SHOW DATABASES;
USE database_name;
SELECT DATABASE();                      -- Show current database
```

## Table Operations

### Create Table
```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS table_name (...);
```

### Alter Table
```sql
ALTER TABLE users ADD COLUMN age INT;
ALTER TABLE users DROP COLUMN age;
ALTER TABLE users MODIFY COLUMN username VARCHAR(100);
ALTER TABLE users CHANGE old_name new_name VARCHAR(50);
ALTER TABLE users ADD INDEX idx_username (username);
ALTER TABLE users DROP INDEX idx_username;
ALTER TABLE users RENAME TO new_users;
```

### Drop and Truncate
```sql
DROP TABLE table_name;
DROP TABLE IF EXISTS table_name;
TRUNCATE TABLE table_name;              -- Delete all rows, reset AUTO_INCREMENT
```

### Show Tables
```sql
SHOW TABLES;
SHOW TABLES LIKE 'user%';
DESCRIBE table_name;                    -- Show table structure
SHOW CREATE TABLE table_name;           -- Show CREATE statement
SHOW COLUMNS FROM table_name;
```

## CRUD Operations

### INSERT
```sql
INSERT INTO users (username, email, password) 
VALUES ('john', 'john@example.com', 'hashed_password');

INSERT INTO users (username, email, password) VALUES
    ('alice', 'alice@example.com', 'pass1'),
    ('bob', 'bob@example.com', 'pass2');

INSERT INTO users SET username='jane', email='jane@example.com';
```

### SELECT
```sql
SELECT * FROM users;
SELECT username, email FROM users;
SELECT DISTINCT username FROM users;
SELECT * FROM users WHERE id = 1;
SELECT * FROM users WHERE age > 18 AND status = 'active';
SELECT * FROM users WHERE email LIKE '%@gmail.com';
SELECT * FROM users ORDER BY created_at DESC;
SELECT * FROM users LIMIT 10;
SELECT * FROM users LIMIT 10 OFFSET 20;
SELECT COUNT(*) FROM users;
SELECT * FROM users WHERE id IN (1, 2, 3);
SELECT * FROM users WHERE age BETWEEN 18 AND 65;
```

### UPDATE
```sql
UPDATE users SET email = 'newemail@example.com' WHERE id = 1;
UPDATE users SET status = 'inactive' WHERE last_login < '2023-01-01';
UPDATE users SET login_count = login_count + 1 WHERE id = 1;
```

### DELETE
```sql
DELETE FROM users WHERE id = 1;
DELETE FROM users WHERE status = 'inactive';
DELETE FROM users;                      -- Delete all rows
```

## Joins

### INNER JOIN
```sql
SELECT users.username, orders.order_date
FROM users
INNER JOIN orders ON users.id = orders.user_id;
```

### LEFT JOIN
```sql
SELECT users.username, orders.order_date
FROM users
LEFT JOIN orders ON users.id = orders.user_id;
```

### RIGHT JOIN
```sql
SELECT users.username, orders.order_date
FROM users
RIGHT JOIN orders ON users.id = orders.user_id;
```

### Multiple Joins
```sql
SELECT u.username, o.order_date, p.product_name
FROM users u
INNER JOIN orders o ON u.id = o.user_id
INNER JOIN products p ON o.product_id = p.id;
```

## Aggregate Functions

### Common Functions
```sql
SELECT COUNT(*) FROM users;
SELECT COUNT(DISTINCT username) FROM users;
SELECT SUM(amount) FROM orders;
SELECT AVG(price) FROM products;
SELECT MIN(price), MAX(price) FROM products;
SELECT GROUP_CONCAT(username) FROM users;
```

### GROUP BY
```sql
SELECT status, COUNT(*) FROM users GROUP BY status;
SELECT user_id, SUM(amount) FROM orders GROUP BY user_id;
SELECT user_id, COUNT(*) as order_count 
FROM orders 
GROUP BY user_id 
HAVING order_count > 5;
```

## Indexes

### Create Index
```sql
CREATE INDEX idx_username ON users(username);
CREATE UNIQUE INDEX idx_email ON users(email);
CREATE INDEX idx_name ON users(first_name, last_name);
CREATE FULLTEXT INDEX idx_content ON posts(content);
```

### Drop Index
```sql
DROP INDEX idx_username ON users;
ALTER TABLE users DROP INDEX idx_username;
```

### Show Indexes
```sql
SHOW INDEX FROM users;
SHOW INDEXES FROM users;
```

## Constraints

### Primary Key
```sql
ALTER TABLE users ADD PRIMARY KEY (id);
ALTER TABLE users DROP PRIMARY KEY;
```

### Foreign Key
```sql
ALTER TABLE orders 
ADD CONSTRAINT fk_user 
FOREIGN KEY (user_id) REFERENCES users(id) 
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE orders DROP FOREIGN KEY fk_user;
```

### Unique Constraint
```sql
ALTER TABLE users ADD UNIQUE (email);
ALTER TABLE users ADD CONSTRAINT uc_email UNIQUE (email);
ALTER TABLE users DROP INDEX uc_email;
```

### Check Constraint (MySQL 8.0.16+)
```sql
ALTER TABLE users ADD CONSTRAINT chk_age CHECK (age >= 18);
ALTER TABLE users DROP CONSTRAINT chk_age;
```

## User Management

### Create User
```sql
CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'username'@'%' IDENTIFIED BY 'password';  -- Any host
```

### Grant Privileges
```sql
GRANT ALL PRIVILEGES ON database_name.* TO 'username'@'localhost';
GRANT SELECT, INSERT, UPDATE ON database_name.* TO 'username'@'localhost';
GRANT ALL PRIVILEGES ON *.* TO 'username'@'localhost';
FLUSH PRIVILEGES;
```

### Revoke Privileges
```sql
REVOKE ALL PRIVILEGES ON database_name.* FROM 'username'@'localhost';
FLUSH PRIVILEGES;
```

### Show and Drop User
```sql
SELECT User, Host FROM mysql.user;
SHOW GRANTS FOR 'username'@'localhost';
DROP USER 'username'@'localhost';
```

### Change Password
```sql
ALTER USER 'username'@'localhost' IDENTIFIED BY 'new_password';
SET PASSWORD FOR 'username'@'localhost' = PASSWORD('new_password');
```

## Backup and Restore

### Backup
```bash
# Backup single database
mysqldump -u root -p database_name > backup.sql

# Backup all databases
mysqldump -u root -p --all-databases > all_databases.sql

# Backup specific tables
mysqldump -u root -p database_name table1 table2 > tables.sql

# Backup with compression
mysqldump -u root -p database_name | gzip > backup.sql.gz

# Backup structure only
mysqldump -u root -p --no-data database_name > structure.sql
```

### Restore
```bash
# Restore database
mysql -u root -p database_name < backup.sql

# Restore compressed backup
gunzip < backup.sql.gz | mysql -u root -p database_name

# Restore all databases
mysql -u root -p < all_databases.sql
```

## Transactions

### Basic Transaction
```sql
START TRANSACTION;
-- or BEGIN;

UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;

COMMIT;
-- or ROLLBACK;
```

### Savepoints
```sql
START TRANSACTION;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
SAVEPOINT sp1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
ROLLBACK TO sp1;
COMMIT;
```

## String Functions

```sql
SELECT CONCAT('Hello', ' ', 'World');
SELECT CONCAT_WS('-', 'A', 'B', 'C');       -- 'A-B-C'
SELECT UPPER('hello');                       -- 'HELLO'
SELECT LOWER('HELLO');                       -- 'hello'
SELECT LENGTH('hello');                      -- 5
SELECT SUBSTRING('hello', 1, 3);            -- 'hel'
SELECT REPLACE('hello world', 'world', 'MySQL');
SELECT TRIM('  hello  ');
SELECT LTRIM('  hello');
SELECT RTRIM('hello  ');
```

## Date Functions

```sql
SELECT NOW();                               -- Current datetime
SELECT CURDATE();                           -- Current date
SELECT CURTIME();                           -- Current time
SELECT DATE('2024-01-15 10:30:00');        -- '2024-01-15'
SELECT TIME('2024-01-15 10:30:00');        -- '10:30:00'
SELECT YEAR(NOW());
SELECT MONTH(NOW());
SELECT DAY(NOW());
SELECT DATE_ADD(NOW(), INTERVAL 7 DAY);
SELECT DATE_SUB(NOW(), INTERVAL 1 MONTH);
SELECT DATEDIFF('2024-12-31', '2024-01-01');
SELECT DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s');
```

## Useful Queries

### Find Duplicate Records
```sql
SELECT email, COUNT(*) as count
FROM users
GROUP BY email
HAVING count > 1;
```

### Delete Duplicates (Keep First)
```sql
DELETE t1 FROM users t1
INNER JOIN users t2
WHERE t1.id > t2.id AND t1.email = t2.email;
```

### Random Rows
```sql
SELECT * FROM users ORDER BY RAND() LIMIT 10;
```

### Copy Table
```sql
CREATE TABLE users_backup AS SELECT * FROM users;
CREATE TABLE users_copy LIKE users;        -- Structure only
```

## Performance

### Explain Query
```sql
EXPLAIN SELECT * FROM users WHERE username = 'john';
EXPLAIN ANALYZE SELECT * FROM users WHERE username = 'john';
```

### Show Process List
```sql
SHOW PROCESSLIST;
SHOW FULL PROCESSLIST;
KILL process_id;
```

### Optimize Table
```sql
OPTIMIZE TABLE users;
ANALYZE TABLE users;
CHECK TABLE users;
REPAIR TABLE users;
```

## Configuration

### Show Variables
```sql
SHOW VARIABLES;
SHOW VARIABLES LIKE 'max_connections';
SET GLOBAL max_connections = 200;
```

### Show Status
```sql
SHOW STATUS;
SHOW STATUS LIKE 'Threads_connected';
SHOW TABLE STATUS;
```

## Tips

1. **Use indexes** wisely for better performance
2. **Always backup** before major changes
3. **Use transactions** for data integrity
4. **Optimize queries** with EXPLAIN
5. **Use prepared statements** to prevent SQL injection
6. **Regular maintenance** with OPTIMIZE TABLE
7. **Monitor slow queries** with slow query log
8. **Use appropriate data types** to save space
9. **Normalize database** design when appropriate
10. **Keep MySQL updated** for security and features

## Resources

- Official Documentation: https://dev.mysql.com/doc/
- MariaDB Documentation: https://mariadb.com/kb/en/
- MySQL Tutorial: https://www.mysqltutorial.org/
