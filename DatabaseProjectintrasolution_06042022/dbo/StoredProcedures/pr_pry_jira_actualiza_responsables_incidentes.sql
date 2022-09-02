CREATE PROCEDURE [dbo].[pr_pry_jira_actualiza_responsables_incidentes]
     
AS 

	DECLARE @inc_incidencia_id numeric(10,0)
	DECLARE @codigo_jira varchar(200)

	DECLARE @pa_pase_asociado_id numeric(10,0)
	DECLARE @fb_empleado_id numeric(10,0)


	DECLARE CURSOR_INC CURSOR FOR 
	SELECT
		inc_incidencia_id,
		codigo_jira
	FROM inc_incidencia
	WHERE 
		is_deleted = 0 AND
		(codigo_jira IS NOT NULL OR codigo_jira <> '')

	OPEN CURSOR_INC  
	FETCH NEXT FROM CURSOR_INC INTO @inc_incidencia_id, @codigo_jira 

	WHILE @@FETCH_STATUS = 0  
	 BEGIN
		SET @pa_pase_asociado_id = NULL
		SET @fb_empleado_id = NULL

		SELECT TOP 1
			@pa_pase_asociado_id = pa_pase_asociado_id
		FROM pa_pase_asociado
		WHERE codigo_jira = @codigo_jira

		SELECT TOP 1
			@fb_empleado_id = je.empleado_IS_id
		FROM (
				SELECT 
					pr.pkey + '-' + CONVERT(VARCHAR,ji.issuenum) as codigo_jira,
					cu.ID as responsable
				FROM DTECH_185.jira_db.dbo.jiraissue ji
					INNER JOIN DTECH_185.jira_db.dbo.project pr ON ji.PROJECT = pr.ID
					INNER JOIN DTECH_185.jira_db.dbo.app_user au ON au.user_key = ji.ASSIGNEE
					INNER JOIN DTECH_185.jira_db.dbo.cwd_user cu ON cu.lower_user_name = au.lower_user_name
				WHERE pr.PROJECTTYPE IN ('business','software')
		     ) jira
			INNER JOIN pry_proyecto_jira_empleado je ON je.empleado_J_id = jira.responsable
		WHERE jira.codigo_jira = @codigo_jira

		IF @pa_pase_asociado_id IS NOT NULL
		 BEGIN
			UPDATE pa_pase_asociado
			SET fb_responsable_id = @fb_empleado_id
			WHERE pa_pase_asociado_id = @pa_pase_asociado_id
		 END

		UPDATE inc_incidencia
		SET fb_empleado_id = @fb_empleado_id
		WHERE inc_incidencia_id = @inc_incidencia_id
		 
		FETCH NEXT FROM CURSOR_INC INTO @inc_incidencia_id, @codigo_jira 

	 END

	CLOSE CURSOR_INC  
	DEALLOCATE CURSOR_INC

GO

