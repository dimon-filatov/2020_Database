-- Практическое задание по теме “Оптимизация запросов”

-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users,
-- catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы,
-- идентификатор первичного ключа и содержимое поля name.

DROP TABLE IF EXISTS `logs`;

CREATE TABLE `logs` (
	`datatime` datetime not null,
	`name_of_table` enum('users','catalogs','products'),
	`id` bigint not null,
	`name_content` varchar(255)
) COMMENT = 'Лог добавления информации в таблицы' ENGINE=Archive;

-- 

drop trigger if exists insert_user;

delimiter //

create trigger insert_user after insert on users
for each row
begin
	insert into logs (datatime, name_of_table, id, name_content)
	values (now(), 'users', new.id, new.name);
end //

delimiter ;

-- 

drop trigger if exists insert_catalog;

delimiter //

create trigger insert_catalog after insert on catalogs
for each row
begin
	insert into logs (datatime, name_of_table, id, name_content)
	values (now(), 'catalogs', new.id, new.name);
end //

delimiter ;

-- 

drop trigger if exists insert_product;

delimiter //

create trigger insert_product after insert on products
for each row
begin
	insert into logs (datatime, name_of_table, id, name_content)
	values (now(), 'products', new.id, new.name);
end //

delimiter ;

--

insert into users (name, birthday_at) values ('Василий', '1994-10-05');
insert into catalogs (name) values ('Разное');
insert into products (name, description, price, catalog_id) values ('Перчатки', 'Маски на лицо', 500, 6);

-- 

select * from logs;


-- Практическое задание по теме “NoSQL”

-- 1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
HSET ipaddr 127.0.0.1 1

-- 2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот,
-- поиск электронного адреса пользователя по его имени.
SET test@test.ru Test
SET Test_user test@test.ru
GET test@test.ru
GET Test

-- 3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.
db.shop.insert({category: 'Процессоры'})
db.shop.insert({category: 'Материнские платы'})

db.shop.update({category: 'Процессоры'}, {$set: { products:['Intel Core i3-8100', 'Intel Core i5-7400'] }})
db.shop.update({category: 'Материнские платы'}, {$set: { products:['ASUS ROG MAXIMUS X HERO', 'Gigabyte H310M S2H', 'MSI B250M GAMING PRO'] }})
