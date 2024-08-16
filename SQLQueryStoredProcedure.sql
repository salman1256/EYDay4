use Day4Db
select * from Emps
--Stored Procedure
--A stored procedure is group of TSQL statements , it can take input parameters and return values from output parameters

--Syntax
--create proc schemaName.procedureName
-- parameters
--as
--begin  
--SQL Statements
---end 
----------------------------------------------------------
--begin {
-- end }
-------------------------------------------
create proc usp_saEmps
as
begin
select Id 'Employee Id', Fname 'First Name', Lname 'Last Name', BasicSal 'Basic Salary', HRA, TA, DA from Emps
end

--execute procedureName parameters
--exec procedureName parameters

exec usp_saEmps
--to drop the stored procedure
--drop proc procedureName

create proc usp_saEmpById
@id int
as
begin
select Id 'Employee Id', Fname 'First Name', Lname 'Last Name', BasicSal 'Basic Salary',
HRA, TA, DA from Emps where Id=@id
end

exec usp_saEmpById 4

exec usp_saEmpById 2

exec usp_saEmpById 3

exec usp_saEmpById
----------------------------------------------
alter proc usp_saEmpById
@id int =1
as
begin
select Id 'Employee Id', Fname 'First Name', Lname 'Last Name', BasicSal 'Basic Salary',
HRA, TA, DA from Emps where Id=@id
end

exec usp_saEmpById 2
exec usp_saEmpById 
exec usp_saEmpById 3
exec usp_saEmpById 56
--insert example using stroed procedure
create proc usp_insertEmp
@id int,
@fn nvarchar(50),
@ln nvarchar(50),
@bs float
as
begin
insert into Emps( Id,Fname,Lname,BasicSal) values (@id,@fn,@ln,@bs)
if @@ERROR!=0
print 'Error Occured while inserting record into table'
else
print 'Record inserted!!!'
end


exec usp_insertEmp 12,'Rohit','Sharma',45000


exec usp_insertEmp 2,'Ria','Waahi',45000

-----------------------------------------
create proc usp_updateEmp
@id int,
@fn nvarchar(50),
@ln nvarchar(50),
@bs float
as
begin
update Emps set Fname=@fn, Lname=@ln,BasicSal=@bs where Id=@id
if @@ERROR!=0
print 'Error Occured while updating the table'
else
print 'Record Updated!!!'
end


exec usp_updateEmp 12,'Rohit','Kumar',25000


exec usp_updateEmp 2,'Ria','Waahi',45000
------------------------------
create proc usp_deleteEmp
@id int
as
begin
delete from Emps where Id=@id
if @@ROWCOUNT !=0
print 'Record delete '


end

exec usp_deleteEmp 12
exec usp_deleteEmp 54
---------------------------------------------------------------------------------