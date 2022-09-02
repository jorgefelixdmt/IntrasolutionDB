


/*      
Creado por: Valky Salinas 
Fecha Creacion: 11/05/2020
Descripcion: Envía un correo indicando el empleado al que se le ha registrado una enfermedad de COVID-19

pr_cv_aviso_enfermedad_riesgo 1

****************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(aaaa-mm-dd)       Autor                  Comentarios
------------------      -----------------      ------------------------------------------------------------------------------------

**************************************************************************************************************************************
*/

CREATE PROCEDURE [dbo].[pr_cv_aviso_enfermedad_riesgo]
	@cv_declaracion_enfermedades_id numeric(10,0)
As

set dateformat dmy
Declare @Codigo varchar(100), @tipo_reporte_nombre varchar(100), @titulo varchar(150), @descripcion varchar(1000), @asunto varchar(1000)
Declare @cuerpo varchar(1000), @PERFIL_SQL_NAME varchar(100), @cuerpo_email varchar(max), @CODIGO_EMAIL varchar(200), @empresa varchar(300)
Declare @destinatarios_email varchar(500), @activo varchar(1), @Url_App varchar(250), @fb_uea_pe_id numeric(10,0), @user_id numeric(10,0)

DECLARE @nombre_empleado varchar(500), @cv_declaracion_id numeric(10,0)

Select @PERFIL_SQL_NAME = value from pm_parameter where code = 'PERFIL_SQL_MAIL' 
select @empresa = value from PM_PARAMETER WHERE code = 'ENTERPRISE'
SELECT @Url_App = value from PM_PARAMETER where code= 'URL_EXT'
SET @CODIGO_EMAIL = 'CV_AVISO_ENFERMEDAD_RIESGO' 


SELECT
	@activo = Flag_Estado,
	@destinatarios_email = destinatario_email,
	@asunto = asunto,
	@cuerpo = cuerpo,
	@user_id = owner_id
FROM fb_mensaje_email 
WHERE codigo = @CODIGO_EMAIL


If @activo = '0' 
 BEGIN
	return
 END


SELECT 
	@cv_declaracion_id = d.cv_declaracion_id,
	@nombre_empleado = e.nombreCompleto,
	@fb_uea_pe_id = d.fb_uea_pe_id
FROM cv_declaracion d
	INNER JOIN fb_empleado e ON d.fb_empleado_id = e.fb_empleado_id
WHERE 
	d.cv_declaracion_id = (SELECT cv_declaracion_id FROM cv_declaracion_enfermedades WHERE cv_declaracion_enfermedades_id = @cv_declaracion_enfermedades_id)


SET @cuerpo = REPLACE(@cuerpo, '[EMPLEADO]', @nombre_empleado)



  --If @destinatarios_email <> ''
	--Begin
	 -- Se envia el email 
	  Exec pr_EMAIL_ENVIO_V2 '',@destinatarios_email,@asunto,'HTML',@cuerpo,@CODIGO_EMAIL,@fb_uea_pe_id,@user_id,@cv_declaracion_id
		/*EXEC  msdb.dbo.sp_send_dbmail     
			@profile_name = @PERFIL_SQL_NAME,    
			@recipients = @destinatarios_email,    
			@subject  = @asunto,    
			@body   =  @HTML,  
			@body_format ='HTML';*/
	--End

GO

