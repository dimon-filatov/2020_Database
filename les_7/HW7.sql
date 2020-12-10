-- ��������� ������ ������������� users, ������� ����������� ���� �� ���� ����� orders � �������� ��������.
	
select name
from
	users u
join
	orders o
on u.id = o.user_id 
group by name;

-- �������� ������ ������� products � �������� catalogs, ������� ������������� ������.

select *
from
	products p
join
	catalogs c
on p.catalog_id = c.id

-- (�� �������) ����� ������� ������� ������ flights (id, from, to) � ������� ������� cities (label, name). ���� from, to � label �������� ���������� �������� �������, ���� name � �������. �������� ������ ������ flights � �������� ���������� �������.

select 
	(select name from cities c2 where label = f.`from`) as `from`,
	(select name from cities c2 where label = f.`to`) as `to`
from flights f;

