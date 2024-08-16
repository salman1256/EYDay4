create database Day4Db
use Day4Db
create table Emps
(Id int primary key,
Fname nvarchar(50),
Lname nvarchar(50),
BasicSal float not null,
HRA as BasicSal*0.10 persisted,
TA as BasicSal*0.15 persisted,
DA as BasicSal*0.20)
insert into Emps  (Id,Fname,Lname,BasicSal)values(1,'Sam','Dicosta',50000)
insert into Emps  (Id,Fname,Lname,BasicSal)values(2,'Ruhee','Nazir',30000)
insert into Emps  (Id,Fname,Lname,BasicSal)values(3,'Danish','Wani',20000)
select * from Emps
--Create function Syntax
--create function schemaName.functionName(parameterlist)
--returns datatype
--as
--begin
-----Sql Statement
--return value;
--end

--create schema schemaName
create schema hr
create table hr.Emps
(Id int primary key,
Fname nvarchar(50),

BasicSal float not null
)
select * from hr.Emps
select * from dbo.Emps
select * from Emps

create function FullName( @fn nvarchar(50), @ln nvarchar(50))
returns nvarchar(101)
as
begin
return upper(@fn +' '+@ln)
end

select dbo.FullName('Raj','Kiran')  'Full Name'

select dbo.FullName('Rohit','Verma')  'Full Name'

select Fname,Lname,dbo.FullName(Fname,Lname) as 'Full Name',BasicSal,HRA,TA,DA from Emps

create function fnNetSalary(@basic float,@hra float,@ta float,@da float)
returns float
as
begin
return  @basic+@hra+@ta+@da
end

select dbo.fnNetSalary(1000,200,300,400)
select Fname,Lname,dbo.fnNetSalary(BasicSal,hra,ta,da) from Emps
select Fname,Lname,BasicSal,hra,ta,da,dbo.fnNetSalary(BasicSal,hra,ta,da) 'Net Salary' from Emps

--Table valued function
create function dbo.empDetails()
returns Table
as
 return (select Fname,Lname,BasicSal from dbo.Emps)

 ---
 select * from dbo.empDetails()
 ---------------------------------------------------