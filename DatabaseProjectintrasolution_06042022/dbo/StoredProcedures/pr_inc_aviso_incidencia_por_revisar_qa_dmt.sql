/*      

****************************************************************************************************************************************
Nombre: dbo.pr_inc_aviso_incidencia_por_revisar_qa_dmt
Fecha Creacion: 11/11/2021
Autor: Valky Salinas
Descripcion: Envía correo de aviso al cambiar una incidencia a completada
Llamado por: ---
Usado por: Modulo: Incidencias
Parametros:  @inc_incidencia_id numeric(10,0)

pr_inc_aviso_incidencia_por_revisar_qa_dmt 1
****************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(aaaa-mm-dd)       Autor                  Comentarios
------------------      -----------------      ------------------------------------------------------------------

**************************************************************************************************************************************
*/
CREATE PROCEDURE [dbo].[pr_inc_aviso_incidencia_por_revisar_qa_dmt] --4,1
	@pa_pase_id numeric(10,0)
As

set dateformat dmy
Declare @asunto varchar(1000),@destinatarios_email varchar(600),@PERFIL_SQL_NAME varchar(100)
Declare @cuerpo_email varchar(max), @CODIGO_EMAIL varchar(200)
Declare @fb_uea_pe_id numeric(10,0), @user_id numeric(10,0)
Declare @tabla varchar(max), @correo_proyecto varchar(500), @correo_responsable varchar(100), @correo_reportante varchar(100), @cliente varchar(200)
Declare @Url_App varchar(250),@App_Name varchar(250), @Arroba varchar(100),@Nombre_Reporte VARCHAR(150), @activo varchar(1), @producto varchar(100)
Declare @Url_App_war varchar(50), @cod_jira varchar(200)

DECLARE @ticket_pase varchar(200), @ticket varchar(200), @analista varchar(300), @analista_id numeric(10,0)
DECLARE @incidencia varchar(500), @correo_analista varchar(200)


SET @CODIGO_EMAIL = 'INC_AVISO_INCIDENCIA_REVISION_QA_DMT'

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
	@ticket_pase = pa.codigo_jira,
	@cliente = c.nombre,
	@producto = ISNULL(pd.nombre, '')
FROM pa_pase pa
	INNER JOIN fb_cliente c ON c.fb_cliente_id = pa.fb_cliente_id
	INNER JOIN pry_proyecto pr ON pr.pry_proyecto_id = pa.pry_proyecto_id
	LEFT JOIN prd_producto pd ON pd.prd_producto_id = pr.prd_producto_id
WHERE
	pa.is_deleted = 0 AND
	pa.pa_pase_id = @pa_pase_id


SET @asunto = REPLACE(@asunto,'[PRODUCTO]',@producto)
SET @asunto = REPLACE(@asunto,'[CLIENTE]',@cliente)


--Tabla

SET @tabla = 
	N'
			<table class="demo">
				<tr>
					<th>Ticket</th>
					<th>Nombre</th>
					<th>Revisor</th>
				</tr>'

DECLARE CURSOR_INC CURSOR FOR 
	SELECT 
		e.fb_empleado_id,
		e.nombreCompleto,
		e.email,
		i.codigo_ticket,
		i.titulo_incidencia
	FROM pa_pase p
		INNER JOIN pa_pase_asociado pa ON pa.pa_pase_id = p.pa_pase_id
		INNER JOIN inc_incidencia i ON i.inc_incidencia_id = pa.inc_incidencia_id
		INNER JOIN fb_empleado e ON e.fb_empleado_id = i.fb_analista_dtech_id
	WHERE
		p.pa_pase_id = @pa_pase_id AND
		pa.is_deleted = 0

OPEN CURSOR_INC  
FETCH NEXT FROM CURSOR_INC INTO @analista_id, @analista, @correo_analista, @ticket, @incidencia

WHILE @@FETCH_STATUS = 0  
 BEGIN 

      SET @tabla = @tabla + '<tr>
								<td>' +  @ticket + '</td>
								<td>' +  @incidencia + '</td>
								<td>' +  @analista + '</td>
							 </tr>'

	  SET @destinatarios_email = @destinatarios_email + ';' + @correo_analista

      FETCH NEXT FROM CURSOR_INC INTO @analista_id, @analista, @correo_analista, @ticket, @incidencia  
 END 

CLOSE CURSOR_INC  
DEALLOCATE CURSOR_INC 

SET @tabla = @tabla + '</table>'




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
	 Exec pr_EMAIL_ENVIO_V2 '',@destinatarios_email,@asunto,'HTML',@cuerpo_email,'',@CODIGO_EMAIL,@fb_uea_pe_id,@user_id,@pa_pase_id   
		--EXEC  msdb.dbo.sp_send_dbmail     
		--	@profile_name = @PERFIL_SQL_NAME,    
		--	@recipients = @destinatarios_email,    
		--	@subject  = @asunto,    
		--	@body   =  @HTML,  
		--	@body_format ='HTML';
	--End

GO

