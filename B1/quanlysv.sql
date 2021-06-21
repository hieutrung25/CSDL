create database quanlysv;
use quanlysv;
create table class(
ClassID int not null auto_increment,
	ClassName varchar(60) not null,
	StartDate datetime not null,
	Status Bit,
	primary key (ClassID)
);
create table student(
	StudentID int auto_increment primary key,
	StudentName varchar(30) not null,
	Address varchar(50),
	Phone varchar(20),
	Status bit,
	ClassID int not null,
	foreign key (ClassID) references class(ClassID)
);
create table subject(
	SubID int auto_increment primary key,
    SubName varchar(30) not null,
    Credit tinyint not null default 1 check (Credit>=1),
    Status bit default 1
);
create table mark(
	MarkID int auto_increment primary key,
	SubID int not null,
	StudentID int not null,
	Mark float default 0 check (Mark >= 0 and Mark <= 100),
	ExamTimes tinyint default 1,
    unique (SubID, StudentID),
    foreign key (SubID) references subject (SubID),
    foreign key (StudentID) references student(StudentID)
);