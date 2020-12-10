-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
	
select name
from
	users u
join
	orders o
on u.id = o.user_id 
group by name;

-- Выведите список товаров products и разделов catalogs, который соответствует товару.

select *
from
	products p
join
	catalogs c
on p.catalog_id = c.id

-- (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.

select 
	(select name from cities c2 where label = f.`from`) as `from`,
	(select name from cities c2 where label = f.`to`) as `to`
from flights f;

