---- ForeSpørgsler
use Company
--1a
select * from Employee
where Fname = 'Smith' or Lname = 'Smith';

--1b
select * from Employee
where Fname like '%smith' or
Lname like '%smith'

--2
select * from Employee 
where Lname like 'A%';

--3
select * from Employee
where Lname like '%1%';

--4a
select * from Employee
where HireDate < '01-01-1981';

--4b
select * from Employee
where DATEDIFF(year, Employee.HireDate, GETDATE()) > 5;


--4c 
select Lname as Efternavn, DATEDIFF(year, Employee.BirthDate, GETDATE())
as Age from Employee


--4d
select BirthDate from Employee


--5
select * from Employee where SuperEmpNo is null


--6
select * from Employee 
where Job = 'Clark' and
salary > 1000;

--7
select avg(salary) as AverageSalary
from Employee where Employee.DeptNo = 10;

--8
select distinct job from Employee

--9
select * from Employee, Department --48

--10
select * from Employee
join Department
on Employee.DeptNo = Department.Deptno;


--11
select count(Salary)
from Employee
where salary > 1500;


--12
select Fname, Lname
from Employee
order by Salary desc;


--13a
select * from Employee
where Employee.DeptNo in (select Department.Deptno 
							from Department
							where DName = 'sales');


--13b
select Employee.Empno, DeptNo
from Employee
where DeptNo in( select distinct DNumber from Location where Location = 'New York')


--13c
select distinct Employee.Empno, Fname, Department.Deptno, Department.DName, Location.Location
from Employee, Department, Location
where Employee.DeptNo = Department.Deptno and Department.Deptno = Location.DNumber and Location.Location = 'New York';


--14
SELECT b.Fname ,b.Lname
FROM Employee b 
WHERE NOT EXISTS (SELECT 'X' FROM Employee a WHERE a.SuperEmpNo = b.Empno);


--15
select e.Fname as Supervisee, s.Fname as Supervisor
from Employee e
left join Employee s
on e.SuperEmpNo = s.Empno;


--16
select avg(salary), Department.Deptno
from Employee, Department
where Department.Deptno = Employee.DeptNo
group by Department.Deptno


--17
select * from Department
where NumOfEmps = 0;


--18 not done
select Department.DName,Department.Manager, Employee.Fname
from Department, Employee
where Department.Manager = Employee.Empno;


--19
select Fname from Employee
where Fname = 'King' or Lname = 'King'
union
select Name from Dependent;
