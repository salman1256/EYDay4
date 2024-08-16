use Day4Db
create table Employees
(Id int primary key,
Fname nvarchar(50),
Lname nvarchar(50),
Salary float,
Designation nvarchar(50),
DOJ date default getdate())
insert into Employees values (1,'Sam','Dicosta',99000,'Manager','12/20/2021')
insert into Employees values (2,'Ruhee','Nazir',78000,'Developer','02/20/2023')
insert into Employees values (3,'Vinit','Garg',99000,'Manager','12/08/2021')
insert into Employees values (4,'Roma','Mishra',98000,'TL','10/03/2021')
insert into Employees (Id,Fname,Lname,Designation,Salary) values (12,'Ravi','Kumar','Developer',77500)

insert into Employees values (5,'Sudhir','Thangrajan',68000,'HR','12/20/2021')
insert into Employees values (6,'Manoj','Vats',88000,'Developer','09/09/2023')
insert into Employees values (7,'Danish','Waani',76000,'Tester','12/20/2021')
insert into Employees values (8,'Karan','Wahi',45000,'HR','06/09/2022')
insert into Employees (Id,Fname,Lname,Designation,Salary) values (14,'Nitin','Arya','Developer',82000)

select * from Employees
create proc usp_DesignationCount
@desig nvarchar(50),
@noe int output
as
select @noe=count(Id) from Employees where Designation=@desig
--------------------------
declare @empCount int
exec usp_DesignationCount 'Tester',@empCount output
print @empCount 
---------------------------
declare @empCount int
exec usp_DesignationCount 'Developer',@empCount output
print @empCount 
---------------------------
declare @empCount int
exec usp_DesignationCount 'Developer',@empCount output
print 'As Number of Employee '+ convert(nvarchar(10),@empCount) 
----------------------------------------------------------
execute sp_helptext usp_DesignationCount

alter proc usp_DesignationCount  

@desig nvarchar(50),  
@noe int output  
with encryption
as  
select @noe=count(Id) from Employees where Designation=@desig

execute sp_helptext usp_DesignationCount
----------------------------------------

create proc usp_nestedPro
@desig nvarchar(50)
as
begin
declare @empCount int
exec usp_DesignationCount @desig,@empCount output
print 'Number of Employee working as  '+@desig +'-->'+ convert(nvarchar(10),@empCount)
end
----------------------------------------------------------------
exec usp_nestedPro 'HR'
exec usp_nestedPro 'Tester'
exec usp_nestedPro 'Developer'