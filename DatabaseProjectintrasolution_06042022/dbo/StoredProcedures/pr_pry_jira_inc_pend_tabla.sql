/*
Creado por: Valky Salinas
Fecha Creacion: 21/05/2020
Descripcion: Retorna las incidencias de Jira dado un cliente y un rango
[pr_pry_jira_inc_pend_tabla] 0,'01/01/2019','12/12/2020'

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------
25/05/2020             Valky Salinas      Se cogen todos los registros del año actual y el anterior.

*****************************************************************************************************************************

*/


CREATE PROCEDURE [dbo].[pr_pry_jira_inc_pend_tabla]
	@fb_cliente_id numeric(10,0), 
	@start varchar(100),
	@end varchar(100)
AS
BEGIN

	SET NOCOUNT ON;

	SET LANGUAGE Spanish;
	DECLARE @inicio date,@fin date
	SET @inicio = CONVERT(date,@start,103)
	SET @fin = CONVERT(date,@end,103)

	SET @inicio = DATEADD(YEAR, -1, @inicio)

	DECLARE @base_url varchar(200)

	SELECT @base_url = propertyvalue 
	FROM DTECH_185.jira_db.dbo.propertystring 
	WHERE 
		ID IN (
				SELECT ID 
				FROM DTECH_185.jira_db.dbo.propertyentry 
				WHERE property_key LIKE '%baseurl%'
			  )

	SELECT 
		ipr.codigo codigo,
		ipr.nombre proyecto,
		jpr.pkey + '-' + CONVERT(varchar(50),ji.issuenum) + ': ' + ji.SUMMARY incidencia,
		@base_url + '/browse/' + jpr.pkey + '-' + CONVERT(varchar(50),ji.issuenum) url,
		CONVERT(varchar, ji.CREATED, 103) fecha,
		jp.pname prioridad,
		DATEDIFF(day, ji.CREATED, GETDATE()) dias
	FROM DTECH_185.jira_db.dbo.jiraissue ji
		INNER JOIN DTECH_185.jira_db.dbo.project jpr ON jpr.ID = ji.PROJECT
		INNER JOIN pry_proyecto_jira ipj ON ipj.proyecto_J_id = jpr.ID
		INNER JOIN pry_proyecto ipr ON ipr.pry_proyecto_id = ipj.proyecto_IS_id
		INNER JOIN fb_cliente ic ON ic.fb_cliente_id = ipr.fb_cliente_id
		INNER JOIN DTECH_185.jira_db.dbo.issuetype jit ON jit.ID = ji.issuetype
		INNER JOIN pry_proyecto_jira_tipo_tarea ittj ON ittj.tipo_tarea_J_id = jit.ID
		INNER JOIN DTECH_185.jira_db.dbo.issuestatus jie ON jie.ID = ji.issuestatus
		INNER JOIN pry_proyecto_jira_estado_tarea ietj ON ietj.estado_tarea_J_id = jie.STATUSCATEGORY
		INNER JOIN DTECH_185.jira_db.dbo.label jl ON ji.ID = jl.ISSUE
		INNER JOIN DTECH_185.jira_db.dbo.priority jp ON jp.ID = ji.PRIORITY
	WHERE
		ipr.is_deleted = 0 AND
		ipj.is_deleted = 0 AND
		ic.is_deleted = 0 AND
		ittj.is_deleted = 0 AND
		ietj.is_deleted = 0 AND
		(ic.fb_cliente_id = @fb_cliente_id OR @fb_cliente_id = 0) AND
		(ji.CREATED BETWEEN @inicio AND @fin) AND
		ietj.estado_tarea_IS_id IN (1,3) AND -- estado abierto y en progreso
		ittj.tipo_tarea_IS_id = 1 AND -- tareas padre
		jl.LABEL = 'INCIDENCIA'
	ORDER BY ji.CREATED
	
END

GO

