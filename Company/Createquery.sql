USE master;
GO

ALTER DATABASE Company SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

Drop database Company
go


create database Company
go

use Company


IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Department')
BEGIN
    alter table Department
	drop constraint if exists dept_manager_fk;
END


IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Dependent')
BEGIN
    alter table Dependent
	drop constraint if exists dpt_emp_fk
END



IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'WorksOn')
BEGIN
    alter table WorksOn
	drop constraint if exists work_emp_fk
END



IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Project')
BEGIN
    alter table Project
	drop constraint if exists dnum_pro_fk
END



IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Location')
BEGIN
    alter table Location
	drop constraint if exists dnum_loc_fk
END



IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Dependent')
BEGIN
    alter table WorksOn
	drop constraint if exists work_pro_fk
END




--select * from INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS

drop table if exists Employee
go

drop table if exists Department
go

drop table if exists Project
go

drop table if exists WorksOn
go

drop table if exists Dependent
go

drop table if exists Location
go


CREATE TABLE Department(
    Deptno INT CONSTRAINT dept_deptno_pk PRIMARY KEY,
    DName VARCHAR(255) UNIQUE,
    --ManEmnpNo INT FOREIGN KEY REFERENCES Employee(Empno) UNIQUE NOT NULL,
    --ManStartDate DATE
);
go

go
CREATE TABLE Employee(
    Empno INT CONSTRAINT emp_empno_pk PRIMARY KEY,
    Fname VARCHAR(50) NOT NULL,
    Minit CHAR(1) NOT NULL,
    Lname VARCHAR(50) NOT NULL,
    Gender CHAR(1) CONSTRAINT EMP_GENDER_CK CHECK (Gender = 'M' or Gender = 'F'),
    SuperEmpNo INT CONSTRAINT emp_superempnp_ck FOREIGN KEY REFERENCES Employee(Empno),
    BirthDate DATE,
    HireDate DATE,
    Job VARCHAR(25),
    Trainee BIT,
    Salary DECIMAl NOT NULL CHECK (Salary < 30000),
    Comm DECIMAL,
    DeptNo INT CONSTRAINT emp_supervisor_fk FOREIGN KEY REFERENCES Department(Deptno),
);
go

INSERT INTO Department VALUES(10, 'ACCOUNTING')
INSERT INTO Department VALUES(20, 'RESEARCH')
INSERT INTO Department VALUES(30, 'SALES')
INSERT INTO Department VALUES(40, 'OPERATIONS')


--                       Primary       Fname      Minit      Lname      Gender    SuperEmpNo     BirthDate          HireDate       Job       Trainee Salary     Com     DeptNo
INSERT INTO Employee VALUES (7839,     'James',    'L',     'King',       'M',       NULL,     '1942-12-31',     '1972-11-30',    'President', 0,    5000,      NULL,     10)
INSERT INTO Employee VALUES (7566,     'Jack',     'K',     'Jones',      'M',       7839,     '1942-12-31',     '1972-11-30',    'Manager',   0,    2975,      NULL,     20)
INSERT INTO Employee VALUES (7698,     'Horace',   'O',     'Blake',      'M',       7839,     '1972-11-30',     '1993-10-28',    'Manager',   0,    2850,      NULL,     30)
INSERT INTO Employee VALUES (7782,     'Terry',    'A',     'Clerk',      'M',       7839,     '1982-10-12',     '2010-09-26',    'Salesman',  1,    2450,      NULL,     10)
INSERT INTO Employee VALUES (7499,     'Dave',     'J',     'Allen',      'M',       7698,     '1949-09-13',     '1983-08-25',    'Developer', 0,    1600,      300,      30)
INSERT INTO Employee VALUES (7521,     'Samuel',   'D',     'Ward',       'M',       7698,     '1934-08-14',     '1985-07-01',    'Salesman',  0,    1250,      500,      30)
INSERT INTO Employee VALUES (7654,     'Jeans',    'J',     'Martin',     'F',       7698,     '1978-07-23',     '1995-06-04',    'Salesman',  1,    1250,      1400,     30)
INSERT INTO Employee VALUES (7844,     'Tina',     'E',     'Turner',     'F',       7698,     '1978-05-11',     '1992-04-12',    'Salesman',  1,    3000,      0,        30)
INSERT INTO Employee VALUES (7934,     'Marcus',   'G',     'Miller',     'M',       7782,     '1981-03-09',     '2003-02-12',    'Clerk',     1,    1300,      NULL,     10)
INSERT INTO Employee VALUES (7788,     'Taylor',   'R',     'Scott',      'M',       7566,     '1956-06-21',     '1989-05-24',    'Analyst',   0,    2975,      NULL,     20)
INSERT INTO Employee VALUES (7876,     'John',     'R',     'Ford',       'M',       7566,     '1956-06-21',     '1989-05-24',    'Analyst',   0,    2975,      NULL,     20)
INSERT INTO Employee VALUES (7369,     'Harald',   'H',     'Smith',      'M',       7934,     '1966-02-23',     '2004-01-27',    'Clerk',     1,    800,       NULL,     20)
go

go
alter table Department
add Manager int,
Startdate datetime,
NumOfEmps int;
go

go
alter table Department
add constraint dept_manager_fk foreign key (Manager) references Employee(Empno);
go

go
Update Department
set Manager = 7499, Startdate = getDate()
where Deptno = 10;
go


go
Update Department
set Manager = 7788, Startdate = getDate()
where Deptno = 20;
go

go
Update Department
set Manager = 7566, Startdate = getDate()
where Deptno = 30;
go

go
Update Department
set Manager = 7698, Startdate = getDate()
where Deptno = 40;
go

go
update Department set NumOfEmps = 
 (select count(*) from Employee 
 where Employee.DeptNo = Department.Deptno);
 go


 select * from Department



 go
 create table Project(
	PNum int constraint pro_num_pk primary key,
	PName varchar(60) unique,
	DNumber int constraint dnum_pro_fk foreign key references Department(DeptNo),
	Location varchar(50)
 );
 go

 go
create table Location(
	DNumber int constraint dnum_loc_fk foreign key references Department(DeptNo),
	Location varchar(50)
);
go

go
create table WorksOn(
	EmpNo int constraint work_emp_fk foreign key references Employee(EmpNo),
	PNum int constraint work_pro_fk foreign key references Project(PNum),
	Hours decimal 

);
go

go
create table Dependent(
	DptEmpNo int not null,
	Name varchar(50) not null,
	Relation varchar(50),
	Gender char(1) check (Gender = 'F' or Gender = 'M'),
	BDate datetime

);


alter table Dependent
add constraint dpt_emp_fk foreign key (DptEmpNo)
references Employee(EmpNo),
primary key(DptEmpNo, Name);
go


insert into Location values(10, 'New York');
insert into Location values(10, 'Houston');
insert into Location values(20, 'Dallas');
insert into Location values(30, 'Chicago');
insert into Location values(30, 'Tafford');
insert into Location values(30, 'New York');
insert into Location values(40, 'Boston');


insert into Project values(1, 'PRODUCTX', 10, 'NEW YORK');
insert into Project values(2, 'PRODUCTY', 20, 'HOUSTON');
insert into Project values(3, 'PRODUCTZ', 30, 'DALLAS');
insert into Project values(10,'COMPUTERIZATION', 30, 'CHICAGO');
insert into Project values(20,'REORGANIZATION', 30, 'STAFFORD');
insert into Project values(30, 'NEWBENEFITS', 30, 'NEW YORK');


 
insert into WorksOn values(7499, 1, 12);
insert into WorksOn values(7934, 2, 10);
insert into WorksOn values(7876, 10, 5);
insert into WorksOn values(7844, 2, 23);
insert into WorksOn values(7782, 30, 58);
insert into WorksOn values(7934, 3, 6);



insert into Dependent values(7839, 'Prince',   'son',       'M', '1987-11-01 13:04:35');
insert into Dependent values(7839, 'Princess', 'daughter',  'F', '1987-11-01 09:15:54');
insert into Dependent values(7839, 'Queen',    'wife',      'F', '1965-12-24 23:37:05');
insert into Dependent values(7788, 'Sammy',    'father',    'M', '1932-05-21 00:45:19');





