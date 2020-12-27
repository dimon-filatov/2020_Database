-- ���������������� �������, ������� ����������� �� �������, ���������� ��������� ������������� �/��� ��������� (JOIN ���� �� ���������).

��� join �� ���� ��� �������� ����))

-- ����� ����� ��������� ������������. 
-- �� ���� ������ ����� ������������ ������� ��������, ������� ������ ���� ������� � ����� �������������.

select  
	(select concat(firstname, ' ', lastname) from users where id = m.from_user_id) from_user,
	count(*) as total_msg
from messages m
where 
	from_user_id in (select initiator_user_id from friend_requests where target_user_id = m.to_user_id and status = 'approved'
		union
	select target_user_id from friend_requests where initiator_user_id = m.to_user_id and status = 'approved') 
and
	to_user_id = 30
group by m.from_user_id order by total_msg desc
limit 1;

-- ���������� ����� ���������� ������, ������� �������� 10 ����� ������� �������������.
-- !!! �� ������ ���� ���� ������, ������� �������� � �����, ��� ����� ���� ������� � ������� (likes_posts)

select
	sum(total_likes)
	from
		(select
			(select birthday from users where id = lp.user_id) birthday,
			count(*) as total_likes
		from likes_posts lp
		group by lp.user_id order by birthday desc limit 11)
as total;
		

-- ���������� ��� ������ �������� ������ (�����) - ������� ��� �������?

select
	(select gender from users where id = lp.user_id) gender,
	count(*) as total_likes
from likes_posts lp
group by gender order by total_likes desc limit 1;

-- ����� 10 �������������, ������� ��������� ���������� ���������� � ������������� ���������� ����.

select 
	concat(firstname, ' ', lastname) as Name, 
	(select count(*) from (select initiator_user_id from friend_requests where target_user_id = u3.id and (status = 'approved' or status = 'requested')
		union
	select target_user_id from friend_requests where initiator_user_id = u3.id and status = 'approved'
		union
	select id from likes_posts where user_id = u3.id
		union
	select id from messages where to_user_id = u3.id or from_user_id = u3.id
		union
	select id from posts where user_id = u3.id
		union
	select id from photos where user_id = u3.id
		union
	select id from users_communities where user_id = u3.id
	) as fr_list) as Activity
from users u3
order by Activity limit 10;

-- ��������

select 
	concat(firstname, ' ', lastname), 
	-- ���-�� ������ ������������
	(select count(*) from likes_posts where user_id = u3.id) as likes,
	-- ���-�� ������
	(select count(*) from (select initiator_user_id from friend_requests where target_user_id = u3.id and status = 'approved'
		union
	select target_user_id from friend_requests where initiator_user_id = u3.id and status = 'approved') as fr_list) as friends,
	-- ���-�� �����������
	(select count(*) from friend_requests where target_user_id = u3.id and status ='requested') as followers,
	-- ���-�� ��������� ������������
	(select count(*) from messages where to_user_id = u3.id) as messages_to,
	-- ���-�� ��������� �� ������������
	(select count(*) from messages where from_user_id = u3.id) as messages_from,
	-- ���-�� ������
	(select count(*) from posts where user_id = u3.id) as posts,
	-- ���-�� ����
	(select count(*) from photos where user_id = u3.id) as photos,
	-- ���-�� �����
	(select count(*) from users_communities where user_id = u3.id) as communities
from users u3;

