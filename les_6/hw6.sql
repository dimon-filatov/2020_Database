-- ѕроанализировать запросы, которые выполн€лись на зан€тии, определить возможные корректировки и/или улучшени€ (JOIN пока не примен€ть).

Ѕез join не знаю как улучшить пока))

-- ѕусть задан некоторый пользователь. 
-- »з всех друзей этого пользовател€ найдите человека, который больше всех общалс€ с нашим пользователем.

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

-- ѕодсчитать общее количество лайков, которые получили 10 самых молодых пользователей.
-- !!! «а основу вз€л базу данных, которую добавили к уроку, тут всего одна таблица с лайками (likes_posts)

select
	sum(total_likes)
	from
		(select
			(select birthday from users where id = lp.user_id) birthday,
			count(*) as total_likes
		from likes_posts lp
		group by lp.user_id order by birthday desc limit 11)
as total;
		

-- ќпределить кто больше поставил лайков (всего) - мужчины или женщины?

select
	(select gender from users where id = lp.user_id) gender,
	count(*) as total_likes
from likes_posts lp
group by gender order by total_likes desc limit 1;

-- Ќайти 10 пользователей, которые про€вл€ют наименьшую активность в использовании социальной сети.

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

-- ѕроверка

select 
	concat(firstname, ' ', lastname), 
	-- кол-во лайков поставленных
	(select count(*) from likes_posts where user_id = u3.id) as likes,
	-- кол-во друзей
	(select count(*) from (select initiator_user_id from friend_requests where target_user_id = u3.id and status = 'approved'
		union
	select target_user_id from friend_requests where initiator_user_id = u3.id and status = 'approved') as fr_list) as friends,
	-- кол-во подписчиков
	(select count(*) from friend_requests where target_user_id = u3.id and status ='requested') as followers,
	-- кол-во сообщений пользователю
	(select count(*) from messages where to_user_id = u3.id) as messages_to,
	-- кол-во сообщений от пользовател€
	(select count(*) from messages where from_user_id = u3.id) as messages_from,
	-- кол-во постов
	(select count(*) from posts where user_id = u3.id) as posts,
	-- кол-во фото
	(select count(*) from photos where user_id = u3.id) as photos,
	-- кол-во групп
	(select count(*) from users_communities where user_id = u3.id) as communities
from users u3;

