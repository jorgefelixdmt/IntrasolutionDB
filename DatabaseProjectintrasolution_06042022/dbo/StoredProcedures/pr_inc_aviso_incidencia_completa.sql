/*      

****************************************************************************************************************************************
Nombre: dbo.pr_inc_aviso_incidencia_completa
Fecha Creacion: 11/11/2021
Autor: Valky Salinas
Descripcion: Envía correo de aviso al cambiar una incidencia a completada
Llamado por: ---
Usado por: Modulo: Incidencias
Parametros:  @inc_incidencia_id numeric(10,0)

pr_inc_aviso_registro_incidencia 1
****************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(aaaa-mm-dd)       Autor                  Comentarios
------------------      -----------------      ------------------------------------------------------------------

**************************************************************************************************************************************
*/
CREATE PROCEDURE [dbo].[pr_inc_aviso_incidencia_completa] --4,1
	@inc_incidencia_id numeric(10,0)
As

set dateformat dmy
Declare @asunto varchar(1000),@destinatarios_email varchar(600),@PERFIL_SQL_NAME varchar(100)
Declare @cuerpo_email varchar(max), @CODIGO_EMAIL varchar(200)
Declare @fb_uea_pe_id numeric(10,0), @user_id numeric(10,0)
Declare @tabla varchar(max), @correo_proyecto varchar(500), @correo_responsable varchar(100), @correo_reportante varchar(100), @cliente varchar(200)
Declare @Url_App varchar(250),@App_Name varchar(250), @Arroba varchar(100),@Nombre_Reporte VARCHAR(150), @activo varchar(1), @producto varchar(100)
Declare @Url_App_war varchar(50), @cod_jira varchar(200)

DECLARE @ticket varchar(100), @proyecto varchar(200), @fecha varchar(50), @reportante varchar(200), @descripcion varchar(500)
DECLARE @severidad varchar(50), @lugar_error varchar(500), @adjunto varchar(200), @titulo varchar(500)

SET @CODIGO_EMAIL = 'INC_AVISO_INCIDENCIA_COMPLETA'

Select @PERFIL_SQL_NAME = value from pm_parameter where code = 'PERFIL_SQL_MAIL'  
-- Recupera Valores de la Configuracion para el Envio de Emails  




select 
	@activo = Flag_Estado, 
	@destinatarios_email = destinatario_email, 
	@asunto = asunto, 
	@cuerpo_email = cuerpo
from fb_mensaje_email where codigo = @CODIGO_EMAIL

SELECT @fb_uea_pe_id = 1, @user_id = created_by 
FROM inc_incidencia
WHERE inc_incidencia_id = @inc_incidencia_id

If @activo = '0' 
	Begin
		return
	End


SELECT 
	@ticket = ISNULL(i.codigo_ticket, ''),
	@proyecto = ISNULL(p.nombre, ''),
	@fecha = CONVERT(VARCHAR, i.fecha, 103) + ' ' + i.hora,
	@reportante = ISNULL(i.reportado_por, ''),
	@descripcion = ISNULL(i.descripcion_incidente, ''),
	@titulo = ISNULL(i.titulo_incidencia, ''),
	@severidad = ISNULL(ni.nombre, ''),
	@lugar_error = ISNULL(i.informacion_adicional, ''),
	@adjunto = ISNULL(REPLACE(i.archivo_pasos_error,'C:\fakepath\',''),''),
	@correo_proyecto = ISNULL(p.email_cliente_incidente, ''),
	@correo_responsable = ISNULL(e.email, ''),
	@correo_reportante = ISNULL(u.EMAIL, ''),
	@cliente = ISNULL(c.nombre, ''),
	@producto = ISNULL(pr.nombre, ''),
	@cod_jira = i.codigo_jira
FROM inc_incidencia i
	LEFT JOIN pry_proyecto p ON p.pry_proyecto_id = i.pry_proyecto_id
	LEFT JOIN inc_nivel_incidencia ni ON ni.inc_nivel_incidencia_id = i.inc_nivel_incidencia_id
	LEFT JOIN fb_empleado e ON e.fb_empleado_id = p.fb_responsable_id
	LEFT JOIN fb_cliente c ON c.fb_cliente_id = i.fb_cliente_id
	LEFT JOIN prd_producto pr ON pr.prd_producto_id = p.prd_producto_id
	LEFT JOIN SC_USER u ON u.SC_USER_ID = i.owner_id
WHERE i.inc_incidencia_id = @inc_incidencia_id
 

-- Obtención de responsables de elaborar pase
DECLARE @emails VARCHAR(8000) 

SELECT 
	@emails = COALESCE(@emails + ';', '') + ISNULL(er.email,'') + ';' + ISNULL(ea.email,'') + ';' + rpu.cadena_email
FROM fb_rol_proceso rp
	INNER JOIN fb_rol_proceso_usuario rpu ON rpu.fb_rol_proceso_id = rp.fb_rol_proceso_id
	INNER JOIN fb_empleado er ON er.fb_empleado_id = rpu.fb_empleado_id_titular
	LEFT JOIN fb_empleado ea ON ea.fb_empleado_id = rpu.fb_empleado_id_alterno
WHERE 
	rp.is_deleted = 0 AND
	rpu.is_deleted = 0 AND
	rp.codigo LIKE 'RESPONSABLE_ELABORAR_PASE'

SET @destinatarios_email = @destinatarios_email + ';' + @emails


-- Obtención de adjuntos
DECLARE @attachments VARCHAR(8000), @path_upload varchar(500)

SELECT @path_upload = VALUE 
FROM pm_parameter
WHERE CODE = 'PATH_UPLOAD'

SELECT 
	@attachments = COALESCE(@attachments + ';', '') + @path_upload + archivo
FROM inc_incidente_archivo
WHERE
	is_deleted = 0 AND
	inc_incidencia_id = @inc_incidencia_id


-- Obtención de observaciones
DECLARE @observaciones varchar(500)

SELECT TOP 1 @observaciones = observacion
FROM inc_incidencia_seguimiento
WHERE 
	is_deleted = 0 AND
	inc_estado_incidencia_id = 4 AND -- Solución Completada
	inc_incidencia_id = @inc_incidencia_id
ORDER BY created DESC


SET @asunto = REPLACE(@asunto,'[CODIGO]',@ticket)
SET @asunto = REPLACE(@asunto,'[DESCRIPCION]',@titulo)
SET @asunto = REPLACE(@asunto,'[PRODUCTO]',@producto)


-- Obtiene URL JIRA
DECLARE @base_url varchar(200)

SELECT @base_url = propertyvalue 
FROM DTECH_185.jira_db.dbo.propertystring 
WHERE 
	ID IN (
			SELECT ID 
			FROM DTECH_185.jira_db.dbo.propertyentry 
			WHERE property_key LIKE '%baseurl%'
			)

Set @tabla = 
	N'
			<table class="demo">
				<tr><td class="fondo" width="20%">Ticket:</td>    
					<td>' + @ticket + '</td>    
				</tr> 
				<tr><td class="fondo">Cliente:</td>    
					<td>' + @cliente + '</td>    
				</tr>     
				<tr><td class="fondo">Proyecto:</td>    
					<td>' + @proyecto + '</td>    
				</tr>    
				<tr><td class="fondo">Fecha y Hora de Reporte:</td>    
					<td>' + @fecha + '</td>
				</tr>    
				<tr>    
					<td class="fondo">Reportado Por:</td>    
					<td>' + @reportante  + '</td> 
				</tr>    
				<tr>    
					<td class="fondo">Descripción del Incidente:</td>    
					<td>' + @descripcion + '</td>
				</tr>
				<tr>
					<td class="fondo">Jira:</td>
					<td>' +  @cod_jira + '</td>
				</tr> 
				<tr>
					<td class="fondo">URL Jira:</td>
					<td>' +  @base_url + '/browse/' + @cod_jira + '</td>
				</tr> 
				<tr>
					<td class="fondo">Observaciones:</td>
					<td>' +  @observaciones + '</td>
				</tr>       
			</table>'


SET @cuerpo_email = REPLACE(@cuerpo_email,'[TABLA_DATOS]',@tabla)


SET @cuerpo_email = '<html>
<head>' + '<style type="text/css">
	 html {
    font-family: sans-serif;
	font-size:13px;
    -ms-text-size-adjust: 100%;
    -webkit-text-size-adjust: 100%;
  }
	.demo {
		width:100%;
		
		border:1px solid #C0C0C0;
		border-collapse:collapse;
		padding:6px;
	}
	.demo th {
		border:1px solid #C0C0C0;
		padding:6px;
		background:#F0F0F0;
	}
	.demo td {
		border:1px solid #C0C0C0;
		padding:6px 12px;

	}
	.fondo {
		background-color:#F0F0F0;
		font-weight:600;
	}
	.p {
		font-family: sans-serif;
		font-size:15px;
	}
	.footer {
		font-family: sans-serif;
		font-size:13px;
		font-weight:600;
	}
	.header {
		font-family: sans-serif;
		font-size:13px;
	}
</style>' + '</head> <body>' + @cuerpo_email + '</body>    
</html>'
  
  --If @destinatarios_email <> ''
	--Begin
	 -- Se envia el email     
	 --Exec pr_EMAIL_ENVIO '',@destinatarios_email,@asunto,'HTML',@HTML,@CODIGO_EMAIL,'',@user_id 
	 --select '',@destinatarios_email,@asunto,'HTML',@cuerpo_email,@CODIGO_EMAIL,@fb_uea_pe_id,@user_id,@inc_incidencia_id  
	 Exec pr_EMAIL_ENVIO_V2 '',@destinatarios_email,@asunto,'HTML',@cuerpo_email,@attachments,@CODIGO_EMAIL,@fb_uea_pe_id,@user_id,@inc_incidencia_id   
		--EXEC  msdb.dbo.sp_send_dbmail     
		--	@profile_name = @PERFIL_SQL_NAME,    
		--	@recipients = @destinatarios_email,    
		--	@subject  = @asunto,    
		--	@body   =  @HTML,  
		--	@body_format ='HTML';
	--End

GO

