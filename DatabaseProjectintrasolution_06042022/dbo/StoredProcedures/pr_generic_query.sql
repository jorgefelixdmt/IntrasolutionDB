CREATE proc [dbo].[pr_generic_query]  
@storedprId nvarchar(100),  
@param1 nvarchar(1000)  
as  
declare @storeprName nvarchar(200) 

if(ISNUMERIC(@storedprId)=1)
begin
select @storeprName = NAME from SC_STORED_PROCEDURE where SC_STORED_PROCEDURE_ID = @storedprId and is_deleted <> 1
end
else
begin
select top 1 @storeprName = NAME from SC_STORED_PROCEDURE where CODE = @storedprId and is_deleted <> 1
end 
  
 
EXEC ('EXEC ' + @storeprName + ' ' + @param1)  
 --select @param1 + '. Acción completada satisfactoriamente' as aego, 'Test 1' as test1, 'Test 2' as test2  

GO

