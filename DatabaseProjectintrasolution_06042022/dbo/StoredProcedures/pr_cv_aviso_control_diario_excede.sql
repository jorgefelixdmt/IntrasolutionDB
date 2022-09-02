




/*      
Creado por: Valky Salinas 
Fecha Creacion: 11/05/2020
Descripcion: Envía un correo indicando el empleado al que se le ha registrado un control diario de COVID-19 que excede temperatura
             y/o pulsioximetría

pr_cv_aviso_control_diario_excede 1

****************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(aaaa-mm-dd)       Autor                  Comentarios
------------------      -----------------      ------------------------------------------------------------------------------------

**************************************************************************************************************************************
*/

CREATE PROCEDURE [dbo].[pr_cv_aviso_control_diario_excede]
	@cv_control_covid_diario_id numeric(10,0)
As

set dateformat dmy
Declare @Codigo varchar(100), @tipo_reporte_nombre varchar(100), @titulo varchar(150), @descripcion varchar(1000), @asunto varchar(1000)
Declare @cuerpo varchar(1000), @PERFIL_SQL_NAME varchar(100), @cuerpo_email varchar(max), @CODIGO_EMAIL varchar(200), @empresa varchar(300)
Declare @destinatarios_email varchar(500), @activo varchar(1), @Url_App varchar(250), @fb_uea_pe_id numeric(10,0), @user_id numeric(10,0)

DECLARE @nombre_empleado varchar(500), @fecha varchar(100), @medidas varchar(200), @temperatura numeric(1,0), @pulsioximetria numeric(1,0)

Select @PERFIL_SQL_NAME = value from pm_parameter where code = 'PERFIL_SQL_MAIL' 
select @empresa = value from PM_PARAMETER WHERE code = 'ENTERPRISE'
SELECT @Url_App = value from PM_PARAMETER where code= 'URL_EXT'
SET @CODIGO_EMAIL = 'CV_AVISO_CONTROL_DIARIO_EXCEDE' 


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


SET @medidas = ''

SELECT 
	@nombre_empleado = e.nombreCompleto,
	@fecha = CONVERT(VARCHAR, ccd.fecha_registro, 103),
	@fb_uea_pe_id = ccd.fb_uea_pe_id,
	@temperatura = IIF(temperatura > 37.5, 1, 0), 
	@pulsioximetria = IIF(pulsioximetria > 95, 1, 0)
FROM cv_control_covid_diario ccd
	INNER JOIN fb_empleado e ON ccd.fb_empleado_id = e.fb_empleado_id
WHERE 
	ccd.cv_control_covid_diario_id = @cv_control_covid_diario_id


If @temperatura = 1 OR @pulsioximetria = 1
 BEGIN
	IF @temperatura = 1
	 BEGIN
		SET @medidas = @medidas + 'temperatura'
		IF @pulsioximetria = 1
		 BEGIN
			SET @medidas = @medidas + ' y pulsioximetría'
		 END
	 END
	ELSE
	 BEGIN
		SET @medidas = @medidas + 'pulsioximetría'
	 END
	
	SET @cuerpo = REPLACE(@cuerpo, '[FECHA]', @fecha)
	SET @cuerpo = REPLACE(@cuerpo, '[EMPLEADO]', @nombre_empleado)
	SET @cuerpo = REPLACE(@cuerpo, '[MEDIDAS]', @medidas)

  --If @destinatarios_email <> ''
	--Begin
	 -- Se envia el email 
	  Exec pr_EMAIL_ENVIO_V2 '',@destinatarios_email,@asunto,'HTML',@cuerpo,@CODIGO_EMAIL,@fb_uea_pe_id,@user_id,@cv_control_covid_diario_id
		/*EXEC  msdb.dbo.sp_send_dbmail     
			@profile_name = @PERFIL_SQL_NAME,    
			@recipients = @destinatarios_email,    
			@subject  = @asunto,    
			@body   =  @HTML,  
			@body_format ='HTML';*/
	--End
 END

GO

