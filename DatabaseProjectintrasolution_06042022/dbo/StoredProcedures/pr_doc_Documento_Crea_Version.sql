/*

CREA NUEVA VERSION DEL DOCUMENTO VERIFICANDO SI NECESITA APROBACIONES

Debe ejecutarse despues que se crea un documento del tipo VERSION

@flag_version : P=Nueva Version en Proceso, D=Documento Vigente, V=Version Anterior

estado_revision : P=Pendiente  A=Aprobado    R=Rechazado

*/

CREATE proc [dbo].[pr_doc_Documento_Crea_Version]
	@doc_documento_id numeric(10,0),       --- ID DEL DOC DE NUEVA VERSION
	@doc_documento_origen_id numeric(10,0), --- ID DEL DOC ANTERIOR QUE SERA REEMPLAZADO
	@fb_empleado_id numeric(10,0) -- ID del Empleado
As

	Declare @numero_revision numeric(10,0), @doc_folder_id numeric(10,0) 
	Declare @cantidad_aprobadores int, @version varchar(3)
	

	SET @numero_revision = 0

	SELECT	@numero_revision = numero_revision, 
			@version = version,
			@doc_folder_id = doc_folder_id 
		FROM doc_documento 
		WHERE doc_documento_id = @doc_documento_origen_id

	SET @version = right('00'+ convert(varchar,convert(int,@version)+1),3) 

	SELECT @cantidad_aprobadores = count(*) 
		FROM doc_documento_aprobador
		WHERE doc_documento_id = @doc_documento_origen_id
			AND is_deleted = 0



/* SI EL DOCUMENTO NO TIENE APROBADORES CREA LA VERSION */
	IF (@cantidad_aprobadores = 0)
		BEGIN
			-- Actualiza el documento anterior como version y lo relaciona al nuevo ID del Doc
			UPDATE 	doc_documento 
				SET   flag_version = 'V' ,
					  doc_documento_origen_id = @doc_documento_id
				WHERE doc_documento_origen_id = @doc_documento_origen_id
            
			-- Actualiza el nuevo documento como Vigente y lo relaciona al mismo ID  
			UPDATE doc_documento 
				set flag_version = 'D',
				estado_revision = 'A',
				numero_revision = @numero_revision,
			--  cantidad_aprobadores = @cantidad_aprobadores,	
				version = @version, 
				doc_documento_origen_id = @doc_documento_id 
			WHERE doc_documento_id = @doc_documento_id

		END
	 ELSE
		-- SI EL DOCUMENTO TIENE APROBADORES
		BEGIN
			-- Actualiza el documento como Nueva Version en Proceso 
			UPDATE doc_documento 
				set flag_version = 'P',
				estado_revision = 'P',
				version = @version, 
			--  cantidad_aprobadores = @cantidad_aprobadores,					
				numero_revision = @numero_revision + 1,
				doc_documento_origen_id = @doc_documento_origen_id 
			WHERE doc_documento_id = @doc_documento_id

/*
			if (@numero_revision = 0)
				UPDATE doc_documento 
				  fecha_inicio_aprobacion = getdate()					
				WHERE doc_documento_id = @doc_documento_id
*/
					
			-- Crea los registros para las aprobaciones 
			INSERT INTO doc_documento_revision
				(
					doc_documento_id,
					fb_empleado_id,
					estado_revision,
					numero_revision,
					fecha_solicitud,
					created,
					created_by,
					updated,
					updated_by,
					owner_id,
					is_deleted
				)
			SELECT 
					doc_documento_id,
					fb_empleado_id,
					'P',
					@numero_revision + 1,
					getdate(),
					getdate(),
					fb_empleado_id,
					getdate(),
					@fb_empleado_id,
					@fb_empleado_id,
					0
				FROM doc_documento_aprobador
				WHERE doc_documento_id = @doc_documento_origen_id 
					AND is_deleted = 0
		END

GO

