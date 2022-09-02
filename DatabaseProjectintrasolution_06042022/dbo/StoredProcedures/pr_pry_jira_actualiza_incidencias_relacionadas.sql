CREATE PROCEDURE [dbo].[pr_pry_jira_actualiza_incidencias_relacionadas]
@pases varchar(MAX)
     
AS   

    DECLARE @pase_id numeric(10,0)
	DECLARE @jiraissue_id numeric(10,0)

	DECLARE @fuente numeric(10,0)
	DECLARE @destino numeric(10,0)
	DECLARE @tipo_link varchar(200)

	DECLARE @id_inc_pa numeric(10,0)
	DECLARE @cod_jira varchar(200)
	DECLARE @created datetime
	DECLARE @summary varchar(MAX)
	DECLARE @id_empleado numeric(10,0)

	DECLARE @inc_incidencia_id numeric(10,0)
	DECLARE @ticket_inc varchar(200)
	DECLARE @pa_pase_asociado_id numeric(10,0)

	DECLARE @base_url varchar(200)

	SELECT @base_url = propertyvalue 
	FROM DTECH_185.jira_db.dbo.propertystring 
	WHERE 
		ID IN (
				SELECT ID 
				FROM DTECH_185.jira_db.dbo.propertyentry 
				WHERE property_key LIKE '%baseurl%'
				)


	DECLARE CURSOR_PASES CURSOR FOR 
	SELECT
		p.pa_pase_id,
		j.jiraissue_id
	FROM pa_pase p
		LEFT JOIN (
					SELECT 
						jpr.pkey + '-' + CONVERT(VARCHAR,ji.issuenum) codigo_jira,
						ji.ID jiraissue_id
					FROM DTECH_185.jira_db.dbo.jiraissue ji
						INNER JOIN DTECH_185.jira_db.dbo.project jpr ON ji.PROJECT = jpr.ID
					WHERE jpr.pkey = 'DMTPAS'
				  ) j ON p.codigo_jira = j.codigo_jira 
	WHERE 
		p.is_deleted = 0 AND 
		(
			p.pa_pase_id IN (SELECT * FROM dbo.uf_Split(@pases,'-'))
			OR
			(@pases = '' AND p.pa_pase_estado_id NOT IN (9,10004)) -- Conforme, Cancelado
		)


	OPEN CURSOR_PASES  
	FETCH NEXT FROM CURSOR_PASES INTO @pase_id, @jiraissue_id  

	WHILE @@FETCH_STATUS = 0  
	 BEGIN  

		DECLARE CURSOR_INC CURSOR FOR 
		SELECT
			il.SOURCE,
			il.DESTINATION,
			(
				CASE
					WHEN il.SOURCE = @jiraissue_id THEN 'destination'
					WHEN il.DESTINATION = @jiraissue_id THEN 'source'
					ELSE ''
				END
			)
		FROM DTECH_185.jira_db.dbo.jiraissue ji
			INNER JOIN DTECH_185.jira_db.dbo.issuelink il ON ji.ID = il.SOURCE
			INNER JOIN DTECH_185.jira_db.dbo.jiraissue jir ON jir.ID = il.DESTINATION
		WHERE 
			(il.SOURCE = @jiraissue_id OR il.DESTINATION = @jiraissue_id) AND -- pass
			il.LINKTYPE IN (10000,10003,10201) -- Is Blocked By, Relates To, Is Caused By

		OPEN CURSOR_INC  
		FETCH NEXT FROM CURSOR_INC INTO @fuente, @destino, @tipo_link

		WHILE @@FETCH_STATUS = 0  
		 BEGIN
			SET @cod_jira = ''
			SET @created = ''
			SET @summary = ''
			SET @id_empleado = NULL

			IF @tipo_link = 'destination' -- Pase es fuente, incidencia ligada es destino
			 BEGIN
				SELECT
					@cod_jira = pr.pkey + '-' + CONVERT(VARCHAR,jir.issuenum),
					@created = jir.CREATED,
					@summary = jir.SUMMARY,
					@id_empleado = pje.empleado_IS_id
				FROM DTECH_185.jira_db.dbo.jiraissue ji
					INNER JOIN DTECH_185.jira_db.dbo.issuelink il ON ji.ID = il.SOURCE
					INNER JOIN DTECH_185.jira_db.dbo.jiraissue jir ON jir.ID = il.DESTINATION
					INNER JOIN DTECH_185.jira_db.dbo.project pr ON jir.PROJECT = pr.ID
					INNER JOIN DTECH_185.jira_db.dbo.app_user au ON au.user_key = jir.ASSIGNEE
					INNER JOIN DTECH_185.jira_db.dbo.cwd_user cu ON cu.lower_user_name = au.lower_user_name
					LEFT JOIN pry_proyecto_jira_empleado pje ON pje.empleado_J_id = cu.ID
				WHERE 
					il.SOURCE = @fuente AND
					il.DESTINATION = @destino AND
					il.LINKTYPE IN (10000,10003,10201) -- Is Blocked By, Relates To, Is Caused By
			 END
			ELSE
			 BEGIN
				IF @tipo_link = 'source'  -- Pase es destino, incidencia ligada es fuente
				 BEGIN
					SELECT
						@cod_jira = pr.pkey + '-' + CONVERT(VARCHAR,jir.issuenum),
						@created = jir.CREATED,
						@summary = jir.SUMMARY,
						@id_empleado = pje.empleado_IS_id
					FROM DTECH_185.jira_db.dbo.jiraissue ji
						INNER JOIN DTECH_185.jira_db.dbo.issuelink il ON ji.ID = il.DESTINATION
						INNER JOIN DTECH_185.jira_db.dbo.jiraissue jir ON jir.ID = il.SOURCE
						INNER JOIN DTECH_185.jira_db.dbo.project pr ON jir.PROJECT = pr.ID
						INNER JOIN DTECH_185.jira_db.dbo.app_user au ON au.user_key = jir.ASSIGNEE
						INNER JOIN DTECH_185.jira_db.dbo.cwd_user cu ON cu.lower_user_name = au.lower_user_name
						LEFT JOIN pry_proyecto_jira_empleado pje ON pje.empleado_J_id = cu.ID
					WHERE 
						il.DESTINATION = @destino AND
						il.SOURCE = @fuente AND
						il.LINKTYPE IN (10000,10003,10201) -- Is Blocked By, Relates To, Is Caused By
				 END
			 END


			SET @inc_incidencia_id = NULL
			SET @ticket_inc = ''
			SET @pa_pase_asociado_id = NULL

			IF @cod_jira <> ''
			 BEGIN

				IF NOT EXISTS (SELECT pa_pase_asociado_id FROM pa_pase_asociado WHERE codigo_jira = @cod_jira AND pa_pase_id = @pase_id AND is_deleted = 0)
				 BEGIN
				
					SELECT TOP 1 @inc_incidencia_id = inc_incidencia_id, @ticket_inc = codigo_ticket
					FROM inc_incidencia
					WHERE codigo_jira = @cod_jira AND is_deleted = 0

					INSERT INTO pa_pase_asociado (pa_pase_id, codigo_jira, url_jira, fecha_incidencia, descripcion, fb_responsable_id, is_deleted, created, inc_incidencia_id, numero_ticket)
					SELECT
						@pase_id,
						@cod_jira,
						@base_url + '/browse/' + @cod_jira,
						@created,
						@summary,
						@id_empleado,
						0, 
						GETDATE(),
						@inc_incidencia_id,
						@ticket_inc

				 END
				ELSE
				 BEGIN

					SELECT TOP 1 @pa_pase_asociado_id = pa_pase_asociado_id 
					FROM pa_pase_asociado 
					WHERE codigo_jira = @cod_jira AND pa_pase_id = @pase_id AND is_deleted = 0

					SELECT TOP 1 @inc_incidencia_id = inc_incidencia_id, @ticket_inc = codigo_ticket
					FROM inc_incidencia
					WHERE codigo_jira = @cod_jira AND is_deleted = 0

					UPDATE pa_pase_asociado
					SET inc_incidencia_id = @inc_incidencia_id,  numero_ticket = @ticket_inc, fb_responsable_id = @id_empleado
					WHERE pa_pase_asociado_id = @pa_pase_asociado_id

				 END

			 END
			
			FETCH NEXT FROM CURSOR_INC INTO @fuente, @destino, @tipo_link

		 END

		CLOSE CURSOR_INC  
		DEALLOCATE CURSOR_INC
	
		FETCH NEXT FROM CURSOR_PASES INTO @pase_id, @jiraissue_id  
	 END 

	CLOSE CURSOR_PASES  
	DEALLOCATE CURSOR_PASES

GO

