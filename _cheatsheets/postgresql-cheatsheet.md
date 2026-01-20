---
layout: cheatsheet
title: PostgreSQL Command Cheatsheet
description: PostgreSQL is a powerful, open source object-relational database system.
---


PostgreSQL is a powerful, open source object-relational database system.


## Connection

### Connect to PostgreSQL
```bash
psql -U username                        # Connect as user
psql -U username -d database            # Connect to specific database
psql -U username -h hostname -p 5432    # Connect to remote host
psql -U postgres                        # Connect as postgres user
psql postgres://user:pass@host:5432/db  # Connection string
```

### Connection from Command Line
```bash
psql -U postgres -c "SELECT version();" # Execute query
psql -U postgres -f script.sql          # Execute SQL file
psql -U postgres -d mydb < backup.sql   # Restore from file
```

### Meta Commands (in psql)
```sql
\?                      # Help
\q                      # Quit
\l                      # List databases
\c database_name        # Connect to database
\dt                     # List tables
\d table_name           # Describe table
\du                     # List users/roles
\dn                     # List schemas
\df                     # List functions
\dv                     # List views
\di                     # List indexes
\x                      # Toggle expanded display
\timing                 # Toggle query timing
\! clear                # Clear screen
```

## Database Operations

### Create and Drop
```sql
CREATE DATABASE database_name;
CREATE DATABASE database_name WITH ENCODING 'UTF8';
CREATE DATABASE database_name OWNER username;

DROP DATABASE database_name;
DROP DATABASE IF EXISTS database_name;
```

### Show Databases
```sql
\l
SELECT datname FROM pg_database;
```

## Table Operations

### Create Table
```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS table_name (...);
```

### Alter Table
```sql
ALTER TABLE users ADD COLUMN age INTEGER;
ALTER TABLE users DROP COLUMN age;
ALTER TABLE users ALTER COLUMN username TYPE VARCHAR(100);
ALTER TABLE users RENAME COLUMN old_name TO new_name;
ALTER TABLE users RENAME TO new_users;
ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE (email);
ALTER TABLE users DROP CONSTRAINT unique_email;
```

### Drop and Truncate
```sql
DROP TABLE table_name;
DROP TABLE IF EXISTS table_name CASCADE;
TRUNCATE TABLE table_name;
TRUNCATE TABLE table_name RESTART IDENTITY;
```

### Show Tables
```sql
\dt
SELECT table_name FROM information_schema.tables 
WHERE table_schema = 'public';

\d table_name                           -- Describe table
\d+ table_name                          -- Detailed description
```

## CRUD Operations

### INSERT
```sql
INSERT INTO users (username, email, password) 
VALUES ('john', 'john@example.com', 'hashed_password');

INSERT INTO users (username, email, password) VALUES
    ('alice', 'alice@example.com', 'pass1'),
    ('bob', 'bob@example.com', 'pass2');

INSERT INTO users (username, email) 
VALUES ('jane', 'jane@example.com') 
RETURNING id;
```

### SELECT
```sql
SELECT * FROM users;
SELECT username, email FROM users;
SELECT DISTINCT username FROM users;
SELECT * FROM users WHERE id = 1;
SELECT * FROM users WHERE age > 18 AND status = 'active';
SELECT * FROM users WHERE email LIKE '%@gmail.com';
SELECT * FROM users WHERE email ILIKE '%@GMAIL.COM';  -- Case-insensitive
SELECT * FROM users ORDER BY created_at DESC;
SELECT * FROM users LIMIT 10;
SELECT * FROM users LIMIT 10 OFFSET 20;
SELECT COUNT(*) FROM users;
SELECT * FROM users WHERE id IN (1, 2, 3);
SELECT * FROM users WHERE age BETWEEN 18 AND 65;
SELECT * FROM users WHERE email IS NULL;
SELECT * FROM users WHERE email IS NOT NULL;
```

### UPDATE
```sql
UPDATE users SET email = 'newemail@example.com' WHERE id = 1;
UPDATE users SET status = 'inactive' WHERE last_login < '2023-01-01';
UPDATE users SET login_count = login_count + 1 WHERE id = 1;
UPDATE users SET email = 'new@example.com' WHERE id = 1 RETURNING *;
```

### DELETE
```sql
DELETE FROM users WHERE id = 1;
DELETE FROM users WHERE status = 'inactive';
DELETE FROM users WHERE id = 1 RETURNING *;
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

### FULL OUTER JOIN
```sql
SELECT users.username, orders.order_date
FROM users
FULL OUTER JOIN orders ON users.id = orders.user_id;
```

## Aggregate Functions

### Common Functions
```sql
SELECT COUNT(*) FROM users;
SELECT COUNT(DISTINCT username) FROM users;
SELECT SUM(amount) FROM orders;
SELECT AVG(price) FROM products;
SELECT MIN(price), MAX(price) FROM products;
SELECT STRING_AGG(username, ', ') FROM users;
SELECT ARRAY_AGG(username) FROM users;
```

### GROUP BY
```sql
SELECT status, COUNT(*) FROM users GROUP BY status;
SELECT user_id, SUM(amount) FROM orders GROUP BY user_id;
SELECT user_id, COUNT(*) as order_count 
FROM orders 
GROUP BY user_id 
HAVING COUNT(*) > 5;
```

## Indexes

### Create Index
```sql
CREATE INDEX idx_username ON users(username);
CREATE UNIQUE INDEX idx_email ON users(email);
CREATE INDEX idx_name ON users(first_name, last_name);
CREATE INDEX idx_email_lower ON users(LOWER(email));
CREATE INDEX CONCURRENTLY idx_username ON users(username);  -- Non-blocking
```

### Drop Index
```sql
DROP INDEX idx_username;
DROP INDEX IF EXISTS idx_username;
DROP INDEX CONCURRENTLY idx_username;
```

### Show Indexes
```sql
\di
SELECT * FROM pg_indexes WHERE tablename = 'users';
```

## Constraints

### Primary Key
```sql
ALTER TABLE users ADD PRIMARY KEY (id);
ALTER TABLE users DROP CONSTRAINT users_pkey;
```

### Foreign Key
```sql
ALTER TABLE orders 
ADD CONSTRAINT fk_user 
FOREIGN KEY (user_id) REFERENCES users(id) 
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE orders DROP CONSTRAINT fk_user;
```

### Unique Constraint
```sql
ALTER TABLE users ADD UNIQUE (email);
ALTER TABLE users ADD CONSTRAINT uc_email UNIQUE (email);
ALTER TABLE users DROP CONSTRAINT uc_email;
```

### Check Constraint
```sql
ALTER TABLE users ADD CONSTRAINT chk_age CHECK (age >= 18);
ALTER TABLE users DROP CONSTRAINT chk_age;
```

### Not Null
```sql
ALTER TABLE users ALTER COLUMN email SET NOT NULL;
ALTER TABLE users ALTER COLUMN email DROP NOT NULL;
```

## User Management

### Create User/Role
```sql
CREATE USER username WITH PASSWORD 'password';
CREATE ROLE username WITH LOGIN PASSWORD 'password';
CREATE ROLE admin WITH SUPERUSER CREATEDB CREATEROLE;
```

### Grant Privileges
```sql
GRANT ALL PRIVILEGES ON DATABASE database_name TO username;
GRANT SELECT, INSERT, UPDATE ON table_name TO username;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO username;
GRANT USAGE ON SCHEMA public TO username;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO username;
```

### Revoke Privileges
```sql
REVOKE ALL PRIVILEGES ON DATABASE database_name FROM username;
REVOKE SELECT ON table_name FROM username;
```

### Show and Drop User
```sql
\du
SELECT usename FROM pg_user;
DROP USER username;
DROP ROLE username;
```

### Change Password
```sql
ALTER USER username WITH PASSWORD 'new_password';
\password username
```

## Backup and Restore

### Backup
```bash
# Backup single database
pg_dump -U postgres database_name > backup.sql
pg_dump -U postgres -d database_name -f backup.sql

# Backup all databases
pg_dumpall -U postgres > all_databases.sql

# Backup in custom format (compressed)
pg_dump -U postgres -Fc database_name > backup.dump

# Backup specific tables
pg_dump -U postgres -t table1 -t table2 database_name > tables.sql

# Backup structure only
pg_dump -U postgres --schema-only database_name > structure.sql

# Backup data only
pg_dump -U postgres --data-only database_name > data.sql
```

### Restore
```bash
# Restore from SQL file
psql -U postgres database_name < backup.sql

# Restore from custom format
pg_restore -U postgres -d database_name backup.dump

# Restore with clean (drop existing objects)
pg_restore -U postgres -d database_name -c backup.dump

# Restore all databases
psql -U postgres < all_databases.sql
```

## Transactions

### Basic Transaction
```sql
BEGIN;
-- or START TRANSACTION;

UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;

COMMIT;
-- or ROLLBACK;
```

### Savepoints
```sql
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
SAVEPOINT sp1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
ROLLBACK TO sp1;
COMMIT;
```

## String Functions

```sql
SELECT CONCAT('Hello', ' ', 'World');
SELECT 'Hello' || ' ' || 'World';           -- Concatenation operator
SELECT UPPER('hello');
SELECT LOWER('HELLO');
SELECT LENGTH('hello');
SELECT SUBSTRING('hello' FROM 1 FOR 3);
SELECT REPLACE('hello world', 'world', 'PostgreSQL');
SELECT TRIM('  hello  ');
SELECT LTRIM('  hello');
SELECT RTRIM('hello  ');
SELECT POSITION('world' IN 'hello world');
SELECT SPLIT_PART('a,b,c', ',', 2);         -- Returns 'b'
```

## Date Functions

```sql
SELECT NOW();                               -- Current timestamp
SELECT CURRENT_DATE;                        -- Current date
SELECT CURRENT_TIME;                        -- Current time
SELECT DATE('2024-01-15 10:30:00');
SELECT TIME('2024-01-15 10:30:00');
SELECT EXTRACT(YEAR FROM NOW());
SELECT EXTRACT(MONTH FROM NOW());
SELECT EXTRACT(DAY FROM NOW());
SELECT NOW() + INTERVAL '7 days';
SELECT NOW() - INTERVAL '1 month';
SELECT AGE('2024-12-31', '2024-01-01');
SELECT TO_CHAR(NOW(), 'YYYY-MM-DD HH24:MI:SS');
```

## JSON Operations

### JSON Functions
```sql
-- Create JSON
SELECT '{"name": "John", "age": 30}'::json;

-- Extract JSON field
SELECT data->>'name' FROM users;            -- Text
SELECT data->'age' FROM users;              -- JSON

-- JSON array
SELECT data->'tags'->0 FROM posts;

-- Check if key exists
SELECT data ? 'name' FROM users;

-- Update JSON
UPDATE users SET data = jsonb_set(data, '{age}', '31') WHERE id = 1;
```

## Window Functions

```sql
SELECT username, 
       ROW_NUMBER() OVER (ORDER BY created_at) as row_num,
       RANK() OVER (ORDER BY score DESC) as rank,
       LAG(score) OVER (ORDER BY created_at) as prev_score,
       LEAD(score) OVER (ORDER BY created_at) as next_score
FROM users;
```

## Common Table Expressions (CTE)

```sql
WITH active_users AS (
    SELECT * FROM users WHERE status = 'active'
)
SELECT * FROM active_users WHERE age > 18;

-- Recursive CTE
WITH RECURSIVE subordinates AS (
    SELECT id, name, manager_id FROM employees WHERE manager_id IS NULL
    UNION ALL
    SELECT e.id, e.name, e.manager_id 
    FROM employees e
    INNER JOIN subordinates s ON s.id = e.manager_id
)
SELECT * FROM subordinates;
```

## Useful Queries

### Find Duplicate Records
```sql
SELECT email, COUNT(*) as count
FROM users
GROUP BY email
HAVING COUNT(*) > 1;
```

### Delete Duplicates (Keep First)
```sql
DELETE FROM users a USING users b
WHERE a.id > b.id AND a.email = b.email;
```

### Random Rows
```sql
SELECT * FROM users ORDER BY RANDOM() LIMIT 10;
```

### Copy Table
```sql
CREATE TABLE users_backup AS SELECT * FROM users;
CREATE TABLE users_copy (LIKE users INCLUDING ALL);
```

### Upsert (INSERT ... ON CONFLICT)
```sql
INSERT INTO users (id, username, email) 
VALUES (1, 'john', 'john@example.com')
ON CONFLICT (id) 
DO UPDATE SET username = EXCLUDED.username, email = EXCLUDED.email;
```

## Performance

### Explain Query
```sql
EXPLAIN SELECT * FROM users WHERE username = 'john';
EXPLAIN ANALYZE SELECT * FROM users WHERE username = 'john';
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM users WHERE username = 'john';
```

### Vacuum and Analyze
```sql
VACUUM;
VACUUM FULL;
VACUUM ANALYZE;
ANALYZE users;
REINDEX TABLE users;
```

### Show Activity
```sql
SELECT * FROM pg_stat_activity;
SELECT pg_cancel_backend(pid);              -- Cancel query
SELECT pg_terminate_backend(pid);           -- Terminate connection
```

## Configuration

### Show Settings
```sql
SHOW ALL;
SHOW max_connections;
SELECT name, setting FROM pg_settings WHERE name = 'max_connections';
```

### Change Settings
```sql
ALTER SYSTEM SET max_connections = 200;
SELECT pg_reload_conf();                    -- Reload configuration
```

## Database Information

### Database Size
```sql
SELECT pg_size_pretty(pg_database_size('database_name'));
```

### Table Size
```sql
SELECT pg_size_pretty(pg_total_relation_size('table_name'));
SELECT pg_size_pretty(pg_table_size('table_name'));
```

### Largest Tables
```sql
SELECT schemaname, tablename, 
       pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size
FROM pg_tables
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC
LIMIT 10;
```

## Tips

1. **Use EXPLAIN ANALYZE** to optimize queries
2. **Create indexes** on frequently queried columns
3. **Use VACUUM** regularly to maintain performance
4. **Backup regularly** with pg_dump
5. **Use transactions** for data integrity
6. **Monitor pg_stat_activity** for long-running queries
7. **Use connection pooling** (PgBouncer) for high traffic
8. **Keep PostgreSQL updated** for security and features
9. **Use appropriate data types** (JSONB, ARRAY, etc.)
10. **Leverage CTEs** for complex queries

## Resources

- Official Documentation: https://www.postgresql.org/docs/
- PostgreSQL Tutorial: https://www.postgresqltutorial.com/
- PgExercises: https://pgexercises.com/
