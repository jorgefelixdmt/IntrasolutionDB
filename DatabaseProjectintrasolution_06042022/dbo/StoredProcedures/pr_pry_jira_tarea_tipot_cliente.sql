/*
Creado por: Valky Salinas
Fecha Creacion: 20/05/2020
Descripcion: Retorna la cantidad de tareas de Jira dado un cliente y las divide por tipo
[pr_pry_jira_tarea_tipot_cliente] 1,1,'01/01/2019','12/12/2020'

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/


CREATE PROCEDURE [dbo].[pr_pry_jira_tarea_tipot_cliente]
	@fb_cliente_id numeric(10,0), 
	@estado numeric(10,0), 
	@start varchar(100),
	@end varchar(100)
AS
BEGIN

	SET NOCOUNT ON;

	SET LANGUAGE Spanish;
	DECLARE @inicio date,@fin date
	SET @inicio = CONVERT(date,@start,103)
	SET @fin = CONVERT(date,@end,103)

	DECLARE @columns NVARCHAR(MAX) = '';

	IF EXISTS ( SELECT pr.codigo FROM pry_proyecto pr
					INNER JOIN pry_proyecto_jira pj ON pj.proyecto_IS_id = pr.pry_proyecto_id
				WHERE pr.is_deleted = 0 AND pj.is_deleted = 0 AND pr.fb_cliente_id = @fb_cliente_id)
	 BEGIN
		SET @columns = STUFF((
								SELECT ',' + QUOTENAME(pr.codigo) 
								FROM pry_proyecto pr
									INNER JOIN pry_proyecto_jira pj ON pj.proyecto_IS_id = pr.pry_proyecto_id
								WHERE pr.is_deleted = 0 AND pj.is_deleted = 0 AND pr.fb_cliente_id = @fb_cliente_id
								FOR XML PATH(''), TYPE
								).value('.', 'NVARCHAR(MAX)') 
							,1,1,'')
	 END
	ELSE
	 BEGIN
		SET @columns = STUFF((
								SELECT ',' + QUOTENAME(codigo) 
								FROM fb_cliente
								WHERE is_deleted = 0 AND fb_cliente_id = @fb_cliente_id
								FOR XML PATH(''), TYPE
								).value('.', 'NVARCHAR(MAX)') 
							,1,1,'')
	 END


	DECLARE @sql NVARCHAR(MAX)

	SET @sql ='
	SELECT * FROM (
	  SELECT 
			ipr.codigo proyecto,
			ittj.tipo_tarea_IS_descripcion tipo_tarea,
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
		WHERE
			ipr.is_deleted = 0 AND
			ipj.is_deleted = 0 AND
			ic.is_deleted = 0 AND
			ittj.is_deleted = 0 AND
			ietj.is_deleted = 0 AND
			ic.fb_cliente_id = ' + CONVERT(varchar(10), @fb_cliente_id) + 'AND
			(ji.CREATED BETWEEN ''' + CONVERT(varchar, @inicio, 103) + ''' AND ''' + CONVERT(varchar, @fin, 103) + ''') AND
			ietj.estado_tarea_IS_id = ' + CONVERT(varchar(10), @estado) + '
		GROUP BY ipr.codigo, ittj.tipo_tarea_IS_descripcion
	) p
	PIVOT (
	  SUM(cantidad)
	  FOR proyecto in ('+ @columns +')
	) as pivot_table';

	EXECUTE sp_executesql @sql;

END

GO

