-- ������������ ������� �� ���� ������������ ��������

-- �������� ������� logs ���� Archive. ����� ��� ������ �������� ������ � �������� users,
-- catalogs � products � ������� logs ���������� ����� � ���� �������� ������, �������� �������,
-- ������������� ���������� ����� � ���������� ���� name.

DROP TABLE IF EXISTS `logs`;

CREATE TABLE `logs` (
	`datatime` datetime not null,
	`name_of_table` enum('users','catalogs','products'),
	`id` bigint not null,
	`name_content` varchar(255)
) COMMENT = '��� ���������� ���������� � �������' ENGINE=Archive;

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

insert into users (name, birthday_at) values ('�������', '1994-10-05');
insert into catalogs (name) values ('������');
insert into products (name, description, price, catalog_id) values ('��������', '����� �� ����', 500, 6);

-- 

select * from logs;


-- ������������ ������� �� ���� �NoSQL�

-- 1. � ���� ������ Redis ��������� ��������� ��� �������� ��������� � ������������ IP-�������.
HSET ipaddr 127.0.0.1 1

-- 2. ��� ������ ���� ������ Redis ������ ������ ������ ����� ������������ �� ������������ ������ � ��������,
-- ����� ������������ ������ ������������ �� ��� �����.
SET test@test.ru Test
SET Test_user test@test.ru
GET test@test.ru
GET Test

-- 3. ����������� �������� ��������� � �������� ������� ������� ���� ������ shop � ���� MongoDB.
db.shop.insert({category: '����������'})
db.shop.insert({category: '����������� �����'})

db.shop.update({category: '����������'}, {$set: { products:['Intel Core i3-8100', 'Intel Core i5-7400'] }})
db.shop.update({category: '����������� �����'}, {$set: { products:['ASUS ROG MAXIMUS X HERO', 'Gigabyte H310M S2H', 'MSI B250M GAMING PRO'] }})
