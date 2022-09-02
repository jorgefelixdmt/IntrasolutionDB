/*
Creado por: Valky Salinas
Fecha Creacion: 20/05/2020
Descripcion: Retorna la cantidad de tareas de Jira dado un cliente y las divide por estado
[pr_pry_jira_inc_pend_cliente] 0,'01/01/2019','12/12/2020'

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------
23/05/2020             Valky Salinas      Si no hay datos, devuelve una tabla vacía.

25/05/2020             Valky Salinas      Se cogen todos los registros del año actual y el anterior.

*****************************************************************************************************************************

*/


CREATE PROCEDURE [dbo].[pr_pry_jira_inc_pend_cliente]
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

	CREATE TABLE #temporal (proyecto varchar(200), estado_tarea varchar(200), cantidad int)

	DECLARE @columns NVARCHAR(MAX) = '';

	IF EXISTS ( SElECT pr.codigo FROM pry_proyecto pr
					INNER JOIN pry_proyecto_jira pj ON pj.proyecto_IS_id = pr.pry_proyecto_id
				WHERE pr.is_deleted = 0 AND pj.is_deleted = 0 AND (pr.fb_cliente_id = @fb_cliente_id OR @fb_cliente_id = 0))
	 BEGIN
		SET @columns = STUFF((
								SELECT ',' + QUOTENAME(tab.codigo) 
								FROM
									(
										SELECT DISTINCT pr.codigo codigo
										FROM pry_proyecto pr
											INNER JOIN pry_proyecto_jira pj ON pj.proyecto_IS_id = pr.pry_proyecto_id
											INNER JOIN DTECH_185.jira_db.dbo.project jpr ON pj.proyecto_J_id = jpr.ID
											INNER JOIN DTECH_185.jira_db.dbo.jiraissue ji ON jpr.ID = ji.PROJECT
											INNER JOIN DTECH_185.jira_db.dbo.issuetype jit ON jit.ID = ji.issuetype
											INNER JOIN pry_proyecto_jira_tipo_tarea ittj ON ittj.tipo_tarea_J_id = jit.ID
											INNER JOIN DTECH_185.jira_db.dbo.issuestatus jie ON jie.ID = ji.issuestatus
											INNER JOIN pry_proyecto_jira_estado_tarea ietj ON ietj.estado_tarea_J_id = jie.STATUSCATEGORY
											INNER JOIN DTECH_185.jira_db.dbo.label jl ON ji.ID = jl.ISSUE
										WHERE 
											pr.is_deleted = 0 AND pj.is_deleted = 0 AND 
											(pr.fb_cliente_id = @fb_cliente_id OR @fb_cliente_id = 0) AND
											(ji.CREATED BETWEEN @inicio AND @fin) AND
											ietj.estado_tarea_IS_id IN (1,3) AND -- estado abierto y en progreso
											ittj.tipo_tarea_IS_id = 1 AND -- tareas padre
											jl.LABEL = 'INCIDENCIA'
									) tab
								FOR XML PATH(''), TYPE
								).value('.', 'NVARCHAR(MAX)') 
							,1,1,'')

		INSERT INTO #temporal
		SELECT 
			ipr.codigo proyecto,
			ietj.estado_tarea_IS_descripcion estado_tarea,
			COUNT(*) cantidad
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
		WHERE
			ipr.is_deleted = 0 AND
			ipj.is_deleted = 0 AND
			ic.is_deleted = 0 AND
			ittj.is_deleted = 0 AND
			ietj.is_deleted = 0 AND
			(ic.fb_cliente_id =  @fb_cliente_id OR @fb_cliente_id = 0) AND
			(ji.CREATED BETWEEN @inicio AND @fin) AND
			ietj.estado_tarea_IS_id IN (1,3) AND -- estado abierto y en progreso
			ittj.tipo_tarea_IS_id = 1 AND -- tareas padre
			jl.LABEL = 'INCIDENCIA'
		GROUP BY ipr.codigo, ietj.estado_tarea_IS_descripcion

		IF EXISTS( SELECT * FROM #temporal) 
		 BEGIN
			DECLARE @sql NVARCHAR(MAX)

			SET @sql ='
			SELECT * FROM (
			  SELECT 
					proyecto,
					estado_tarea,
					cantidad
			  FROM #temporal
			) p
			PIVOT (
			  SUM(cantidad)
			  FOR proyecto in ('+ @columns +')
			) as pivot_table';

			EXECUTE sp_executesql @sql;
		 END
		ELSE
		 BEGIN
			SELECT *
			FROM #temporal
		 END

	 END
	ELSE
	 BEGIN
		SELECT *
		FROM #temporal
	 END

	
END

GO

