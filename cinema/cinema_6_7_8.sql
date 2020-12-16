-- 6. скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы);

-- Выбор фильмом выпущеных с 2015 года
select name, `year` from films f where `year` >= 2015;

-- Средний рейтинг всех фильмов на основе оценок пользователей
select name, round(avg(grade), 2) as rating from films f join film_rating fr ON f.id = fr.film_id
group by name order by rating desc;

-- Проверка пользователей, у кого не закончилась действовать подписка
select concat(u.firstname, ' ', u.lastname) as 'user', t.name as 'tariff', ut.end_date from users u join users_tariff ut on u.id = ut.user_id
join tariffs t on ut.tariff_id = t.id 
where end_date > now();

-- Имена пользователей, которые больше всех поставили оценок фильмам
select concat(u.firstname, ' ', u.lastname) as name, count(*) as count_of_grade from users u join film_rating fr on u.id = fr.user_id
group by name
having count_of_grade = (select max(rating) from (select count(*) as rating from film_rating group by user_id) as e);



-- 7. представления (минимум 2);

-- 1
create view film_with_genre as
select f.name as 'Film', g.name as 'genre', f.`year` from films f join genre g ON f.genre_id = g.id 
order by g.name, f.`year`, f.name;

-- 2
create view actor_in_film as
select f.name as film, a.name as actor from actors a join actors_in_films aif ON a.id = aif.actor_id join films f on aif.film_id = f.id
order by film, actor;



-- 8. хранимые процедуры / триггеры;

-- Сервер предлагает после просмотра фильма, фильмы такого же жанра с рейтингом выше среднего
drop procedure if exists films_offers;

delimiter //

create procedure films_offers(in for_genre_id int)
begin
	select name as film, round(avg(grade), 2) as rating from films f join film_rating fr ON f.id = fr.film_id
	where f.genre_id = for_genre_id
	group by name
	having rating > (select round(avg(rating), 2) from (select round(avg(grade), 2) as rating from film_rating group by film_id) as e)
	order by rand()
	limit 10;
end//

delimiter ;

call films_offers(1);

-- Проверка, что у фильма есть название, продолжительность, страна производства и жанр
drop trigger if exists check_film;

delimiter //

create trigger check_film before insert on films
for each row
begin
	if new.name is null then
		signal sqlstate '45000'
		set message_text = 'You cannot leave name without value!';
	elseif new.duration is null then
		signal sqlstate '45000'
		set message_text = 'You cannot leave duration without value!';
	elseif new.country_id is null then
		signal sqlstate '45000'
		set message_text = 'You cannot leave country_id without value!';
	elseif new.genre_id is null then
		signal sqlstate '45000'
		set message_text = 'You cannot leave genre_id without value!';
	end if;
end //

delimiter ;

