drop database quanlysinhvien;
create database QuanLySinhVien;
use QuanLySinhVien;
create table class(
classID int not null auto_increment primary key,
studentName varchar(30) not null,
address varchar(50),
status bit
);
create table student(
studenID int not null auto_increment primary key,
studentName varchar(30) not null,
address varchar(50),
phonne varchar(20),
status bit,
classID int not null,
foreign key(classID) references class(classID)
);
create table subject(
subID int not null auto_increment primary key,
subName varchar(30) not null,
credit tinyint not null default 1 check(credit >= 1),
status bit default 1
);
create table mark(
markID int not null auto_increment primary key,
subID int not null,
studentID int not null,
mark float default 0 check(mark between 0 and 100),
examtimes tinyint default 1,
unique(subID, studentID),
foreign key(subID) references subject (subID),
foreign key(studentID) references student(studenID)
);
insert into class
values (1, 'A1', '2008-12-20', 1);
insert into class
values (2, 'A2', '2008-12-22', 1);
insert into class
values (3, 'B3', current_date, 0);
INSERT INTO Student (StudentName, Address, Phonne, Status, ClassId)
VALUES ('Hung', 'Ha Noi', '0912113113', 1, 1);
INSERT INTO Student (StudentName, Address, Status, ClassId)
VALUES ('Hoa', 'Hai phong', 1, 1);
INSERT INTO Student (StudentName, Address, Phonne, Status, ClassId)
VALUES ('Manh', 'HCM', '0123123123', 0, 2);
INSERT INTO Subject
VALUES (1, 'CF', 5, 1),
       (2, 'C', 6, 1), 
       (3, 'HDJ', 5, 1),
       (4, 'RDBMS', 10, 1);
INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES (1, 1, 8, 1),
       (1, 2, 10, 2),
       (2, 1, 12, 1);       