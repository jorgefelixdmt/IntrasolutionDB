CREATE TABLE [dbo].[SC_USER_ROLE] (
    [SC_USER_ROLE_ID] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [SC_USER_ID]      NUMERIC (10)   NULL,
    [SC_ROLE_ID]      NUMERIC (10)   NULL,
    [IS_DELETED]      NUMERIC (1)    NULL,
    [CREATED]         DATETIME       NULL,
    [UPDATED]         DATETIME       NULL,
    [NAME]            NVARCHAR (100) NULL,
    [CODE]            NVARCHAR (100) NULL,
    [CREATED_BY]      NUMERIC (10)   NULL,
    [UPDATED_BY]      NUMERIC (10)   NULL,
    [OWNER_ID]        NUMERIC (10)   NULL,
    [COMPANY_ID]      NUMERIC (10)   NULL,
    [fb_uea_pe_id]    NUMERIC (10)   NULL,
    [por_defecto]     NUMERIC (1)    NULL,
    CONSTRAINT [PK_SC_USER_ROLE] PRIMARY KEY CLUSTERED ([SC_USER_ROLE_ID] ASC),
    CONSTRAINT [FK_USER_ROLE_SC_USER] FOREIGN KEY ([SC_USER_ID]) REFERENCES [dbo].[SC_USER] ([SC_USER_ID])
);


GO

/*      
****************************************************************************************************************************************
Nombre: dbo.[TR_SC_USER_ROLE_UEA_DEFECTO]
Fecha Creacion: 12/05/2020
Autor: Mauro Roque
Descripcion: TRIGGER QUE COLOCA POR DEFECTO LA UEA, AL SELECCIONAR EL CAMPO "POR DEFECTO"
Usado por: Modulo: USUARIOS / ROLES
tablas afectadas : SC_USER_ROLE ACTUALIZA
Uso: **************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
CREATE trigger [dbo].[TR_SC_USER_ROLE_UEA_DEFECTO]
on dbo.SC_USER_ROLE
after insert,update
as
begin


SET NOCOUNT ON

declare @por_defecto numeric(1,0)
declare @usuario_id numeric(10,0)
declare @id_generado numeric(10,0), @SC_USER_ROLE_ID int,@SC_USER_ID int

	

	set @por_defecto = (select por_defecto  from inserted)
	
	
	if(@por_defecto = 1)
	BEGIN

	 

	 DECLARE CurSC_userRol CURSOR FOR      
			 SELECT        
				SC_USER_ROLE_ID,
				SC_USER_ID
				  FROM inserted 
		   


				  OPEN CurSC_userRol      
		  FETCH NEXT FROM CurSC_userRol INTO @SC_USER_ROLE_ID ,@SC_USER_ID 
      
		  WHILE @@FETCH_STATUS = 0      
			BEGIN   

			update SC_USER_ROLE set por_defecto = NULL where SC_USER_ID = @SC_USER_ID and SC_USER_ROLE_ID <> @SC_USER_ROLE_ID

		
				FETCH NEXT FROM CurSC_userRol INTO @SC_USER_ROLE_ID ,@SC_USER_ID 
	 
			END	 

			  CLOSE CurSC_userRol      
		  DEALLOCATE CurSC_userRol    

	end
	
	exec pr_update_user_role
	
  SET NOCOUNT OFF		
	
end

GO

