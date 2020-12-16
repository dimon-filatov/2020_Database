-- Курсовой проект на основе сервиса Megogo

drop database if exists cinema;
create database cinema;

use cinema;

drop table if exists genre;
create table genre (
	`id` serial primary key,
	`name` varchar(50)
);

drop table if exists country;
create table country (
	`id` serial primary key,
	`name` varchar(50)
);

drop table if exists films;
create table films (
	`id` serial primary key,
	`name` varchar(120),
	`year` year,
	`genre_id` bigint unsigned not null,
	`description` text,
	`country_id` bigint unsigned not null,
	`duration` smallint unsigned not null,
	`poster` bigint unsigned,
	`created_at` datetime default now(),
	foreign key (genre_id) references genre(id),
	foreign key (country_id) references country(id)
);

drop table if exists cartoons;
create table cartoons (
	`id` serial primary key,
	`name` varchar(120),
	`year` year,
	`genre_id` bigint unsigned not null,
	`description` text,
	`country_id` bigint unsigned not null,
	`duration` smallint unsigned not null,
	`poster` bigint unsigned,
	`created_at` datetime default now(),
	foreign key (genre_id) references genre(id),
	foreign key (country_id) references country(id)
);

drop table if exists actors;
create table actors (
	`id` serial primary key,
	`name` varchar(120),
	`information` text
);

drop table if exists actors_in_films;
create table actors_in_films (
	`actor_id` bigint unsigned not null,
	`film_id` bigint unsigned not null,
	primary key (actor_id, film_id),
	foreign key (actor_id) references actors(id),
	foreign key (film_id) references films(id)
);

drop table if exists users;
create table users (
	`id` serial primary key,  
	`firstname` varchar(50),
	`lastname` varchar(50),
	`email` varchar(120) unique,
	`phone` varchar(20) unique,
	`birthday` date,
	`hometown` varchar(100),
	`gender` char(1),
	`photo_id` bigint unsigned,
	`created_at` datetime default now(),
	`pass` char(40)
);

drop table if exists tariffs;
create table tariffs (
	`id` serial primary key,  
	`name` varchar(50)
);

drop table if exists users_tariff;
create table users_tariff (
	`user_id` bigint unsigned not null,
	`tariff_id` bigint unsigned not null,
	`payed_at` datetime default now(),
	`end_date` datetime,
	primary key (user_id, tariff_id),
	foreign key (user_id) references users(id),
	foreign key (tariff_id) references tariffs(id)
);

drop table if exists film_rating;
create table film_rating (
	`user_id` bigint unsigned not null,
	`film_id` bigint unsigned not null,
	`grade` tinyint unsigned not null,
	primary key (user_id, film_id),
	foreign key (user_id) references users(id),
	foreign key (film_id) references films(id)
);

drop table if exists cartoon_rating;
create table cartoon_rating (
	`user_id` bigint unsigned not null,
	`cartoon_id` bigint unsigned not null,
	`grade` tinyint unsigned not null,
	primary key (user_id, cartoon_id),
	foreign key (user_id) references users(id),
	foreign key (cartoon_id) references cartoons(id)
);

drop table if exists film_review;
create table film_review (
	`user_id` bigint unsigned not null,
	`film_id` bigint unsigned not null,
	`review` text not null,
	primary key (user_id, film_id),
	foreign key (user_id) references users(id),
	foreign key (film_id) references films(id)
);

drop table if exists cartoon_review;
create table cartoon_review (
	`user_id` bigint unsigned not null,
	`cartoon_id` bigint unsigned not null,
	`review` text not null,
	primary key (user_id, cartoon_id),
	foreign key (user_id) references users(id),
	foreign key (cartoon_id) references cartoons(id)
);