# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


# run day task
bundle exec rake fight:start

# after users are created
insert into fighters (hp, wins, user_id, created_at, updated_at) VALUES (40, 0, 2, datetime('now'), datetime('now'));
insert into games (user1_id, user2_id, fighter1_id, fighter2_id, created_at, updated_at) VALUES (1, 2, 1, 2, datetime('now'), datetime('now'));

update users set name="Jacob" where id=1;
update users set name="Mark" where id=2;