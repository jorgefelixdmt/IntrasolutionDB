/*
Creado por: Valky Salinas
Fecha Creacion: 01/04/2020
Descripcion: Procedimiento general para el envio de correo, recibe parametros y los valida
			 para enviarlos a los destinatarios o a un correo de prueba. Agrega al log el ID del
			 registro que generó el envío de correo, el ID del módulo de origen (obtenido del
			 registro de configuración del correo) y el estado de envío (enviado o no enviado).
Parametros: @De_Email         - Email de Origen
			@A_Email          - Email de Destino
			@Asunto           - Asunto del correo
			@Cuerpo_Formato   - Formato del cuerpo del correo
			@Cuerpo           - Cuerpo del correo
			@CODIGO_EMAIL     - Código del email del correo
			@UEA	          - ID de la sede
			@user_id          - ID del usuario
			@origen_id        - ID del registro de origen
[dbo].[pr_EMAIL_ENVIO_V2] 'remitente@correo.com','destinatario@correo.com','Asunto','HTML','Cuerpo','Codigo',1,1,1

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------
16/04/2020             Valky Salinas      No envía correo de error si no hay correo de error en pm_parameter.

31/05/2020             Valky Salinas      Si el destinatario está vacío, no entra a la línea de envío de correo.

22/06/2020             Valky Salinas      Se mejoró el procedimiento para que maneje errores si mandar error.

09/10/2020             Valky Salinas      Se corrigió el uso de las sentencias BEGIN y COMMIT transaction.

11/11/2021             Valky Salinas      Se agregaron adjuntos.

*****************************************************************************************************************************

*/

CREATE procedure [dbo].[pr_EMAIL_ENVIO_V2]
	@De_Email varchar(max),
	@A_Email varchar(max),
	@Asunto varchar(1024),
	@Cuerpo_Formato varchar(max),
	@Cuerpo varchar(MAX),
	@Adjuntos varchar(max),
	@CODIGO_EMAIL varchar(max),
	@UEA	numeric(10,0),
	@user_id numeric(10,0),
	@origen_id numeric(10,0)

AS

	BEGIN tran

-- Declaro Variables
DECLARE @PERFIL_MAIL_SQL varchar(128), @Flag_Email_Test varchar(1),@A_Email2 varchar(max),@Copia_Email varchar(max), @Email_Test varchar(128)
DECLARE @Numero_de_Error numeric(10,0), @Mensaje_de_Error varchar(500), @Flag_Envio_Email varchar(1), @FLAG_EMAIL_ENVIO_GLOBAL varchar(1), @FLAG_EMAIL_FROM_DEFAULT varchar(1), @EMAIL_FROM_DEFAULT varchar(200),@FLAG_ESTADO varchar(1)
DECLARE @ID_LOG numeric(10,0), @tipo_mensaje varchar(10), @Responsable numeric(10,0)

DECLARE @Correo_error varchar(200), @Mensaje_Error varchar(600)
DECLARE @asunto_error varchar(200), @desc_correo varchar(600), @modulo_id numeric(10,0)

-- Recupera Valores de la Configuracion para el Envio de Emails
SELECT	@PERFIL_MAIL_SQL = value from PM_PARAMETER where code= 'PERFIL_SQL_MAIL'
SELECT	@Flag_Email_Test = value from PM_PARAMETER where code= 'CORREO_TEST'
SELECT	@Email_Test = value from PM_PARAMETER where code= 'CORREO_PRUEBA'
SELECT	@Flag_Envio_Email = value from PM_PARAMETER where code= 'FLAG_ENVIO_EMAIL'
SELECT @FLAG_ESTADO = IsNull(FLAG_ESTADO,''), @tipo_mensaje = tipo_mensaje, @desc_correo = descripcion, @modulo_id = fb_modulo_id from fb_mensaje_email where codigo=@CODIGO_EMAIL
SELECT @Correo_error = value FROM pm_parameter where code = 'EMAIL_ERROR_ENVIO_CORREO'

set @Mensaje_Error = ''



	IF(@FLAG_EMAIL_TEST = '1') -- Si es 1 email de prueba
		BEGIN
			SET @A_Email = @EMail_Test -- Setea el correo
		END

		-- INSERTA EN LOG
		INSERT INTO fb_envio_email_log
		(
			fb_uea_pe_id,
			sc_user_id,
			codigo_email,
			perfil,
			a_email,
			asunto,
			mensaje,
			fechahora,
			ESTADO, -- 0:POR ENVIAR, 1:ENVIADO
			numero_error,
			mensaje_error,
			created,
			created_by,
			updated,
			updated_by,
			owner_id,
			is_deleted,
			origen_id,
			modulo_id,
			enviado
		)
		values
		(
			@UEA,
			@user_id,
			@CODIGO_EMAIL,
			@PERFIL_MAIL_SQL,
			@A_Email,
			@Asunto,
			@Cuerpo,
			getdate(),
			0, -- ESTADO  0:POR ENVIAR, 1:ENVIADO
			@Numero_de_Error,
			@Mensaje_de_Error,
			getdate(),
			@user_id,
			getdate(),
			@user_id,
			@user_id,
			0,
			@origen_id,
			@modulo_id,
			0
		)

	SELECT @ID_LOG = @@IDENTITY

	IF @A_Email IS NULL OR @A_Email = ''
		BEGIN
		SET @Mensaje_error = @Mensaje_Error + 'No hay destinatarios, '
		END
	IF @Asunto IS NULL OR @Asunto = ''
		BEGIN
		SET @Mensaje_error = @Mensaje_Error + 'El asunto es nulo, '
		END
	IF @Cuerpo IS NULL OR @Cuerpo = ''
		BEGIN
		SET @Mensaje_error = @Mensaje_Error + 'El cuerpo es nulo, '
		END
	IF @Mensaje_error <> ''
		begin

		SET @asunto_error = 'Error de correo - ' + @CODIGO_EMAIL

		SET @Mensaje_de_Error = @Mensaje_error

		SET @Mensaje_error = 'Tipo:' + @tipo_mensaje + '<br>' +
								'Tipo de Correo: ' + @CODIGO_EMAIL + ' - ' + @desc_correo + '<br>' +
								'ID Origen: ' + CAST(@origen_id AS VARCHAR) + '<br>' +
								'<br>' +
								'Se han encontrado los siguientes errores:' + '<br>' +
								@Mensaje_error

		IF @Correo_error <> '' AND @Correo_error IS NOT NULL
			BEGIN
			EXEC  msdb.dbo.sp_send_dbmail   -- Envia el correo
						@profile_name	= @PERFIL_MAIL_SQL,
						@recipients		= @Correo_error,  
						@subject		= @asunto_error,  
						@body			= @Mensaje_error,  
						@body_format	= @Cuerpo_Formato;
			END
		END

		
		UPDATE fb_envio_email_log
		SET mensaje_error = @Mensaje_de_Error
		WHERE fb_envio_email_log_id = @ID_LOG

	COMMIT tran
	BEGIN TRY	
	  BEGIN TRAN					 
	  -- ENVIA EMAIL
	  IF @A_Email <> ''
		BEGIN
			EXEC  msdb.dbo.sp_send_dbmail   -- Envia el correo
							@profile_name		= @PERFIL_MAIL_SQL,
							@recipients			= @A_Email,  
							@subject			= @Asunto,  
							@body				= @Cuerpo,  
							@body_format		= @Cuerpo_Formato,
							@file_attachments   = @Adjuntos;

			-- ACTUALIZA LOG LUEGO DE ENVÍO
			UPDATE fb_envio_email_log
			SET enviado = 1
			WHERE fb_envio_email_log_id = @ID_LOG
		END
      COMMIT TRAN
     END TRY    
  
BEGIN CATCH  

	IF @@TRANCOUNT > 0
      ROLLBACK
	
	SELECT  
	@Numero_de_Error = ERROR_NUMBER(),
	@Mensaje_de_Error = ERROR_MESSAGE();
			
	-- ACTUALIZA LOG
	UPDATE fb_envio_email_log
	SET numero_error = @Numero_de_Error, mensaje_error = @Mensaje_de_Error -- ,ESTADO = 1 
	WHERE fb_envio_email_log_id = @ID_LOG 

END CATCH

GO

