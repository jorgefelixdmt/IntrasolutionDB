



CREATE VIEW [dbo].[inc_vista_jira_sin_is] AS
SELECT 
	ROW_NUMBER() over (order by jira) as inc_incidencia_id, 
	*,
	1 as owner_id,
	NULL as created,
	1 as created_by,
	NULL as updated,
	1 as updated_by,
	0 as is_deleted
FROM
 (
	SELECT *
	FROM
		(
			SELECT 
				jpr.pkey + '-' + CONVERT(varchar(50),ji.issuenum) as jira,
				ji.SUMMARY incidencia,
				'' as ticket,
				'' as proyecto,
				CASE
					WHEN ietj.estado_tarea_IS_id = 1 THEN 'Abierto'
					WHEN ietj.estado_tarea_IS_id = 3 THEN 'En Progreso'
					ELSE ''
				END as estado
			FROM DTECH_185.jira_db.dbo.jiraissue ji
				INNER JOIN DTECH_185.jira_db.dbo.project jpr ON jpr.ID = ji.PROJECT
				INNER JOIN pry_proyecto_jira ipj ON ipj.proyecto_J_id = jpr.ID
				INNER JOIN DTECH_185.jira_db.dbo.issuetype jit ON jit.ID = ji.issuetype
				INNER JOIN pry_proyecto_jira_tipo_tarea ittj ON ittj.tipo_tarea_J_id = jit.ID
				INNER JOIN DTECH_185.jira_db.dbo.label jl ON ji.ID = jl.ISSUE
				INNER JOIN DTECH_185.jira_db.dbo.issuestatus jie ON jie.ID = ji.issuestatus
				INNER JOIN pry_proyecto_jira_estado_tarea ietj ON ietj.estado_tarea_J_id = jie.STATUSCATEGORY
			WHERE
				ittj.is_deleted = 0 AND
				ittj.tipo_tarea_IS_id = 1 AND -- tareas padre
				ietj.estado_tarea_IS_id IN (1,3) AND -- estado abierto y en progreso
				(jl.LABEL = 'INCIDENCIA' or jl.LABEL = 'MEJORA' or jl.LABEL = 'INTERNO' or jl.LABEL = 'REQUERIMIENTO' or jl.LABEL = 'QUEJA-RECLAMO')
		) ji
	WHERE
		ji.jira NOT IN (
							SELECT codigo_jira
							FROM inc_incidencia
							WHERE is_deleted = 0
					   )

	UNION

	SELECT 
		ji.jira,
		ji.incidencia,
		(
			SELECT TOP 1 codigo_ticket
			FROM inc_incidencia inc
			WHERE 
				ji.jira = inc.codigo_jira AND 
				is_deleted = 0
		) as ticket,
		(
			SELECT TOP 1 pr.nombre
			FROM inc_incidencia inc
				INNER JOIN pry_proyecto pr ON inc.pry_proyecto_id = pr.pry_proyecto_id
			WHERE 
				ji.jira = inc.codigo_jira AND
				inc.is_deleted = 0
		) as proyecto,
		(
			SELECT TOP 1 ei.nombre
			FROM inc_incidencia_seguimiento ise
				INNER JOIN inc_incidencia inc ON ise.inc_incidencia_id = inc.inc_incidencia_id
				INNER JOIN inc_estado_incidencia ei ON ise.inc_estado_incidencia_id = ei.inc_estado_incidencia_id
			WHERE 
				ise.is_deleted = 0 AND
				inc.is_deleted = 0 AND
				ji.jira = inc.codigo_jira
			ORDER BY ise.created DESC
		) as estado
	FROM
		(
			SELECT 
				jpr.pkey + '-' + CONVERT(varchar(50),ji.issuenum) as jira,
				ji.SUMMARY incidencia
			FROM DTECH_185.jira_db.dbo.jiraissue ji
				INNER JOIN DTECH_185.jira_db.dbo.project jpr ON jpr.ID = ji.PROJECT
				INNER JOIN pry_proyecto_jira ipj ON ipj.proyecto_J_id = jpr.ID
				INNER JOIN DTECH_185.jira_db.dbo.issuetype jit ON jit.ID = ji.issuetype
				INNER JOIN pry_proyecto_jira_tipo_tarea ittj ON ittj.tipo_tarea_J_id = jit.ID
				INNER JOIN DTECH_185.jira_db.dbo.label jl ON ji.ID = jl.ISSUE
				INNER JOIN DTECH_185.jira_db.dbo.issuestatus jie ON jie.ID = ji.issuestatus
				INNER JOIN pry_proyecto_jira_estado_tarea ietj ON ietj.estado_tarea_J_id = jie.STATUSCATEGORY
			WHERE
				ittj.is_deleted = 0 AND
				ittj.tipo_tarea_IS_id = 1 AND -- tareas padre
				ietj.estado_tarea_IS_id = 2 AND -- estado cerrado
				jl.LABEL in ( 'INCIDENCIA','MEJORA', 'INTERNO', 'REQUERIMIENTO','QUEJA-RECLAMO')
		) ji
	WHERE
		ji.jira IN (
						SELECT inc.codigo_jira
						FROM inc_incidencia inc
						WHERE 
							inc.is_deleted = 0 AND
							(
								SELECT TOP 1 inc_estado_incidencia_id
								FROM inc_incidencia_seguimiento ise
								WHERE 
									ise.is_deleted = 0 AND
									ise.inc_incidencia_id = inc.inc_incidencia_id
								ORDER BY created DESC
							) NOT IN (8,9) -- Culminado o Anulado
				   )
) tab

GO

