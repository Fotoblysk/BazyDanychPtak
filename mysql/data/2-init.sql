CREATE USER 'user'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE, SHOW VIEW, GRANT OPTION, CREATE TEMPORARY TABLES, LOCK TABLES ON main.* TO backend@% IDENTIFIED BY '4321';