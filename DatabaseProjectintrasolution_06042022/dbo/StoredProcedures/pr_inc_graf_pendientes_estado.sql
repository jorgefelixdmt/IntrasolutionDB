/*
Creado por: Valky Salinas
Fecha Creacion: 03/07/2020
Descripcion: SP para gráfico de barras de incidencias pendientes por Estado
Parametros: @usuario   -    ID Usuario
[dbo].[pr_inc_graf_pendientes_estado] 2

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/

CREATE procedure [dbo].[pr_inc_graf_pendientes_estado]
@usuario numeric(10,0),
@tipoinc numeric(10,0),
@ambito varchar(10)

AS

SET NOCOUNT ON;

DECLARE @cliente_id numeric(10,0)

SELECT TOP 1 
	@cliente_id = ISNULL(id_empresa,0) 
FROM SC_USER 
WHERE SC_USER_ID = @usuario

CREATE TABLE #temporal (proyecto varchar(200), estado varchar(200), num int)

DECLARE @columns NVARCHAR(MAX) = '';

SET @columns = STUFF((
								SELECT ',' + QUOTENAME(tab.proyecto) 
								FROM
									(
										SELECT DISTINCT
											ISNULL(pr.codigo,'Sin Proyecto') as proyecto
										FROM inc_incidencia i
											LEFT JOIN pry_proyecto pr ON pr.pry_proyecto_id = i.pry_proyecto_id
											INNER JOIN inc_estado_incidencia ei ON ei.inc_estado_incidencia_id = i.inc_estado_incidencia_id
										WHERE
											i.is_deleted = 0 AND
											ei.is_deleted = 0 AND
											ei.inc_estado_incidencia_id NOT IN (9,10002) AND -- Culminado, Anulado
											(i.inc_tipo_incidencia_id = @tipoinc OR @tipoinc = 0) AND
											(i.ambito = @ambito OR @ambito = 'A') AND
											(i.fb_cliente_id = @cliente_id OR @cliente_id = 0)
									) tab
								FOR XML PATH(''), TYPE
								).value('.', 'NVARCHAR(MAX)') 
							,1,1,'')

INSERT INTO #temporal
SELECT 
	ISNULL(pr.codigo,'Sin Proyecto'),
	ei.nombre,
	1
FROM inc_incidencia i
	LEFT JOIN pry_proyecto pr ON pr.pry_proyecto_id = i.pry_proyecto_id
	INNER JOIN inc_estado_incidencia ei ON ei.inc_estado_incidencia_id = i.inc_estado_incidencia_id
WHERE
	i.is_deleted = 0 AND
	ei.is_deleted = 0 AND
	ei.inc_estado_incidencia_id NOT IN (9,10002) AND -- Anulado, Culminado
	(i.inc_tipo_incidencia_id = @tipoinc OR @tipoinc = 0) AND
	(i.ambito = @ambito OR @ambito = 'A') AND
	(i.fb_cliente_id = @cliente_id OR @cliente_id = 0)


IF EXISTS( SELECT * FROM #temporal) 
 BEGIN
	DECLARE @sql NVARCHAR(MAX)

	SET @sql ='
	SELECT * FROM (
		SELECT 
			proyecto,
			estado,
			num
		FROM #temporal
	) p
	PIVOT (
		COUNT(num)
		FOR proyecto in ('+ @columns +')
	) as pivot_table';

	EXECUTE sp_executesql @sql;
 END
ELSE
 BEGIN
	SELECT *
	FROM #temporal
 END

GO

