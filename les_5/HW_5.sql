-- «Операторы, фильтрация, сортировка и ограничение»

-- 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
update users set created_at = now(), updated_at = now();

-- 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
update users set created_at = str_to_date(created_at, '%d.%m.%Y %H:%i');
update users set updated_at = str_to_date(updated_at, '%d.%m.%Y %H:%i');

alter table users change column created_at created_at DATETIME;
alter table users change column updated_at updated_at DATETIME;

-- 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех записей.
select * from storehouses_products order by if (value = 0, 1, 0), value;

-- 4. Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий (may, august)
select * from users where date_format(birthday_at, '%M') in ('May', 'August');

-- 5. Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.
select * from catalogs where id in (5, 1, 2) order by field(id, 5, 1, 2);


-- «Агрегация данных»

-- 1. Подсчитайте средний возраст пользователей в таблице users.
select avg(timestampdiff(year, birthday_at, now())) as age from users;

-- 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.
select name, 
	date_format(str_to_date(concat(date_format(birthday_at, '%e-%m'), '-', date_format(now(), '%Y')), '%e-%m-%Y'), '%W')
from users; 
-- долго мучался, но проще не придумал решение

-- 3. Подсчитайте произведение чисел в столбце таблицы.
select exp(sum(log(id))) v from catalogs;

