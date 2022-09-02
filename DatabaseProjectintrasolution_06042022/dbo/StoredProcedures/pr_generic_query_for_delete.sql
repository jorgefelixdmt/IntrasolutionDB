
/*
autor: Carlos Cubas
Descriocion: este store permite invocar procedimientos para eliminar registros de grilla generica
parametros:
@storeprID ID o code de la tabla SC_STORE_PROCEDURE
@param1 id del registro a eliminar
@id_user id del usuario que invoca la funcion de eliminar
*/


CREATE proc [dbo].[pr_generic_query_for_delete]  
@storedprId nvarchar(100),  
@param1 nvarchar(15),
@id_user varchar(15)
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
  
 
EXEC ('EXEC ' + @storeprName + ' ' + @param1 + ', ' +@id_user)

GO

