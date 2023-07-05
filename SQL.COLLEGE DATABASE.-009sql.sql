use[COLLEGE DATABASE009]
create table student
( 
usn varchar(10), 
sname varchar(15), 
address varchar(15), 
phone varchar(10),
gender varchar(6), 
primary key(usn) 
); 
create table semsec 
( 
ssid varchar(5), 
sem int, 
sec varchar(1), 
primary key(ssid) 
); 
create table class 
( 
usn varchar(10 ), 
ssid varchar(5), 
primary key(usn), 
foreign key(usn) references student(usn) on delete cascade, 
foreign key(ssid) references semsec(ssid) on delete cascade 
); 
create table subject 
( 
subcode varchar(7), 
title varchar(15), 
sem int, 
credits int, 
primary key(subcode)
);
create table iamarks 
( 
usn varchar(10), 
subcode varchar(7), 
ssid varchar(5), 
test1 int, 
test2 int, 
test3 int,
final_ai int,
primary key(usn,subcode,ssid),
foreign key(subcode) references subject(subcode), 
foreign key(ssid) references semsec(ssid)
);
drop table student;
drop table semsec;
drop table class;
drop table subject;
drop table iamarks;

insert into student values('4vp14cs001','namitha','udupi','7860054110','female');
insert into student values('4vp14cs021','mithun','virajpet','8762514991','male');
insert into student values('4vp14cs053','kshama','puttur','9000876123','female');
insert into student values('4vp14cs010','raghavendra',' karwar','8700967408','male');
insert into student values('4vp14cs025','sooraj','angalore','7773334422','male');
insert into student values('4vp14cs011','karthik','puttur','7789086125','male');


select * from student

insert into semsec values('a235','4','a');
insert into semsec values('a234','4','b');
insert into semsec values('a218','6','a');

select * from semsec

insert into class values('4vp14cs001','a235');
insert into class values('4vp14cs021','a235');
insert into class values('4vp14cs053','a234');
insert into class values('4vp14cs010','a234');
insert into class values('4vp14cs025','a234');
insert into class values('4vp14cs011','a218');

select * from class

insert into subject values('15cs41', 'algorithms', 4,4);
insert into subject values('15cs462','graph theory', 4,3);
 insert into subject values('15cs44',' processors', 4, 4);
 insert into subject values( '15cs45', 'oop with c++' ,4 ,4)
 insert into subject values ( '15cs64',' networks', 6, 4);
 
 select* from subject;

insert into iamarks values('4vp14cs001','15cs41','a235',19,18,20,null);
insert into iamarks values('4vp14cs001','15cs44','a235',15,18,19,null);
insert into iamarks values('4vp14cs021','15cs41','a235',15,17,14,null);
insert into iamarks values('4vp14cs021','15cs44','a235',17,16,12,null);
insert into iamarks values('4vp14cs053','15cs46','a234',13,17,15,null);
insert into iamarks values('4vp14cs053','15cs45','a234',13,17,19,null);
insert into iamarks values('4vp14id010','15cs46','a234',12,19,13,null);
insert into iamarks values('4vp14is011','15cs45','a234',19,17,16,null);
insert into iamarks values('4vp14is025','15cs45','a234',17,15,16,null);
insert into iamarks values('4vp13is011','15cs64','a218',17,18,19,null);
insert into iamarks values('4vp13cs011','15cs45','a218',10,11,9,null);


select *from iamarks;
update iamarks set final_ai=(test1+test2+test3);

--1. List all the student details studying in fourth semester ‘C’ section.
select s.usn, sname, gender, address
from student s, semsec sc ,class c
where s.usn=c.usn and c.ssid= sc.ssid and sc.sem = 4 and sc.sec ='a';

--2. Compute the total number of male and female students in each semester and in each section.
select sem, sec, gender, count(*) as count
from student s,semsec sc, class c
where s.usn = c.usn and sc.ssid = c.ssid
group by sem,sec,gender;

--3. Create a view of Test1 marks of student USN ‘4vp14is025’ in all subjects.
create view test1 as
select usn, test1, subcode
from iamarks
where usn='4vp14is025';

select *from test1;

--4. Calculate the FinalIA (average of best two test marks) and update the corresponding table for all students
create view average_finder as
select usn,subcode,greatest(test1,test2,test3) as highest, case
when test1<greatest(test1,test2,test3) and test1>least(test1,test2,test3) then test1
when test2<greatest(test1,test2,test3) and test2>least(test1,test2,test3) then test2
else test3
end as second_highest from iamarks;
update iamarks a set final_ia =
(select (highest+second_highest)/2 from average_finder
where a.usn =usn and a.subcode= subcode);

--5. Categorize students based on the following criterion:
If FinalIA = 17 to 20 then CAT = ‘Outstanding’
If FinalIA = 12 to 16 then CAT = ‘Average’
If FinalIA< 12 then CAT = ‘Weak’
Give these details only for 8 th semester A, B, and C section students.
select usn, subcode, case
when final_ia>=17 and final_ia<=20 then 'outstanding'
when final_ia>=12 and final_ia<=16 then 'average'
when final_ia<12 then 'weak'
end as category
from iamarks
where usn in
(SELECT USN FROM SEMSEC SC,CLASS C WHERE SC.SSID=C.SSID AND
SEM=4);