-- ������������ ������� �� ���� �����������, ����������, ��������������
 
-- � ���� ������ shop � sample ������������ ���� � �� �� �������, ������� ���� ������.
-- ����������� ������ id = 1 �� ������� shop.users � ������� sample.users. ����������� ����������.
 
START TRANSACTION;
insert into sample.users select * from users where id=1;
COMMIT;

-- �������� �������������, ������� ������� �������� name �������� ������� �� ������� products �
-- ��������������� �������� �������� name �� ������� catalogs.

create view p_c(product, catalogs) as
select p.name, c.name from products p join catalogs c where p.catalog_id = c.id;
select * from p_c;

-- ������������ ������� �� ���� ������������������ MySQL�

-- �������� ���� ������������� ������� ����� ������ � ���� ������ shop.
-- ������� ������������ shop_read ������ ���� �������� ������ ������� �� ������ ������,
-- ������� ������������ shop � ����� �������� � �������� ���� ������ shop.

CREATE USER shop_read;
CREATE USER shop;

GRANT ALL ON shop.* TO shop;
GRANT SELECT, SHOW VIEW ON shop.* TO shop_read;

-- ������������ ������� �� ���� ��������� ��������� � �������, ��������"

-- �������� �������� ������� hello(), ������� ����� ���������� �����������, � ����������� �� �������� ������� �����.
-- � 6:00 �� 12:00 ������� ������ ���������� ����� "������ ����", � 12:00 �� 18:00 ������� ������ ���������� ����� "������ ����",
-- � 18:00 �� 00:00 � "������ �����", � 00:00 �� 6:00 � "������ ����".

drop function if exists hello;

delimiter //

create function hellow()
returns varchar(50) reads sql data
begin
	case
		when hour(now()) between 6 and 11 then
			return '������ ����';
		when hour(now()) between 12 and 17 then
			return '������ ����';
		when hour(now()) between 18 and 23 then
			return '������ �����';
		when hour(now()) between 0 and 5 then
			return '������ ����';
		else
			return '������ ����';
	end case;
end //

delimiter ;

-- � ������� products ���� ��� ��������� ����: name � ��������� ������ � description � ��� ���������.
-- ��������� ����������� ����� ����� ��� ���� �� ���.
-- ��������, ����� ��� ���� ��������� �������������� �������� NULL �����������.
-- ��������� ��������, ��������� ����, ����� ���� �� ���� ����� ��� ��� ���� ���� ���������.
-- ��� ������� ��������� ����� NULL-�������� ���������� �������� ��������.

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
