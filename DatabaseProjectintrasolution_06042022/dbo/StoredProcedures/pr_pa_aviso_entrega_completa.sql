/*      

****************************************************************************************************************************************
Nombre: dbo.pr_pa_aviso_entrega_completa
Fecha Creacion: 11/03/2022
Autor: Valky Salinas
Descripcion: Envía correo de aviso al cambiar una entrega a completada
Llamado por: ---
Usado por: Modulo: Incidencias
Parametros:  @pa_entrega_objetos_id numeric(10,0)

pr_pa_aviso_entrega_completa 1
****************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(aaaa-mm-dd)       Autor                  Comentarios
------------------      -----------------      ------------------------------------------------------------------

**************************************************************************************************************************************
*/
CREATE PROCEDURE [dbo].[pr_pa_aviso_entrega_completa] --4,1
	@pa_entrega_objetos_id numeric(10,0)
As

set dateformat dmy
Declare @asunto varchar(1000),@destinatarios_email varchar(600),@PERFIL_SQL_NAME varchar(100)
Declare @cuerpo_email varchar(max), @CODIGO_EMAIL varchar(200)
Declare @fb_uea_pe_id numeric(10,0), @user_id numeric(10,0)
Declare @tabla varchar(max), @correo_proyecto varchar(500), @correo_responsable varchar(100), @correo_reportante varchar(100), @cliente varchar(200)
Declare @Url_App varchar(250),@App_Name varchar(250), @Arroba varchar(100),@Nombre_Reporte VARCHAR(150), @activo varchar(1), @producto varchar(100)
Declare @Url_App_war varchar(50), @jiras varchar(max)

DECLARE @codigo varchar(200), @fecha varchar(200)
DECLARE @comentarios varchar(max), @titulo varchar(500)


SET @CODIGO_EMAIL = 'PA_AVISO_ENTREGA_COMPLETA'

Select @PERFIL_SQL_NAME = value from pm_parameter where code = 'PERFIL_SQL_MAIL'  
-- Recupera Valores de la Configuracion para el Envio de Emails  


select 
	@activo = Flag_Estado, 
	@destinatarios_email = destinatario_email, 
	@asunto = asunto, 
	@cuerpo_email = cuerpo
from fb_mensaje_email where codigo = @CODIGO_EMAIL

SELECT @fb_uea_pe_id = 1, @user_id = created_by 
FROM pa_entrega_objetos
WHERE pa_entrega_objetos_id = @pa_entrega_objetos_id


SELECT
	@codigo = eo.codigo,
	@fecha = convert(varchar, eo.fecha, 103),
	@comentarios = REPLACE(eo.comentarios, CHAR(10), '</br>'),
	@titulo = eo.titulo,
	@producto = p.nombre,
	@cliente = c.nombre
FROM pa_entrega_objetos eo
	LEFT JOIN fb_cliente c ON c.fb_cliente_id = eo.fb_cliente_id
	LEFT JOIN prd_producto p ON p.prd_producto_id = eo.prd_producto_id
WHERE 
	eo.pa_entrega_objetos_id = @pa_entrega_objetos_id


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


SET @asunto = REPLACE(@asunto,'[PRODUCTO]',@producto)
SET @asunto = REPLACE(@asunto,'[CLIENTE]',@cliente)
SET @asunto = REPLACE(@asunto,'[CODIGO]',@codigo)
SET @asunto = REPLACE(@asunto,'[TITULO]',@titulo)

-- Tabla de Datos
Set @tabla = 
	N'
			<table class="demo">
				<tr><td class="fondo" width="20%">Código:</td>    
					<td>' + @codigo + '</td>    
				</tr> 
				<tr><td class="fondo">Cliente:</td>    
					<td>' + @cliente + '</td>    
				</tr>    
				<tr><td class="fondo">Fecha:</td>    
					<td>' + @fecha + '</td>
				</tr>   
				<tr>    
					<td class="fondo">Descripción de la Entrega:</td>    
					<td>' + @titulo + '</td>
				</tr>
				<tr>
					<td class="fondo">Observaciones:</td>
					<td>' +  @comentarios + '</td>
				</tr>       
			</table>'


-- Tabla de Jiras
DECLARE @var_cod varchar(200), @var_desc varchar(600), @var_url varchar(500)

SET @jiras = 
	N'
			<table class="demo">
				<tr>
					<th>JIRA</th>
					<th>IS</th>
					<th>URL</th>
				</tr>'

DECLARE CURSOR_JIRA CURSOR FOR 
	SELECT
		ei.codigo_jira,
		ei.link_jira,
		ISNULL(i.codigo_ticket,'')
	FROM pa_entrega_incidentes ei
		LEFT JOIN inc_incidencia i ON i.inc_incidencia_id = ei.inc_incidencia_id
	WHERE 
		ei.is_deleted = 0 AND
		ei.pa_entrega_objetos_id = @pa_entrega_objetos_id

OPEN CURSOR_JIRA  
FETCH NEXT FROM CURSOR_JIRA INTO @var_cod, @var_url, @var_desc   

WHILE @@FETCH_STATUS = 0  
BEGIN  
      SET @jiras = @jiras + '<tr>
								<td>' +  @var_cod + '</td>
								<td>' +  @var_desc + '</td>
								<td>' +  @var_url + '</td>
							 </tr>'

      FETCH NEXT FROM CURSOR_JIRA INTO @var_cod, @var_url, @var_desc    
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
	 Exec pr_EMAIL_ENVIO_V2 '',@destinatarios_email,@asunto,'HTML',@cuerpo_email,'',@CODIGO_EMAIL,@fb_uea_pe_id,@user_id,@pa_entrega_objetos_id
	
	--EXEC  msdb.dbo.sp_send_dbmail     
		--	@profile_name = @PERFIL_SQL_NAME,    
		--	@recipients = @destinatarios_email,    
		--	@subject  = @asunto,    
		--	@body   =  @HTML,  
		--	@body_format ='HTML';
	--End

GO

