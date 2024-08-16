--trigger
--create trigger [schemaName].triggerName
 -- on [schemaName].tableName
 --[With encryption]
 --[Typeoftrigger] For|instead of  [Action] Insert|update|delete 
 --as
 --sqlstatements
 --------------------------------------------
 drop database TriggerExDb
 create database TriggerExDb
 use TriggerExDb
 create table Emps
 (Id  int primary key,
 Fname nvarchar(50) not null,
 Lname nvarchar(50) not null,
 Salary float,
 Designation nvarchar(50),
 DOJ date)
 ---------------------------------------------
 create table Emps_LogInfo
 (
 LogID int identity,
 Id  int ,
 Fname nvarchar(50),
 Lname nvarchar(50),
 Salary float,
 Designation nvarchar(50),
 DOJ date,
 Log_Action nvarchar(50),
 Log_Action_Time datetime )
 -----------------------------------------------
 select * from Emps
 select * from Emps_LogInfo
 ---------------------------------------------------------
 create trigger trgAfterInsert
 on
 Emps
 after insert
 as
 declare @id int
 declare @fn nvarchar(50)
 declare @ln nvarchar(50)
 declare @desig nvarchar(50)
 declare @sal float
 declare @doj date

 select @id=Id,@fn=Fname, @ln=Lname, @desig=Designation, @doj=DOJ,@sal=Salary from inserted

 insert into Emps_LogInfo(Id,Fname,Lname,Salary,Designation,DOJ,Log_Action,Log_Action_Time)
 values(@id,@fn,@ln,@sal,@desig,@doj,'Record_Insert_Action',GETDATE())
 print 'After insert trigger says: Record inserted and action captured in Emps_LogInfo Table'

 -------------------------------------------------------------------------------------

 insert into Emps(Id,Fname,Lname,Designation,Salary,DOJ) values 
 (11,'Rohit','Kumar','Developer',76000.45,'12/12/2019')

  insert into Emps(Id,Fname,Lname,Designation,Salary,DOJ) values 
 (5,'Sam','Dicosta','Manager',57000.45,'08/09/2022')
 select * from Emps
 select * from Emps_LogInfo

  insert into Emps(Id,Fname,Lname,Designation,Salary,DOJ) values 
 (10,'Sunita','Verma','HR',45000.45,'08/02/2024')

 select * from Emps

 create trigger trgInstdDel
 on
 Emps
instead of delete
 as
 declare @id int
 declare @fn nvarchar(50)
 declare @ln nvarchar(50)
 declare @desig nvarchar(50)
 declare @sal float
 declare @doj date
 select @id=Id,@fn=Fname, @ln=Lname, @desig=Designation, @doj=DOJ,@sal=Salary from deleted
  if(@sal>=50000)
  begin
  raiserror('You can not delete this employee record',16,1)
  end
  else
  begin
 delete from Emps where Id=@id
 insert into Emps_LogInfo(Id,Fname,Lname,Salary,Designation,DOJ,Log_Action,Log_Action_Time)
 values(@id,@fn,@ln,@sal,@desig,@doj,'Record_Deleted_Action',GETDATE())
 if(@@ROWCOUNT=1)
 print 'Instead of trigger says: Record delted and action captured in Emps_LogInfo Table'
 end
 delete from Emps where Id=9
 select *  from Emps
 select * from Emps_LogInfo