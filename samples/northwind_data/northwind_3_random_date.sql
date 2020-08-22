-- //////////////////////////////////////
--
-- --------------------------------
-- generation of random dates
-- --------------------------------
-- select to_char( date( (current_date - '2 years'::interval)+trunc(random() * 365 * 1.9) * '1 day'::interval) 
-- 				+ current_time, 'YYYY-MM-DD HH24:MI:SS'
-- 			  ) as rdate;

-- select to_char(current_timestamp, 'YYYY-MM-DD HH24:MI:SS') as rdate;

-- alter table categories add column rdate varchar(20) not null default to_char(current_timestamp, 'YYYY-MM-DD HH24:MI:SS');
-- select * from categories;
-- alter table categories drop column rdate;
-- select * from categories;
--
-- //////////////////////////////////////

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET default_tablespace = '';
SET default_with_oids = false;



-- add column 'rdate' for created date
alter table categories add column if not exists rdate varchar(25) null;
alter table customers add column if not exists rdate varchar(25) null;
alter table employees add column if not exists rdate varchar(25) null;
alter table orders add column if not exists rdate varchar(25) null;
alter table products add column if not exists rdate varchar(25) null;
alter table suppliers add column if not exists rdate varchar(25) null;
alter table shippers add column if not exists rdate varchar(25) null;
alter table order_details add column if not exists rdate varchar(25) null;

/*
select timestamp '2020-08-22T19:22:30';
---------------------
 2020-08-22 19:22:30
(1 row)

SELECT to_char(now()::timestamp at time zone 'UTC','YYYY-MM-DD"T"HH24:MI:SS');
---------------------
 2020-08-22T19:27:05
*/

-- update column 'rdate' for created date
update categories set rdate = 
	to_char( date( (current_date - '2 years'::interval)+trunc(random() * 365 * 1.9) * '1 day'::interval) 
					+ current_time, 'YYYY-MM-DD"T"HH24:MI:SS');
update customers set rdate = 
	to_char( date( (current_date - '2 years'::interval)+trunc(random() * 365 * 1.9) * '1 day'::interval) 
					+ current_time, 'YYYY-MM-DD"T"HH24:MI:SS');
update employees set rdate = 
	to_char( date( (current_date - '2 years'::interval)+trunc(random() * 365 * 1.9) * '1 day'::interval) 
					+ current_time, 'YYYY-MM-DD"T"HH24:MI:SS');
update orders set rdate = 
	to_char( date( (current_date - '2 years'::interval)+trunc(random() * 365 * 1.9) * '1 day'::interval) 
					+ current_time, 'YYYY-MM-DD"T"HH24:MI:SS');
update products set rdate = 
	to_char( date( (current_date - '2 years'::interval)+trunc(random() * 365 * 1.9) * '1 day'::interval) 
					+ current_time, 'YYYY-MM-DD"T"HH24:MI:SS');
update suppliers set rdate = 
	to_char( date( (current_date - '2 years'::interval)+trunc(random() * 365 * 1.9) * '1 day'::interval) 
					+ current_time, 'YYYY-MM-DD"T"HH24:MI:SS');
update shippers set rdate = 
	to_char( date( (current_date - '2 years'::interval)+trunc(random() * 365 * 1.9) * '1 day'::interval) 
					+ current_time, 'YYYY-MM-DD"T"HH24:MI:SS');
update order_details d set rdate = a.rdate from orders a where a.order_id = d.order_id;

/*
--
-- vertices for agenspop
--

-- vertex : category (8 rows)
SELECT category_id, category_name, description, rdate from categories;

-- vertex: customer (91 rows)
select customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone, fax, rdate from customers;

-- vertex: employee (9 rows)
select employee_id, last_name, first_name, title, title_of_courtesy, birth_date, hire_date, address, city, region, postal_code, country, home_phone, extension, notes, reports_to, rdate from employees;

-- vertex: order (830 rows)
select order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country, rdate from orders;

-- vertex: product (77 rows)
select product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, units_in_stock, units_on_order, reorder_level, discontinued, rdate from products;

-- vertex: supplier (29 rows)
select supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone, fax, homepage, rdate from suppliers;

-- vertex: shipper (6 rows)
select shipper_id, company_name, phone, rdate from shippers;


--
-- edges of agenspop
--

-- edge: contains (2155 rows)
select t2.order_id, t2.product_id, t2.unit_price, t2.quantity, t2.discount, t2.rdate 
from orders t1, order_details t2, products t3 
where t2.order_id = t1.order_id and t2.product_id = t3.product_id;

-- edge: part_of (77 rows)
select distinct t1.product_id, t2.category_id, t1.rdate from products t1, categories t2 where t1.category_id = t2.category_id;

-- edge: purchased (830 rows)
SELECT distinct t1.customer_id, t2.order_id, t2.rdate from customers t1, orders t2 where t1.customer_id = t2.customer_id;

-- edge: reports_to (8 rows)
SELECT distinct t1.employee_id, t1.reports_to, t1.rdate from employees t1, employees t2 where t1.reports_to = t2.employee_id;

-- edge: sold (830 rows)
SELECT distinct t1.employee_id, t2.order_id, t2.rdate from employees t1, orders t2 where t1.employee_id = t2.employee_id;

-- edge: supplies (77 rows)
SELECT distinct t1.supplier_id, t2.product_id, t1.rdate from suppliers t1, products t2 where t1.supplier_id = t2.supplier_id;

-- edge: ships (830 rows)
select distinct t1.order_id, t2.shipper_id, t1.rdate from orders t1, shippers t2 where t1.ship_via = t2.shipper_id;

 */
