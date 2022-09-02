/*      

****************************************************************************************************************************************
Nombre: dbo.pr_inc_aviso_registro_incidencia
Fecha Creacion: 19/06/2020
Autor: Valky Salinas
Descripcion: Envía correo de aviso al registrar un incidente
Llamado por: ---
Usado por: Modulo: Incidencias
Parametros:  @inc_incidencia_id numeric(10,0)

pr_inc_aviso_registro_incidencia 1
****************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(aaaa-mm-dd)       Autor                  Comentarios
------------------      -----------------      ------------------------------------------------------------------
23/06/2020              Valky Salinas          Se hicieron mejoras al estilos y se cambiaron destinatarios.

25/06/2020              Valky Salinas          Se agregó el nombre del producto al asunto.

17/10/2021				MPE						Se agrega Ambito y Tipo a los datos y los destinatarios en base al estado

**************************************************************************************************************************************
*/
CREATE PROCEDURE [dbo].[pr_inc_aviso_registro_incidencia_V2] --4,1
	@inc_incidencia_id numeric(10,0)
As

set dateformat dmy
Declare @asunto varchar(1000),@destinatarios_email varchar(600),@PERFIL_SQL_NAME varchar(100)
Declare @cuerpo_email varchar(max), @CODIGO_EMAIL varchar(200)
Declare @fb_uea_pe_id numeric(10,0), @user_id numeric(10,0)
Declare @AmbitoIncidencia varchar(64), @TipoIncidencia varchar(64)
Declare @tabla varchar(max), @correo_proyecto varchar(500), @correo_responsable varchar(100), @correo_reportante varchar(100), @cliente varchar(200)
Declare @Url_App varchar(250),@App_Name varchar(250), @Arroba varchar(100),@Nombre_Reporte VARCHAR(150), @activo varchar(1), @producto varchar(100)
Declare @Url_App_war varchar(50)

DECLARE @ticket varchar(100), @proyecto varchar(200), @fecha varchar(50), @reportante varchar(200), @descripcion varchar(500)
DECLARE @severidad varchar(50), @lugar_error varchar(500), @adjunto varchar(200), @titulo varchar(500)

SET @CODIGO_EMAIL = 'INC_AVISO_REGISTRO_INCIDENCIA'

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
	@TipoIncidencia = ISNULL(ti.nombre, ''),
	@AmbitoIncidencia = ISNULL(i.ambito, ''),
	@lugar_error = ISNULL(i.informacion_adicional, ''),
	@adjunto = ISNULL(REPLACE(i.archivo_pasos_error,'C:\fakepath\',''),''),
	@correo_proyecto = ISNULL(p.email_cliente_incidente, ''),
	@correo_responsable = ISNULL(e.email, ''),
	@correo_reportante = ISNULL(u.EMAIL, ''),
	@cliente = ISNULL(c.nombre, ''),
	@producto = ISNULL(pr.nombre, '')
FROM inc_incidencia i
	LEFT JOIN pry_proyecto p ON p.pry_proyecto_id = i.pry_proyecto_id
	LEFT JOIN inc_nivel_incidencia ni ON ni.inc_nivel_incidencia_id = i.inc_nivel_incidencia_id
	LEFT JOIN inc_tipo_incidencia ti ON ti.inc_tipo_incidencia_id = i.inc_tipo_incidencia_id
	LEFT JOIN fb_empleado e ON e.fb_empleado_id = fb_responsable_id
	LEFT JOIN fb_cliente c ON c.fb_cliente_id = i.fb_cliente_id
	LEFT JOIN prd_producto pr ON pr.prd_producto_id = p.prd_producto_id
	LEFT JOIN SC_USER u ON u.SC_USER_ID = i.owner_id
WHERE i.inc_incidencia_id = @inc_incidencia_id
  

SET @destinatarios_email = @destinatarios_email + ';' + @correo_proyecto + ';' + @correo_responsable + ';' + @correo_reportante

SET @asunto = REPLACE(@asunto,'[CODIGO]',@ticket)
SET @asunto = REPLACE(@asunto,'[DESCRIPCION]',@titulo)
SET @asunto = REPLACE(@asunto,'[PRODUCTO]',@producto)

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
					<td class="fondo">Tipo Incidencia:</td>
					<td>' + @TipoIncidencia + '</td>
				</tr>
				<tr>
					<td class="fondo">Ambito:</td>
					<td>' + @AmbitoIncidencia + '</td>
				</tr>
				<tr>
					<td class="fondo">Severidad:</td>
					<td>' + @severidad + '</td>
				</tr>
				<tr>
					<td class="fondo">Sede / Módulo / Submódulo / Funcionalidad / Navegador:</td>
					<td>' + @lugar_error + '</td>
				</tr>
				<tr>
					<td class="fondo">Archivo Adjunto:</td>
					<td>' +  @adjunto + '</td>
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
	 Exec pr_EMAIL_ENVIO_V2 '',@destinatarios_email,@asunto,'HTML',@cuerpo_email,@CODIGO_EMAIL,@fb_uea_pe_id,@user_id,@inc_incidencia_id   
		--EXEC  msdb.dbo.sp_send_dbmail     
		--	@profile_name = @PERFIL_SQL_NAME,    
		--	@recipients = @destinatarios_email,    
		--	@subject  = @asunto,    
		--	@body   =  @HTML,  
		--	@body_format ='HTML';
	--End

GO

