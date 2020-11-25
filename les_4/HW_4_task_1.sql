alter table friend_requests modify column status enum('requested', 'approved', 'unfriended', 'declined') default 'requested';

alter table users change column create_at created_at datetime default now();
