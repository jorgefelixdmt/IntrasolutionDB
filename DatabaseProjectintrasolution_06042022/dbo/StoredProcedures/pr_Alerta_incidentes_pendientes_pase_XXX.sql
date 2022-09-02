/*
********************************************************************************************
Nombre:[dbo].[pr_Alerta_incidentes_pendientes_pase_NEW]
Fecha de creación: 23/04/2021
Autor:Jorge Felix
Descripción: Se envia semanalmente los lunes a primera hora con el resumen de los incidentes pendientes por pases - proyectos
Se envia por producto o proyecto
********************************************************************************************
Resumen de cambios 
Fecha(aaaa-mm-dd)	Autor			Comentarios
-----------------	-------------	-------------
********************************************************************************************
*/
CREATE PROCEDURE [dbo].[pr_Alerta_incidentes_pendientes_pase_XXX]

As
	SET DATEFIRST 1
	set language spanish
	set dateformat dmy
	DECLARE @CODIGO_EMAIL varchar(150), @asunto_email varchar(150), @cuerpo_email varchar(max), @DiaActual numeric(10,0), @Top_html varchar(max), @PASE numeric(10,0)
	DECLARE @CodigoTicket varchar(150), @Fecha varchar(10), @ReportadoPor varchar(150), @Descripcion varchar(800), @NombreCompleto varchar(150), @Email varchar(250),@EmailResp varchar(250),
			@fb_empleado_id numeric(10,0), @UEA numeric(10,0), @Correlativo numeric(10,0), @Tabla_html varchar(max), @FechaSolicitud varchar(10),@pa_pase_id numeric(10,0)
	DECLARE @CodigoCliente varchar(150), @NombreCliente varchar(150), @CodigoProyecto varchar(150), @NombreProyecto varchar(150), @CodigoPase varchar(150), @DescripcionPase varchar(500)
	DECLARE @Estado varchar(150), @FechaEnvioPase varchar(10), @EstadoSiguiente varchar(150), @Proyecto varchar(150), @EmailClienteIncidente varchar(450)
	DECLARE @PROY numeric(10,0), @pry_proyecto_id numeric(10,0),@pa_pase_incidente_id numeric(10,0)
	DECLARE @HTML_PASE varchar(max),@BODY varchar(max)

	SET @CODIGO_EMAIL = 'INC_ALERTA_PASE_PENDIENTE'
	SET @DiaActual = (select DATEPART(dw, getdate()))

IF @DiaActual = 1
	BEGIN 
	-- Recupera elementos del EMAIL  
	SELECT  @Email = IsNull(destinatario_email,'')  from fb_mensaje_email where codigo=@CODIGO_EMAIL 
	SET @cuerpo_email = (SELECT cuerpo from fb_mensaje_email where codigo=@CODIGO_EMAIL )  
	SET @asunto_email = (SELECT asunto from fb_mensaje_email where codigo=@CODIGO_EMAIL )  

	-- Crea CURSOR_PASE
	DECLARE Cursor_Pase CURSOR FOR
		SELECT 
			cl.codigo as codigo_cliente,
			cl.nombre as nombre_cliente,
			pry.codigo as codigo_proyecto,
			pry.nombre as nombre_proyecto,
			pa.codigo_jira as codigo_pase,
			IsNull(pa.descripcion,'') as descripcion_pase,
			pae.nombre as estado,
			(Select top 1 convert(varchar(10),pa.fecha_solicitud,120) 
				from pa_pase_seguimiento ps  
				Where ps.pa_pase_id = pa.pa_pase_id and ps.pa_pase_estado_id in (5,6) order by pa.fecha_solicitud) 
			as Fecha_Envio_Pase,
			(Select top 1 nombre 
				from pa_pase_estado paes  
				Where paes.orden >  pae.orden) 
			as Estado_Siguiente,
			pry.nombre as proyecto,
			IsNull(email_cliente_incidente,'') as email_cliente_incidente,
			pry.pry_proyecto_id,
			pa.pa_pase_id
		FROM pa_pase pa
			inner join pry_proyecto pry on pry.pry_proyecto_id = pa.pry_proyecto_id
			inner join fb_cliente cl on cl.fb_cliente_id = pry.fb_cliente_id
			right join pa_pase_estado pae on pae.pa_pase_estado_id = pa.pa_pase_estado_id
		WHERE
			pa.is_deleted = 0 AND
			pae.orden between 50 and 80
		ORDER BY codigo_Cliente,codigo_proyecto, Fecha_Envio_Pase

	-- Abre CURSOR_PASE
	OPEN Cursor_Pase 
	
	-- Recupera primer registro de CURSOR_PASE
	FETCH NEXT FROM Cursor_Pase INTO	
		@CodigoCliente, 
		@NombreCliente, 
		@CodigoProyecto, 
		@NombreProyecto, 
		@CodigoPase,
		@DescripcionPase,
		@Estado,
		@FechaEnvioPase,
		@EstadoSiguiente,
		@Proyecto,
		@EmailClienteIncidente,
		@pry_proyecto_id,
		@pa_pase_id

	-- Inicializa ID_PROYECTO
	SET @PROY = -1
	SET @PASE = -1
	SET @HTML_PASE = ''

	SET @Top_html = '<style>'
	SET @Top_html = @Top_html + 'body{font-family:Arial; font-size:12}'
	SET @Top_html = @Top_html + 'table, th, td {border: 1px solid black; border-collapse:collapse; padding:5px;}'
	SET @Top_html = @Top_html + 'th {background: lightgrey;font-size:12}'
	SET @Top_html = @Top_html + 'tr {align: left;font-size:12}'
	SET @Top_html = @Top_html + 'ul.no-bullets {list-style-type:none; margin:0; padding-left:0px;padding-bottom:5px;}'
	SET @Top_html = @Top_html + 'h3 {margin:0; padding-left:0px;padding-bottom:2px;}'
	SET @Top_html = @Top_html + '</style>'

	WHILE @@Fetch_Status = 0 
		BEGIN	-- ***  INICIO BUCLE CURSOR_PASE				 			
			--SET @Email = @EmailResp + ';' + @Email		-- Agrega al EMAIL al definido en la tabla FB_MENSAJE_EMAIL

			IF @PROY <> @pry_proyecto_id	
				BEGIN -- Inicializa variables por PROYECTO
					SET @PROY = @pry_proyecto_id
					SET @Email = @EmailClienteIncidente + ';' + @Email
					SET @BODY = ''
				END

			IF @PASE <> @pa_pase_id
				BEGIN -- Inicio de quiebre del PASE
					SET @PASE = @pa_pase_id
					-- Define Cabecera con datos del Pase
					SET @HTML_PASE =   @HTML_PASE +
										'<h3></b>  ' + @CodigoPase + '</h3>
										<ul class="no-bullets">
										<li><b>Proyecto:</b>  ' + @Proyecto + '</li>
										<li><b>Fecha de Pase:</b>  ' + @FechaEnvioPase + '</li>
										<li><b>Descripción:</b>  ' + @DescripcionPase + '</li>
										<li><b>Tarea por Ejecutar:</b>  ' + @Estado + '</li>
										</ul><br>'

					-- Declara CURSOR_INCIDENCIAS con las incidencias del pase
					DECLARE Cursor_Incidencia CURSOR FOR
						SELECT 
							inc.codigo_ticket,
							convert(varchar(10),inc.fecha,120) as fecha,
							inc.reportado_por,
							inc.descripcion_incidente
						FROM inc_incidencia inc
							inner join pa_pase_asociado paa on paa.inc_incidencia_id = inc.inc_incidencia_id
						WHERE
							inc.is_deleted = 0 AND
							paa.pa_pase_id = @pa_pase_id
						ORDER BY inc.codigo_ticket
	
					OPEN Cursor_Incidencia 

					FETCH NEXT FROM Cursor_Incidencia INTO	
						@CodigoTicket, 
						@Fecha, 
						@ReportadoPor, 
						@Descripcion

					SET @Correlativo = 0

					WHILE @@Fetch_Status = 0 
						BEGIN	-- ***  INICIO BUCLE CURSOR_INCIDENCIA			

							IF @Correlativo = 0
								BEGIN
									-- Inicializa el Mensaje la primera vez
									SET @HTML_PASE =  @HTML_PASE + 
										'<table BORDER CELLPADDING=10 CELLSPACING=0 WIDTH="90%">
											<tr>
												<th>#</th>
												<th width="180px">Ticket</th>
												<th width="80px">Fecha</th>
												<th width="200px">Reportado Por</th>
												<th>Descripci&oacute;n</th>
											</tr>'													
								END
					
							SET @Correlativo = @Correlativo + 1
	
							SET  @HTML_PASE = @HTML_PASE + '<TR>
								<TD>' + Convert(varchar(3),@Correlativo) + '</TD>
								<TD>' + @CodigoTicket  + '</TD>
								<TD>' + @Fecha  + '</TD>
								<TD>' + @ReportadoPor   + '</TD>
								<TD>' + @Descripcion     + '</TD></TR>'  

							FETCH NEXT FROM Cursor_Incidencia INTO	
									@CodigoTicket, 
									@Fecha, 
									@ReportadoPor, 
									@Descripcion

						END -- ***  FIN BUCLE CURSOR_INCIDENCIA 

						IF ( @Correlativo > 0)
							BEGIN
								SET @HTML_PASE = @HTML_PASE + '</table><br><br>' 
							END
				END -- Fin de Quiebre del PASE
				CLOSE Cursor_Incidencia   
				DEALLOCATE Cursor_Incidencia  
	
			FETCH NEXT FROM Cursor_Pase INTO	
				@CodigoCliente, 
				@NombreCliente, 
				@CodigoProyecto, 
				@NombreProyecto, 
				@CodigoPase,
				@DescripcionPase,
				@Estado,
				@FechaEnvioPase,
				@EstadoSiguiente,
				@Proyecto,
				@EmailClienteIncidente,
				@pry_proyecto_id,
				@pa_pase_id
			
			IF (@PROY <> @pry_proyecto_id)
				BEGIN
					SET @BODY = (SELECT Replace(@cuerpo_email,'[TOP]',''))  
					SET @BODY = (SELECT Replace(@cuerpo_email,'[TABLA_DATOS]',@HTML_PASE))  
					SET @BODY =  @Top_html + @BODY
					-- se envia el email  
					Exec pr_EMAIL_ENVIO_V2 '',@email,@asunto_email,'HTML',@BODY ,@CODIGO_EMAIL,1,NULL,NULL
					-- INICIALIZA HTML
					SET @HTML_PASE = ''
				END

		END -- ***  FIN BUCLE CURSOR_PASE 

		IF ( @PASE > 0)
			BEGIN
				SET @BODY = (SELECT Replace(@cuerpo_email,'[TABLA_DATOS]',@HTML_PASE))  
				SET @BODY =  @Top_html + @BODY
				-- se envia el email  
				Exec pr_EMAIL_ENVIO_V2 '',@email,@asunto_email,'HTML',@BODY ,@CODIGO_EMAIL,1,NULL,NULL
			END

	CLOSE Cursor_Pase   
	DEALLOCATE Cursor_Pase
			
	END

GO

