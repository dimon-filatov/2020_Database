-- ����������, ����������, ���������� � �����������

-- 1. ����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.
update users set created_at = now(), updated_at = now();

-- 2. ������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ ����� ���������� �������� � ������� 20.10.2017 8:10. ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.
update users set created_at = str_to_date(created_at, '%d.%m.%Y %H:%i');
update users set updated_at = str_to_date(updated_at, '%d.%m.%Y %H:%i');

alter table users change column created_at created_at DATETIME;
alter table users change column updated_at updated_at DATETIME;

-- 3. � ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����: 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������. ���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value. ������ ������� ������ ������ ���������� � �����, ����� ���� �������.
select * from storehouses_products order by if (value = 0, 1, 0), value;

-- 4. �� ������� users ���������� ������� �������������, ���������� � ������� � ���. ������ ������ � ���� ������ ���������� �������� (may, august)
select * from users where date_format(birthday_at, '%M') in ('May', 'August');

-- 5. �� ������� catalogs ����������� ������ ��� ������ �������. SELECT * FROM catalogs WHERE id IN (5, 1, 2); ������������ ������ � �������, �������� � ������ IN.
select * from catalogs where id in (5, 1, 2) order by field(id, 5, 1, 2);


-- ���������� �������

-- 1. ����������� ������� ������� ������������� � ������� users.
select avg(timestampdiff(year, birthday_at, now())) as age from users;

-- 2. ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.
select name, 
	date_format(str_to_date(concat(date_format(birthday_at, '%e-%m'), '-', date_format(now(), '%Y')), '%e-%m-%Y'), '%W')
from users; 
-- ����� �������, �� ����� �� �������� �������

-- 3. ����������� ������������ ����� � ������� �������.
select exp(sum(log(id))) v from catalogs;

