create database management_student;
use management_student;
create table school
(
id varchar(50) primary key,
name varchar(50) not null
);
​
create table class
(
id varchar(50) primary key,
name varchar(50) not null
);
​
create table subjects
(
id_subjects varchar(50) primary key,
name varchar(50)
);
​
create table mark
(
id_mark varchar(50) primary key,
name varchar(50) not null
);
​
alter table student add address varchar(50) not null;
alter table student add phone varchar(10) not null;
alter table student add id_class varchar(50) not null references class(id_class);
alter table student add id_school varchar(50) not null references school(id_school);
alter table student add status varchar(50) not null;
​
alter table subjects add credit int not null default 1 check(credit >= 1);
alter table subjects add status int default 1;
​
alter table class add startDate datetime not null;
alter table class add status int;
​
alter table student drop id_school;
​
alter table mark add id_student varchar(50) not null references student(id_student);
alter table mark add id_school varchar(50) not null references school(id_school);
alter table mark add examTimes int default 1;
alter table mark drop id_mark;
alter table mark add mark int default 0 not null check(mark >= 0 and mark <= 10);
​
use management_student;
​
alter table class change column id id int not null; 
alter table student change column id_student id_student int not null; 
alter table subjects change column id_subjects id_subjects int not null; 
alter table school change column id id int not null; 
​
insert into class values(1, 'thao', '2021-06-21', 1); 	
insert into class values(2, 'tien', '2021-06-21', 1);
insert into class values(3, 'beo', current_date, 0);
​
delete from class where id = 1;
delete from class where id = 3;
​
alter table student change column id_student id_student int not null;
insert into class values(1, 'a1', '2021-06-21', 1);
insert into class values(2, 'a2', '2021-06-21', 1);
insert into class values(3, 'a3', current_date(), 0);
​
alter table student change column id_class id_class int not null;
alter table mark change column id_student id_student int not null;
alter table mark change column id_school id_school int not null;
​
alter table student change column id_student id_student int not null auto_increment;
​
insert into student(name, address, phone, id_class, status) values('thao', 'hn', '0812661990', 1, '1');
insert into student(name, address, phone, id_class, status) values('tien bip', 'hn', '0812661990', 1, '1');
insert into student(name, address, phone, id_class, status) values('son beo', 'hn', '0812661990', 1, '1');
​
insert into subjects values(1, 'toan', 9, 1);
insert into subjects values(2, 'ly', 8, 1);
insert into subjects values(3, 'hoa', 7, 1);
insert into subjects values(4, 'anh', 9, 1);
​
alter table mark drop foreign key mark_ibfk_2;
alter table mark change column id_subject id_subject int not null, drop primary key;
alter table mark add constraint foreign key(id_school) references school(id);
alter table mark add id_subject int auto_increment primary key;
alter table mark add id_subject int not null;
alter table mark add foreign key (id_subject) references subjects(id_subjects);
insert into mark(id_student, id_subject, mark, examTimes) values(1, 1, 9, 1);
insert into mark(id_student, id_subject, mark, examTimes) values(2, 1, 9, 1);
insert into mark(id_student, id_subject, mark, examTimes) values(1, 2, 9, 1);
insert into mark(id_student, id_subject, mark, examTimes) values(3, 1, 9, 1);
alter table mark drop name;
alter table mark drop id_school;
alter table mark add constraint foreign key(id_student) references student(id_student);
​
select * from student;