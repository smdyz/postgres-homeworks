-- SQL-команды для создания таблиц

CREATE TABLE customers
(
	customer_id char(5) PRIMARY KEY,
	company_name varchar NOT NULL,
	contact_name varchar NOT NULL
);

CREATE TABLE employees
(
	employee_id int PRIMARY KEY,
	first_name varchar(20) NOT NULL,
	last_name varchar(20),
	title varchar(50) NOT NULL,
	birth_date date NOT NULL,
	notes text
);

CREATE TABLE orders
(
	order_id smallint PRIMARY KEY,
	custimer_id char(5) REFERENCES customers(customer_id) NOT NULL,
	employee_id int REFERENCES employees(employee_id) NOT NULL,
	order_date date NOT NULL,
	ship_city varchar(187) NOT NULL
);
