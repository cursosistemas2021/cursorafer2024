-- SAKILA_SCHEMA PARA LANZAR EN ORACLE

-- borrado de tablas
DROP TABLE payment;
DROP TABLE rental;
DROP TABLE inventory;
DROP TABLE customer;
DROP TABLE store;
DROP TABLE address;
DROP TABLE city;
DROP TABLE country;
DROP TABLE film_actor;
DROP TABLE film_text;
DROP TABLE film_category;
DROP TABLE film;
DROP TABLE language;
DROP TABLE actor;
DROP TABLE category;

CREATE TABLE language (
  language_id number(3) NOT NULL,
  name char(20) NOT NULL,
  last_update TIMESTAMP DEFAULT SYSDATE NOT NULL,
  PRIMARY KEY (language_id)
);

CREATE TABLE actor(
  actor_id number(5) NOT NULL,
  first_name varchar2(45) NOT NULL,
  last_name varchar2(45) NOT NULL,
  last_update TIMESTAMP DEFAULT SYSDATE NOT NULL,
  PRIMARY KEY (actor_id)
);

--
-- Table structure for table film_text
--
CREATE TABLE film_text (
  film_id number(6) NOT NULL,
  title varchar2(255) NOT NULL,
  description varchar2(2000),
  PRIMARY KEY (film_id)
);
--
-- Table structure for table category
--
CREATE TABLE category (
  category_id number(3)  NOT NULL,
  name varchar2(25) NOT NULL,
  last_update TIMESTAMP DEFAULT SYSDATE NOT NULL,
  PRIMARY KEY (category_id)
);

--
-- Table structure for table country
--
CREATE TABLE country (
  country_id number(5) NOT NULL,
  country varchar2(50) NOT NULL,
  last_update TIMESTAMP DEFAULT SYSDATE NOT NULL,
  PRIMARY KEY (country_id)
);

--
-- Table structure for table city
--
CREATE TABLE city (
  city_id number(5) NOT NULL,
  city varchar2(50) NOT NULL,
  country_id number(5) NOT NULL,
  last_update TIMESTAMP DEFAULT SYSDATE NOT NULL,
  PRIMARY KEY (city_id),
  CONSTRAINT fk_city_country FOREIGN KEY (country_id) REFERENCES country (country_id)
);

--
-- Table structure for table address
--
CREATE TABLE address (
  address_id number(5)  NOT NULL,
  address varchar2(50) NOT NULL,
  address2 varchar2(50) NULL,
  district varchar2(20) NULL,
  city_id number(5) NOT NULL,
  postal_code varchar2(10) NULL,
  phone varchar2(20) NULL,
  last_update TIMESTAMP DEFAULT SYSDATE NOT NULL,
  PRIMARY KEY (address_id),
  CONSTRAINT fk_address_city FOREIGN KEY (city_id) REFERENCES city (city_id)
  );

--
-- Table structure for table store
--
CREATE TABLE store (
  store_id number(3)  NOT NULL,
  manager_staff_id number(3)  NOT NULL,
  address_id number(5)  NOT NULL,
  last_update TIMESTAMP DEFAULT SYSDATE NOT NULL,
  PRIMARY KEY (store_id),
  CONSTRAINT fk_store_address FOREIGN KEY (address_id) REFERENCES address (address_id)
);

--
-- Table structure for table customer
--
CREATE TABLE customer(
  customer_id number(5)  NOT NULL,
  store_id number(3)  NOT NULL,
  first_name varchar2(45) NOT NULL,
  last_name varchar2(45) NOT NULL,
  email varchar2(50) NULL,
  address_id number(5)  NOT NULL,
  active number(1) NOT NULL,
  create_date TIMESTAMP NOT NULL,
  last_update TIMESTAMP DEFAULT SYSDATE NOT NULL,
  PRIMARY KEY (customer_id),
  CONSTRAINT fk_customer_address FOREIGN KEY (address_id) REFERENCES address (address_id),
  CONSTRAINT fk_customer_store FOREIGN KEY (store_id) REFERENCES store (store_id)
);
--
-- Table structure for table film
--
CREATE TABLE film(
  film_id number(5) NOT NULL ,
  title varchar2(255) NOT NULL,
  description varchar2(2000),
  release_year NUMBER(4) NULL,
  language_id number(3) NOT NULL,
  original_language_id number(3) NULL,
  rental_duration number(3)  NOT NULL,
  rental_rate number(4,2) NOT NULL,
  length number(5) NULL,
  replacement_cost number(5,2) NOT NULL,
  rating varchar2(5),
  special_features varchar2(80) NULL,
  last_update TIMESTAMP DEFAULT SYSDATE NOT NULL,
  PRIMARY KEY (film_id),
  CONSTRAINT fk_film_language FOREIGN KEY (language_id) REFERENCES language (language_id),
  CONSTRAINT fk_film_language_original FOREIGN KEY (original_language_id) REFERENCES language (language_id)
);

--
-- Table structure for table film_actor
--
CREATE TABLE film_actor(
  actor_id number(5) NOT NULL,
  film_id number(5) NOT NULL,
  last_update TIMESTAMP DEFAULT SYSDATE NOT NULL,
  PRIMARY KEY (actor_id,film_id),
  CONSTRAINT fk_film_actor_actor FOREIGN KEY (actor_id) REFERENCES actor (actor_id),
  CONSTRAINT fk_film_actor_film FOREIGN KEY (film_id) REFERENCES film (film_id)
);

--
-- Table structure for table film_category
--
CREATE TABLE film_category (
  film_id number(5)  NOT NULL,
  category_id number(3)  NOT NULL,
  last_update TIMESTAMP DEFAULT SYSDATE NOT NULL,
  PRIMARY KEY (film_id,category_id),
  CONSTRAINT fk_film_category_category FOREIGN KEY (category_id) REFERENCES category (category_id),
  CONSTRAINT fk_film_category_film FOREIGN KEY (film_id) REFERENCES film (film_id) 
);

--
-- Table structure for table inventory
CREATE TABLE inventory (
  inventory_id number(8) NOT NULL,
  film_id number(5) NOT NULL,
  store_id number(3) NOT NULL,
  last_update TIMESTAMP DEFAULT SYSDATE NOT NULL,
  PRIMARY KEY (inventory_id),
  CONSTRAINT fk_inventory_film FOREIGN KEY (film_id) REFERENCES film (film_id),
  CONSTRAINT fk_inventory_store FOREIGN KEY (store_id) REFERENCES store (store_id) 
);

--
-- Table structure for table rental
--
CREATE TABLE rental(
  rental_id number(11) NOT NULL,
  rental_date timestamp NOT NULL,
  inventory_id number(8) NOT NULL,
  customer_id number(5) NOT NULL,
  return_date timestamp NULL,
  staff_id number(3)  NOT NULL,
  last_update TIMESTAMP DEFAULT SYSDATE NOT NULL,
  PRIMARY KEY (rental_id),
  CONSTRAINT fk_rental_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
  CONSTRAINT fk_rental_inventory FOREIGN KEY (inventory_id) REFERENCES inventory (inventory_id)
);

--
-- Table structure for table payment
--
CREATE TABLE payment(
  payment_id number(5)  NOT NULL,
  customer_id number(5)  NOT NULL,
  staff_id number(3)  NOT NULL,
  rental_id number(11) DEFAULT NULL,
  amount number(5,2) NOT NULL,
  payment_date timestamp NOT NULL,
  last_update TIMESTAMP DEFAULT SYSDATE NOT NULL,
  PRIMARY KEY (payment_id),
  CONSTRAINT fk_payment_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
  CONSTRAINT fk_payment_rental FOREIGN KEY (rental_id) REFERENCES rental (rental_id)
);

