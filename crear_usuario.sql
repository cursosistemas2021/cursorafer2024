-- script de creacion de usuario  sakila
-- Este comando se usa solo si falla el create user
-- alter session set "_ORACLE_SCRIPT"=true;

-- creamos el usuario
create user sakila identified by sakila;

-- Asignamos Privilegios
grant all privileges to sakila;

connect sakila/sakila@orcl;

