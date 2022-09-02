/*      

****************************************************************************************************************************************
Nombre: dbo.pr_pa_aviso_pase_preparado
Fecha Creacion: 11/11/2021
Autor: Valky Salinas
Descripcion: Envía correo de aviso al cambiar una incidencia a completada
Llamado por: ---
Usado por: Modulo: Incidencias
Parametros:  @inc_incidencia_id numeric(10,0)

pr_pa_aviso_pase_aprobado_qa_dmt 1
****************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(aaaa-mm-dd)       Autor                  Comentarios
------------------      -----------------      ------------------------------------------------------------------

**************************************************************************************************************************************
*/
CREATE PROCEDURE [dbo].[pr_pa_aviso_pase_aprobado_qa_dmt] --4,1
	@pa_pase_id numeric(10,0)
As

set dateformat dmy
Declare @asunto varchar(1000),@destinatarios_email varchar(600),@PERFIL_SQL_NAME varchar(100)
Declare @cuerpo_email varchar(max), @CODIGO_EMAIL varchar(200)
Declare @fb_uea_pe_id numeric(10,0), @user_id numeric(10,0)
Declare @tabla varchar(max), @correo_proyecto varchar(500), @correo_responsable varchar(100), @correo_reportante varchar(100), @cliente varchar(200)
Declare @Url_App varchar(250),@App_Name varchar(250), @Arroba varchar(100),@Nombre_Reporte VARCHAR(150), @activo varchar(1), @producto varchar(100)
Declare @Url_App_war varchar(50), @jiras varchar(max)

DECLARE @ticket varchar(200), @proyecto varchar(500), @fecha varchar(200), @solicitante varchar(200), @url_pase varchar(500), @titulo varchar(500)


SET @CODIGO_EMAIL = 'PA_AVISO_PASE_APROBADO_QA_DMT'

Select @PERFIL_SQL_NAME = value from pm_parameter where code = 'PERFIL_SQL_MAIL'  
-- Recupera Valores de la Configuracion para el Envio de Emails  


select 
	@activo = Flag_Estado, 
	@destinatarios_email = destinatario_email, 
	@asunto = asunto, 
	@cuerpo_email = cuerpo
from fb_mensaje_email where codigo = @CODIGO_EMAIL

SELECT @fb_uea_pe_id = 1, @user_id = created_by 
FROM pa_pase
WHERE pa_pase_id = @pa_pase_id

If @activo = '0' 
	Begin
		return
	End


SELECT 
	@ticket = pa.codigo_jira,
	@cliente = c.nombre,
	@proyecto = pr.nombre,
	@fecha = CONVERT(VARCHAR, pa.fecha_solicitud, 103),
	@solicitante = s.nombreCompleto,
	@url_pase = pa.url_pase,
	@producto = ISNULL(pd.nombre, ''),
	@titulo = pa.descripcion
FROM pa_pase pa
	INNER JOIN fb_cliente c ON c.fb_cliente_id = pa.fb_cliente_id
	INNER JOIN pry_proyecto pr ON pr.pry_proyecto_id = pa.pry_proyecto_id
	INNER JOIN fb_empleado s ON s.fb_empleado_id = pa.fb_solicitante_id
	LEFT JOIN prd_producto pd ON pd.prd_producto_id = pr.prd_producto_id
WHERE
	pa.is_deleted = 0 AND
	pa.pa_pase_id = @pa_pase_id
 

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
	rp.codigo LIKE 'RESPONSABLE_EJECUTAR_PASE'

SET @destinatarios_email = @destinatarios_email + ';' + @emails


-- Obtención de observaciones
DECLARE @observaciones varchar(500)

SELECT TOP 1 @observaciones = observacion
FROM pa_pase_seguimiento
WHERE 
	is_deleted = 0 AND
	pa_pase_estado_id = 2 AND -- Preparado
	pa_pase_id = @pa_pase_id
ORDER BY created DESC


SET @asunto = REPLACE(@asunto,'[PRODUCTO]',@producto)
SET @asunto = REPLACE(@asunto,'[CLIENTE]',@cliente)
SET @asunto = REPLACE(@asunto,'[NOMBRE]',@titulo)
SET @asunto = REPLACE(@asunto,'[CODIGO]',@ticket)

-- Tabla de Datos
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
				<tr><td class="fondo">Fecha de Solicitud:</td>    
					<td>' + @fecha + '</td>
				</tr>    
				<tr>    
					<td class="fondo">Solicitado Por:</td>    
					<td>' + @solicitante  + '</td> 
				</tr>    
				<tr>    
					<td class="fondo">Descripción del Pase:</td>    
					<td>' + @titulo + '</td>
				</tr>
				<tr>
					<td class="fondo">URL Pase:</td>
					<td>' +  @url_pase + '</td>
				</tr>
				<tr>
					<td class="fondo">Observaciones:</td>
					<td>' +  @observaciones + '</td>
				</tr>       
			</table>'


-- Tabla de Jiras
DECLARE @var_cod varchar(200), @var_desc varchar(600), @var_url varchar(500)

SET @jiras = 
	N'
			<table class="demo">
				<tr>
					<th>Código</th>
					<th>Nombre</th>
					<th>URL</th>
				</tr>'

DECLARE CURSOR_JIRA CURSOR FOR 
	SELECT
		codigo_jira,
		descripcion,
		url_jira
	FROM pa_pase_asociado
	WHERE 
		is_deleted = 0 AND
		pa_pase_id = @pa_pase_id

OPEN CURSOR_JIRA  
FETCH NEXT FROM CURSOR_JIRA INTO @var_cod, @var_desc, @var_url  

WHILE @@FETCH_STATUS = 0  
BEGIN  
      SET @jiras = @jiras + '<tr>
								<td>' +  @var_cod + '</td>
								<td>' +  @var_desc + '</td>
								<td>' +  @var_url + '</td>
							 </tr>'

      FETCH NEXT FROM CURSOR_JIRA INTO @var_cod, @var_desc, @var_url   
END 

CLOSE CURSOR_JIRA  
DEALLOCATE CURSOR_JIRA 

SET @jiras = @jiras + '</table>'



SET @cuerpo_email = REPLACE(@cuerpo_email,'[TABLA_DATOS]',@tabla)
SET @cuerpo_email = REPLACE(@cuerpo_email,'[TAREAS_JIRA]',@jiras)


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
	 Exec pr_EMAIL_ENVIO_V2 '',@destinatarios_email,@asunto,'HTML',@cuerpo_email,'',@CODIGO_EMAIL,@fb_uea_pe_id,@user_id,@pa_pase_id
		--EXEC  msdb.dbo.sp_send_dbmail     
		--	@profile_name = @PERFIL_SQL_NAME,    
		--	@recipients = @destinatarios_email,    
		--	@subject  = @asunto,    
		--	@body   =  @HTML,  
		--	@body_format ='HTML';
	--End

GO

