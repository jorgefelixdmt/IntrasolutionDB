/*
*********************************************************************************************************************
Nombre:[dbo].[pr_Alerta_incidentes_pendientes_responsable]
Fecha de creación: 23/04/2021
Autor: MPE
Descripción: Alerta que envia un email por cada proyecto de los Incidentes pendientes por Responsable 
			 Los Destinarios es el email soporte@dominiotech.com.pe
			 Los Incidentes se agrupan por Responsables y ordenado por Fecha
			 Se propone enviar semanalmente los lunes a primera hora (de manera temporal se enviara todos los dias) 
*************************************************************************************************************************
Resumen de cambios 
Fecha(aaaa-mm-dd)	Autor			  Comentarios
-----------------	---------------	  --------------------------------------------------------------------------------
18/08/2021          Valky Salinas     Se incluyó is_deleted = 0 dentro del left join para pa_pase_asociado y pa_pase

16/10/2021			MPE				  Se agrego campo TipoIncidencia

11/11/2021          Valky Salinas     Se agregó un parámetro más a pr_EMAIL_ENVIO_V2.

*************************************************************************************************************************
*/
CREATE PROCEDURE [dbo].[pr_Alerta_incidentes_pendientes_responsable]

As
	SET DATEFIRST 1
	set language spanish
	set dateformat dmy
	DECLARE @CODIGO_EMAIL varchar(150), @asunto_email varchar(1024), @cuerpo_email varchar(max), @DiaActual numeric(10,0), @Top_html varchar(max)
	DECLARE @HTML_EMAIL varchar(max),@BODY varchar(max),@ClassSemaforo varchar(32) 
	DECLARE @Email varchar(250),@Email_Alerta varchar(250)
	DECLARE	@CodigoProyecto varchar(64), @CodigoTicket varchar(64),	@CodigoJira varchar(64), @FechaIncidencia varchar(10)
	DECLARE	@ReportadoPorIncidencia varchar(128),	@DescripcionIncidencia varchar(2048), @ResponsableIncidencia varchar(128)
	DECLARE	@AmbitoIncidencia varchar(64), @TipoIncidencia varchar(64), @EstadoIncidencia varchar(64), @CodigoPase varchar(64), @EstadoPase varchar(64)
	DECLARE @Responsable varchar(128),@Semaforo varchar(256), @Correlativo int

	SET @CODIGO_EMAIL = 'INC_ALERTA_INCIDENCIA_RESPONSABLE'
	SET @DiaActual = (select DATEPART(dw, getdate()))
	
	-- Recupera elementos del EMAIL  
	SELECT  @Email_Alerta = IsNull(destinatario_email,'')  from fb_mensaje_email where codigo=@CODIGO_EMAIL 
	SET @cuerpo_email = (SELECT cuerpo from fb_mensaje_email where codigo=@CODIGO_EMAIL )  
	SET @asunto_email = (SELECT asunto from fb_mensaje_email where codigo=@CODIGO_EMAIL )  

	-- Crea CURSOR_INCIDENCIA
	DECLARE Cursor_Incidencia CURSOR FOR
		SELECT
			Case 
				When ie.orden <= 40 then '<center><a ><span class="dot" title="En DOMINIOTECH"  style="background-color:red !important;"></span></a></center>'
				Else '<center><a ><span class="dot" title="En CLIENTE"  style="background-color:gold !important;"></span></a></center>'
			End as Semaforo,
			Case 
				When ie.orden <= 40 then 'red'
				Else 'ambar'
			End as ClassSemaforo,
			pry.codigo as proyecto,
			inc.codigo_ticket,
			IsNull(inc.codigo_jira,'') as codigo_jira,
			convert(varchar(10),inc.fecha,120) as fecha,
			IsNull(inc.reportado_por,'') as reportado_por,
			inc.descripcion_incidente,
			emp.nombreCompleto,
			inc.ambito as ambito_incidencia,
			ti.nombre as tipo_incidencia,		-- 2021-10-16
			ie.nombre as estado_incidencia,
			IsNull(pa.codigo_jira,'') as codigo_pase ,
			IsNull(pae.nombre,'') as estado_pase
		FROM inc_incidencia inc
			inner join pry_proyecto pry on pry.pry_proyecto_id = inc.pry_proyecto_id
			inner join inc_estado_incidencia ie on ie.inc_estado_incidencia_id = inc.inc_estado_incidencia_id
			left join inc_tipo_incidencia ti on ti.inc_tipo_incidencia_id = inc.inc_tipo_incidencia_id	-- 2021-10-16
			left join fb_empleado emp on emp.fb_empleado_id = inc.fb_empleado_id
			left join pa_pase_asociado paa on (paa.inc_incidencia_id = inc.inc_incidencia_id AND paa.is_deleted = 0)
			left join pa_pase pa on (pa.pa_pase_id = paa.pa_pase_id AND pa.is_deleted = 0)
			left join pa_pase_estado pae on pae.pa_pase_estado_id = pa.pa_pase_estado_id
		WHERE
			inc.is_deleted = 0 AND
			ie.orden not in ( 90,99) -- 6: Confirmado Cliente
		ORDER BY nombreCompleto,fecha_incidencia

	-- Abre CURSOR_INCIDENCIA
	OPEN Cursor_Incidencia
	
	-- Recupera primer registro de CURSOR_PASE
	FETCH NEXT FROM Cursor_Incidencia INTO
		@Semaforo, 
		@ClassSemaforo, 
		@CodigoProyecto, 
		@CodigoTicket, 
		@CodigoJira, 
		@FechaIncidencia,
		@ReportadoPorIncidencia,
		@DescripcionIncidencia,
		@ResponsableIncidencia,
		@AmbitoIncidencia,
		@TipoIncidencia,		-- 2021-10-16
		@EstadoIncidencia,
		@CodigoPase,
		@EstadoPase
	
	-- Inicializa ID_PROYECTO
	SET @Responsable = '-'
	
	SET @HTML_EMAIL = ''

	SET @Top_html = '<head>'
	SET @Top_html = @Top_html + '<style>'
	SET @Top_html = @Top_html + 'body{font-family:Arial; font-size:12px}'
	SET @Top_html = @Top_html + 'table, th, td {border: 1px solid black; border-collapse:collapse; padding:5px;}'
	SET @Top_html = @Top_html + 'th {background: lightgrey;font-size:10px}'
	SET @Top_html = @Top_html + 'tr {font-size:10px}'
	SET @Top_html = @Top_html + 'ul.no-bullets {list-style-type:none; margin:0; padding-left:0px;padding-bottom:5px;}'
	SET @Top_html = @Top_html + 'h3 {margin:0; padding-left:0px;padding-bottom:2px;}'
	SET @Top_html = @Top_html + '.red {background:red;}'
	SET @Top_html = @Top_html + '.ambar {background:gold;}'
	SET @Top_html = @Top_html + '.dot {'
	SET @Top_html = @Top_html + '	height: 20px;'
	SET @Top_html = @Top_html + '	width: 20px;'
	SET @Top_html = @Top_html + '	border-radius: 50% !important;'
	SET @Top_html = @Top_html + '	display: inline-block;'
	SET @Top_html = @Top_html + '}'
	SET @Top_html = @Top_html + '</style></head><body>'

	SET @Email = @Email_Alerta
	SET @BODY = ''
	SET @Correlativo = 0

	WHILE @@Fetch_Status = 0 
		BEGIN	-- ***  INICIO BUCLE CURSOR_INCIDENCIA				 			

			IF @Responsable <> @ResponsableIncidencia	
				BEGIN -- Inicio de quiebre del RESPONSABLE
					SET @Responsable = @ResponsableIncidencia

					-- Define Cabecera con datos del Responasble
					SET @HTML_EMAIL =   @HTML_EMAIL +
										'<h3><b>  ' + @Responsable + '</b></h3><br>'

					-- Inicializa el Mensaje la primera vez
					SET @HTML_EMAIL =  @HTML_EMAIL + 
						'<table BORDER CELLPADDING=10 CELLSPACING=0 WIDTH="90%">
							<tr>
								<th>#</th>
								<th width="25px">Flag</th>
								<th width="40px">Proyecto</th>
								<th>Ticket / Jira</th>
								<th width="60px">Fecha</th>
								<th width="200px">Reportado Por</th>
								<th>Descripci&oacute;n</th>
								<th width="80px">Ambito</th>
								<th width="80px">Tipo</th>
								<th width="80px">Estado Inc</th>
								<th width="80px">Pase</th>
								<th width="80px">Estado Pase</th>
							</tr>'													
					
				END

				SET @Correlativo = @Correlativo + 1
	
				SET  @HTML_EMAIL = @HTML_EMAIL + '<TR>
					<TD>' + Convert(varchar(3),@Correlativo) + '</TD>
					<TD class="' + @ClassSemaforo + '">' + @Semaforo  + '</TD>
					<TD>' + @CodigoProyecto  + '</TD>
					<TD><span style="color:red;">' + @CodigoTicket + '</span><br>' + @CodigoJira + '</TD>
					<TD>' + @FechaIncidencia  + '</TD>
					<TD>' + @ReportadoPorIncidencia   + '</TD>
					<TD>' + @DescripcionIncidencia   + '</TD>
					<TD>' + @AmbitoIncidencia  + '</TD>
					<TD>' + @TipoIncidencia  + '</TD>
					<TD>' + @EstadoIncidencia   + '</TD>
					<TD>' + @CodigoPase   + '</TD>
					<TD>' + @EstadoPase     + '</TD></TR>'  

				FETCH NEXT FROM Cursor_Incidencia INTO
					@Semaforo, 
					@ClassSemaforo, 
					@CodigoProyecto, 
					@CodigoTicket, 
					@CodigoJira, 
					@FechaIncidencia,
					@ReportadoPorIncidencia,
					@DescripcionIncidencia,
					@ResponsableIncidencia,
					@AmbitoIncidencia,
					@TipoIncidencia,		-- 2021-10-16
					@EstadoIncidencia,
					@CodigoPase,
					@EstadoPase

			IF @Responsable <> @ResponsableIncidencia	
				BEGIN
					SET @HTML_EMAIL = @HTML_EMAIL + '</table><br><br>' 
				END


		END -- ***  FIN BUCLE CURSOR_INCIDENCIA 

			
		IF ( @ResponsableIncidencia <> '')
			BEGIN
				SET @HTML_EMAIL = @HTML_EMAIL + '</table><br><br>' 
				SET @BODY = (SELECT Replace(@cuerpo_email,'[TABLA_DATOS]',@HTML_EMAIL))  
				SET @BODY =  @Top_html + @BODY + '</body>'
				-- se envia el email  
				SET @Email_Alerta = 'manuel.perez@dominiotech.com.pe'
				Exec pr_EMAIL_ENVIO_V2 '',@Email_Alerta,@asunto_email,'HTML',@BODY ,'',@CODIGO_EMAIL,1,NULL,NULL
			END

	CLOSE Cursor_Incidencia   
	DEALLOCATE Cursor_Incidencia

GO

