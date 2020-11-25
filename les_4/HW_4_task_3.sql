insert into communities
(name)
values
('test_communities');

INSERT INTO users 
set
	firstname='Paul',
	lastname='vah',
	email='Paul_vah_vah@pp.vah',
	phone=12345678,
	gender='m',
	birthday='1985-10-15',
	hometown='Bagota',
	pass='1487c1cf7c24df739fc97460a2c791a2432df062';
	
select * from photos;

select * from photos limit 20;

select * from photos limit 20 offset 15;

select * from photos limit 28, 10;

select initiator_user_id , target_user_id , status from friend_requests;

select status, initiator_user_id , target_user_id from friend_requests order by status;

select status, initiator_user_id , target_user_id from friend_requests order by status desc;

select firstname, lastname, birthday from users order by firstname, lastname;

select now();

select 95-22;

select concat(lastname, ' ', firstname, ', ', birthday) as birthday_info from users;

select concat(lastname, ' ', substring(firstname, 1, 1), ', ', substring(birthday, 1, 4)) person from users;

select * from users where firstname = 'Elisa';

select lastname, firstname, hometown from users
	where hometown = 'Veumberg' or hometown  = 'Camilafurt';
	
select * from users where firstname != 'Elisa';

select lastname, firstname, birthday from users where birthday >= '1980-01-01';

select lastname, firstname, birthday from users where birthday between '1976-01-01' and '1980-01-01';

select lastname, firstname from users where firstname like '%sa%';

select lastname, firstname from users where firstname like '____';

select count(*) from communities;

select count(firstname) from users;

select count(distinct firstname) from users;

select hometown, count(*) from users group by hometown;

select firstname, count(*) from users group by firstname;

select firstname, count(*) from users group by firstname having count(*) >= 2;

update users 
set 
	firstname = 'Elisa'
where firstname = 'Myrl';

delete from communities where name = 'numquam';

delete from communities;

truncate table likes_comments;

show create table photos;