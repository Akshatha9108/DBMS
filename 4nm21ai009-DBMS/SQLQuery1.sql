Create table persons
(
 personid int,
 lastname varchar(255),
 firstname varchar(255),
 address varchar(255),
 city varchar(255)
 );

 --droping table
 drop table persons;

 --altering table to add columns
 alter table persons add phone_no varchar(10);
  --altering table to drop columns
   alter table persons drop column phone_no;

   --change column datatype
   alter table persons alter column personid varchar(10);

   alter table persons add primary key;

                  