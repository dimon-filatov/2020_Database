-- Практическое задание по теме “Транзакции, переменные, представления”
 
-- В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
 
START TRANSACTION;
insert into sample.users select * from users where id=1;
COMMIT;

-- Создайте представление, которое выводит название name товарной позиции из таблицы products и
-- соответствующее название каталога name из таблицы catalogs.

create view p_c(product, catalogs) as
select p.name, c.name from products p join catalogs c where p.catalog_id = c.id;
select * from p_c;

-- Практическое задание по теме “Администрирование MySQL”

-- Создайте двух пользователей которые имеют доступ к базе данных shop.
-- Первому пользователю shop_read должны быть доступны только запросы на чтение данных,
-- второму пользователю shop — любые операции в пределах базы данных shop.

CREATE USER shop_read;
CREATE USER shop;

GRANT ALL ON shop.* TO shop;
GRANT SELECT, SHOW VIEW ON shop.* TO shop_read;

-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"

-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

drop function if exists hello;

delimiter //

create function hellow()
returns varchar(50) reads sql data
begin
	case
		when hour(now()) between 6 and 11 then
			return 'Доброе утро';
		when hour(now()) between 12 and 17 then
			return 'Добрый день';
		when hour(now()) between 18 and 23 then
			return 'Добрый вечер';
		when hour(now()) between 0 and 5 then
			return 'Доброй ночи';
		else
			return 'Ошибка даты';
	end case;
end //

delimiter ;

-- В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
-- Допустимо присутствие обоих полей или одно из них.
-- Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

drop trigger if exists check_products;

delimiter //

create trigger check_products before insert on products
for each row
begin
	if new.name is null and new.description is null then
		signal sqlstate '45000'
		set message_text = 'You cannot leave name and description without value!';
	end if;
end //

delimiter ;
