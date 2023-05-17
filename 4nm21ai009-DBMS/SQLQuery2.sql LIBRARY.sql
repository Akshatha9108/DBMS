create table publisher
(
name varchar(10),
address varchar(10),
phone int,
primary key(name)
);


create table book
(
book_id varchar(5),
title varchar(20),
pub_name varchar(10),
pub_year int,
primary key (book_id),
foreign key(pub_name) references publisher(name) on delete cascade
);

create table book_authors
(
book_id varchar(5),
author_name varchar(15),
primary key(book_id),
foreign key(book_id) references book(book_id) on delete cascade
);


create table library_branch
(
branch_id varchar(10),
branch_name varchar(10),
address varchar(15),
primary key(branch_id)
);


create table book_copies
(
book_id varchar(5),
branch_id varchar(10),
no_of_copies int,
primary key(book_id,branch_id),
foreign key(book_id) references book(book_id) on delete cascade ,
foreign key(branch_id) references library_branch(branch_id) on delete cascade 
);

create table book_lending
(
book_id varchar(5),
branch_id varchar(10),
card_no int,
date_out date,
date_due date,
primary key(book_id,branch_id,card_no),
foreign key(book_id) references book(book_id) on delete cascade ,
foreign key(branch_id) references library_branch(branch_id) on delete cascade
);

insert into publisher values('Rajesh','hobo',911);
insert into publisher values('mcgraw','hobo',108);
insert into publisher values('pearson','nagpur',911);
select *from publisher;

insert into book values('1539','Hugh Jazz','Rajesh',2016);
insert into book values('113','pythonBig','mcgraw',2010);
insert into book values('112','management','pearson',2006);
insert into book values('114','computer','pearson',2008);
select *from book;

insert into library_branch values('3456','WeLoveBall','Hobo');
insert into library_branch values('3457','BookLove','Usa');
select *from library_branch;

insert into book_authors values('1539','Rajesh');
insert into book_authors values('113','mcgraw');
insert into book_authors values('112','pearson');
insert into book_authors values('114','pearson');
select *from book_authors;

insert into book_copies values('113','3456',5);
insert into book_copies values('113','3457',5);
insert into book_copies values('114','3456',1);
select *from book_copies; 

insert into book_lending values('113','3456','99','2020-05-24','2020-05-28');
insert into book_lending values('113','3457','98','2020-06-10','2020-07-29');
select *from book_lending;


