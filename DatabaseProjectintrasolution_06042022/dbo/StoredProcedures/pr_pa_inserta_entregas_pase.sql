/*
Nombre: dbo.pr_pa_inserta_entregas_pase
Fecha Creación: 04/03/2022
Autor: Valky Salinas
Descripción: Inserta entregas a pase.
Llamado por: dbo.[pr_pa_Registra_incidentes_relacionados]
Usado por: Módulo de pases
Parámetro(s): @ids_entregas varchar(200), @pase_id numeric(10,0), @usuario_id numeric(10,0), @valida int 
Uso: exec pr_pa_inserta_entregas_pase '1,2',3,1

********************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ------------------------------------------------------------------------------------------------

*********************************************************************************************************************************************
*/

CREATE procedure [dbo].[pr_pa_inserta_entregas_pase]
@ids_entregas varchar(200), @pase_id numeric(10,0), @usuario_id numeric(10,0), @valida int        
as
set nocount on
Set dateformat dmy


DECLARE @entrega_id numeric(10,0), @flag int


IF (@valida = 0) -- Inserción
 BEGIN

	DECLARE CURSOR_REGS CURSOR FOR
		SELECT CAST(t.item AS numeric(10,0))
		FROM dbo.uf_Split(@ids_entregas,'-') t

	OPEN CURSOR_REGS

	FETCH NEXT FROM CURSOR_REGS INTO @entrega_id

	 WHILE @@Fetch_Status = 0   
	  BEGIN
		IF NOT EXISTS(SELECT * FROM pa_pase_entregas WHERE is_deleted = 0 AND pa_entrega_objetos_id = @entrega_id AND pa_pase_id = @pase_id)
		 BEGIN
			Insert into pa_pase_entregas
				(
				pa_pase_id,
				pa_entrega_objetos_id,
				created,
				created_by,
				updated,
				updated_by,
				owner_id,
				is_deleted
				)
			values
				(
				@pase_id,
				@entrega_id,
				getdate(),
				@usuario_id,
				getdate(),
				@usuario_id,
				@usuario_id,
				0
				)
		 END

		FETCH NEXT FROM CURSOR_REGS INTO @entrega_id

	 END

	CLOSE CURSOR_REGS
	DEALLOCATE CURSOR_REGS

 END
ELSE -- Validación
 BEGIN

	IF EXISTS (
				SELECT *
				FROM pa_pase_entregas
				WHERE
					is_deleted = 0 AND
					pa_pase_id = @pase_id AND
					pa_entrega_objetos_id IN (
												SELECT CAST(t.item AS numeric(10,0))
												FROM dbo.uf_Split(@ids_entregas,'-') t
											 )
			  )
	 BEGIN
		SET @flag = 1 
	 END

 END

 SELECT @flag as flag

GO

