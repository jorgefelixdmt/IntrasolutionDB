
/*      
****************************************************************************************************************************************
Nombre: dbo.pr_sc_role_insert
Fecha Creacion: 23/04/2020
Autor: Mauro Roque
Descripcion: store que inserta registro rol, asignado a un home de grafico estadistico
Llamado por: Clase Java
Usado por: Modulo: Rol por Home
Uso: pr_sc_role_insert 1,'CORP','Corpotativo','home corporativo general',1,1
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
create proc pr_sc_role_insert
@id_rol int,
@code varchar(200),
@name varchar(250),
@des varchar(400),
@home_id int,
@id_usuario int
as
begin

declare @id_rol_temp int

IF NOT EXISTS(SELECT SC_ROLE_iD FROM SC_ROLE WHERE SC_ROLE_iD = @id_rol)
		begin
		set @id_rol_temp = (select NEXT_SEQUENCE_ID from PM_SEQUENCE_TABLE where PM_SEQUENCE_TABLE_ID=3)


		INSERT INTO SC_ROLE 

		(SC_ROLE_iD,CODE,NAME,DESCRIPTION,fb_home_id,CREATED,CREATED_BY,UPDATED,UPDATED_BY,OWNER_ID,IS_DELETED)

				
		VALUES (@id_rol_temp,@code,@name,@des,@home_id,getdate(),@id_usuario,GETDATE(),@id_usuario,@id_usuario,0)

		update PM_SEQUENCE_TABLE
		set NEXT_SEQUENCE_ID= @id_rol_temp+1
		where PM_SEQUENCE_TABLE_ID=3
		 
		end 
ELSE
UPDATE SC_ROLE SET CODE = @code, NAME = @name ,  DESCRIPTION = @des , fb_home_id = @home_id , UPDATED = GETDATE() , UPDATED_BY = @id_usuario 

WHERE SC_ROLE_ID = @id_rol

select @id_rol_temp as id_pk
end

GO

