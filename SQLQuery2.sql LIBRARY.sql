use [LIBRARY-21AI009];

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



insert into publisher values('mcgraw','hobo',108);
insert into publisher values('pearson','nagpur',911);
insert into publisher values('kaustubh','shetty',912);
select *from publisher;


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
insert into book_lending values('113','3458','100','2020-05-24','2020-05-28');
insert into book_lending values('113','3459','101','2020-06-10','2020-07-29');
select *from book_lending;


--1.query to get all the values of bid,pubname etc
select b.book_id,b.title,b.pub_name,ba.author_name,bc.branch_id,bc.no_of_copies from book b,book_authors ba,book_copies bc where b.book_id=bc.book_id and b.book_id=ba.book_id


select distinct card_no from book_lending b where (date_out between '01-jan-2020' and '30-jul-2020')group by card_no having count(*)>0;

--2.Retrive the details of publisher who published more than 3 books
select p.name from publisher p,book b where p.name=b.pub_name group by  p.name having count(*)>0;



--3.Retrive the details of publisher without any books
select p.name,p.address,p.phone from publisher p
where not exists(select pub_name from book where(p.name=pub_name))

--4.Retreive the details of authors who have authored more than 1 books
select author_name from book_authors
group by author_name having count(author_name)>1;

--5.retreive the details of books with more than 2 authors


--6.delete a book in BOOK table
delete from book where book_id='114'

--7.Create a view of all books and its number of copies that are currently available in the library
--begin transaction;
create view available as
( 
select book_id,sum(no_of_copies)-(select count(card_no)from book_lending
where b.book_id=book_id)as avail_copies from book_copies b group by book_id);
select *from available;
--commit transaction;


--8.GET the [particular of book with more than 3 authours
select b.book_id from book b,book_authors ba where b.book_id=ba.book_id group by b.book_id having count(ba.author_name)>0;

--9.Get the particulars of Library Branch which has Zero copies of book with id 112.
select branch_id from library_branch b where branch_id not in (select branch_id from book_copies where book_id='112');