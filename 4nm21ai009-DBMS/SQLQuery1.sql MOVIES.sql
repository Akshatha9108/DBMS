use [4nm21ai009-Actor Aksh]

Create table actor
(
act_id varchar(5),
act_name varchar(15),
act_gender varchar(6),
primary key(act_id)
);

create table director
(
dir_id varchar(5),
dir_name varchar(15),
dir_phone bigint,
primary key(dir_id)
);

create table movies
(mov_id varchar(5),
mov_title varchar(15),
mov_year int,
mov_lang varchar(10),
dir_id varchar(5),
primary key(mov_id),
foreign key(dir_id)references director(dir_id)on delete cascade
);

create table movie_cast
(
act_id varchar(5),
mov_id varchar(5),
role varchar(10),
primary key(act_id,mov_id),
foreign key(act_id)references actor(act_id)on delete cascade,
foreign key(mov_id)references movies(mov_id)on delete cascade
); 

create table rating
(
rat_id varchar(5),
mov_id varchar(5),
rev_stars int,
primary key(rat_id),
foreign key(mov_id)references movies(mov_id)on delete cascade
);

--1.List the titleds of all movies directed by 'hitchcock'.