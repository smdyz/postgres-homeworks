-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
select c.company_name, concat(e.first_name, ' ', e.last_name)
from orders as o
join customers as c using(customer_id)
join employees as e using(employee_id)
join shippers as s on o.ship_via = s.shipper_id
where e.city = c.city
and e.city = 'London'
and s.company_name = 'United Package';

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
select product_name, units_in_stock, s.contact_name, s.phone, c.category_name
from products
left join suppliers as s using(supplier_id)
join categories as c using(category_id)
where discontinued = 0
and units_in_stock < 25
and c.category_name = 'Dairy Products' or c.category_name = 'Condiments'
order by units_in_stock asc;

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
select company_name
from customers
left join orders as o using(customer_id)
where order_id is null
order by company_name asc;

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
select distinct product_name
from products
join order_details using(product_id)
where quantity in (
	select quantity
	from order_details
	where quantity = 10);
