CREATE PROCEDURE [dbo].[pr_pry_jira_actualiza_estado_incidencias]
@incidentes varchar(MAX)

AS 

	DECLARE @inc_incidencia_id numeric(10,0)
	DECLARE @codigo_jira varchar(200)
	DECLARE @inc_estado_incidencia_id numeric(10,0)
	DECLARE @pry_proyecto_id numeric(10,0)

	DECLARE @id_estado_ult numeric(10,0)
	DECLARE @id_estado_pase numeric(10,0)
	DECLARE @id_estado_jira numeric(10,0)
	DECLARE @fecha_act datetime
	DECLARE @fecha_act_pa datetime
	DECLARE @fb_empleado_id numeric(10,0)
	DECLARE @tipo_incidencia_id numeric(10,0)

	DECLARE @ordenOld numeric(10,0), @ordenNew numeric(10,0)


	DECLARE CURSOR_INC CURSOR FOR
	SELECT 
		inc_incidencia_id, 
		codigo_jira, 
		ISNULL(inc_estado_incidencia_id,0),
		pry_proyecto_id
	FROM inc_incidencia
	WHERE 
		is_deleted = 0 AND 
		(
			inc_incidencia_id IN (SELECT * FROM dbo.uf_Split(@incidentes,'-'))
			OR
			(@incidentes = '' AND inc_estado_incidencia_id NOT IN (10002,9)) -- Culminado, Anulado
		)

	OPEN CURSOR_INC  
	FETCH NEXT FROM CURSOR_INC INTO 
		@inc_incidencia_id, 
		@codigo_jira, 
		@inc_estado_incidencia_id, 
		@pry_proyecto_id

	WHILE @@FETCH_STATUS = 0  
	 BEGIN
		
		SET @id_estado_ult = NULL
		SET @fecha_act_pa = NULL
		SET @id_estado_pase = NULL
		SET @fecha_act = NULL
		SET @id_estado_jira = NULL
		SET @fb_empleado_id = NULL
		SET @tipo_incidencia_id = NULL

		SET @id_estado_ult = @inc_estado_incidencia_id

		SELECT TOP 1 
			@fecha_act_pa = (
								SELECT TOP 1 fecha
								FROM pa_pase_seguimiento
								WHERE pa_pase_id = p.pa_pase_id AND is_deleted = 0
								ORDER BY fecha DESC
							),
			@id_estado_pase = CASE
								WHEN p.pa_pase_estado_id <= 2 THEN 1 -- Pase sin enviar
								WHEN pa_pase_estado_id = 3 THEN 10003 -- Instalado en QA DMT
								WHEN pa_pase_estado_id = 4 THEN 10004 -- Aprobado en QA DMT
								WHEN pa_pase_estado_id = 5 THEN 10005 -- Enviado a Cliente
								WHEN pa_pase_estado_id = 6 THEN 5 -- Instalado en QA
								WHEN pa_pase_estado_id = 7 THEN 6 -- Aprobado en QA
								WHEN pa_pase_estado_id = 10005 THEN 7 -- Enviado a Producción
								WHEN pa_pase_estado_id = 8 THEN 8 -- Instalado en Producción
								WHEN pa_pase_estado_id = 9 THEN 10002 -- Aprobado en Producción
								WHEN pa_pase_estado_id = 10004 THEN 9 -- Anulado
								ELSE NULL
							  END
		FROM pa_pase p
			INNER JOIN pa_pase_asociado pa ON p.pa_pase_id = pa.pa_pase_id
			INNER JOIN inc_incidencia i ON pa.codigo_jira = i.codigo_jira
		WHERE i.inc_incidencia_id = @inc_incidencia_id AND p.is_deleted = 0 and pa.is_deleted = 0

		SELECT TOP 1 
			@fecha_act = j.UPDATED,
			@id_estado_jira = CASE
								WHEN j.estado_tarea_IS_id = 1 THEN 1 -- Abierto
								WHEN j.estado_tarea_IS_id = 2 THEN 4 -- Cerrado
								WHEN j.estado_tarea_IS_id = 3 THEN 2 -- En Proceso
								ELSE NULL
							  END,
			@fb_empleado_id = je.empleado_IS_id,
			@tipo_incidencia_id = isnull(jet.tipo_incidencia_IS_id,3)
		FROM inc_incidencia inc
			INNER JOIN (
							SELECT 
								jpr.pkey + '-' + CONVERT(VARCHAR,ji.issuenum) codigo_jira,
								ietj.estado_tarea_IS_id,
								ji.UPDATED,
								cu.ID responsable,
								jl.LABEL
							FROM DTECH_185.jira_db.dbo.jiraissue ji
								INNER JOIN DTECH_185.jira_db.dbo.project jpr ON ji.PROJECT = jpr.ID
								LEFT JOIN pry_proyecto_jira pj ON pj.proyecto_J_id = jpr.ID
								INNER JOIN DTECH_185.jira_db.dbo.issuestatus jie ON jie.ID = ji.issuestatus
								INNER JOIN pry_proyecto_jira_estado_tarea ietj ON ietj.estado_tarea_J_id = jie.STATUSCATEGORY
								LEFT JOIN DTECH_185.jira_db.dbo.app_user au ON au.user_key = ji.ASSIGNEE
								LEFT JOIN DTECH_185.jira_db.dbo.cwd_user cu ON cu.lower_user_name = au.lower_user_name
								LEFT JOIN DTECH_185.jira_db.dbo.label jl ON ji.ID = jl.ISSUE
					   ) j ON inc.codigo_jira = j.codigo_jira
			LEFT JOIN pry_proyecto_jira_empleado je ON je.empleado_J_id = j.responsable
			LEFT JOIN pry_proyecto_jira_etiqueta jet ON j.LABEL = jet.label_jira
		WHERE inc.inc_incidencia_id = @inc_incidencia_id

		IF @id_estado_jira IS NOT NULL AND @fecha_act IS NOT NULL
		 BEGIN
			UPDATE inc_incidencia
			SET fb_empleado_id = @fb_empleado_id, inc_tipo_incidencia_id = @tipo_incidencia_id, updated = GETDATE(), updated_by = 1
			WHERE inc_incidencia_id = @inc_incidencia_id
		 END

		IF (@id_estado_pase IS NOT NULL AND @id_estado_pase <> 1)
		 BEGIN
			IF @id_estado_ult <> @id_estado_pase
			 BEGIN
				SET @ordenOld = (SELECT orden FROM inc_estado_incidencia WHERE inc_estado_incidencia_id = @id_estado_ult)
				SET @ordenNew = (SELECT orden FROM inc_estado_incidencia WHERE inc_estado_incidencia_id = @id_estado_pase)

				IF @ordenOld < @ordenNew
				 BEGIN
					INSERT INTO inc_incidencia_seguimiento (inc_incidencia_id, fecha, hora, observacion, inc_estado_incidencia_id, is_deleted, created, updated, updated_by)
					SELECT
						@inc_incidencia_id,
						@fecha_act_pa,
						CONVERT(VARCHAR(5), @fecha_act_pa, 108),
						'Actualizado por el Sistema por modificación en pase asociado.',
						@id_estado_pase,
						0,
						GETDATE(),
						GETDATE(),
						1
				 END
			 END
		 END
		ELSE
		 BEGIN
			IF @id_estado_jira IS NOT NULL
			 BEGIN
				IF @id_estado_ult <> @id_estado_jira
				 BEGIN
					SET @ordenOld = (SELECT orden FROM inc_estado_incidencia WHERE inc_estado_incidencia_id = @id_estado_ult)
					SET @ordenNew = (SELECT orden FROM inc_estado_incidencia WHERE inc_estado_incidencia_id = @id_estado_jira)

					IF @ordenOld < @ordenNew
					 BEGIN
						INSERT INTO inc_incidencia_seguimiento (inc_incidencia_id, fecha, hora, observacion, inc_estado_incidencia_id, is_deleted, created, updated, updated_by)
						SELECT
							@inc_incidencia_id,
							@fecha_act,
							CONVERT(VARCHAR(5), @fecha_act, 108),
							'Actualizado por el Sistema por modificación en Jira.',
							@id_estado_jira,
							0,
							GETDATE(),
							GETDATE(),
							1
					 END
				 END
			 END
		 END

		FETCH NEXT FROM CURSOR_INC INTO 
			@inc_incidencia_id, 
			@codigo_jira, 
			@inc_estado_incidencia_id, 
			@pry_proyecto_id

	 END

	CLOSE CURSOR_INC  
	DEALLOCATE CURSOR_INC

GO

