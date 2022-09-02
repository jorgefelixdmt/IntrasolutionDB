/*
Creado por: Jorge Felix
Fecha Creacion: 28/01/2021
Descripcion: SP para gráfico de barras de incidencias pendientes por responsables
Parametros: @usuario   -    ID Usuario
[dbo].[pr_inc_graf_pendientes_responsable] 8

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/

CREATE procedure [dbo].[pr_inc_graf_pendientes_responsable]
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

CREATE TABLE #temporal (responsable varchar(200), estado varchar(200), cantidad int)

DECLARE @columns NVARCHAR(MAX) = '';


SET @columns = STUFF((
								SELECT ',' + QUOTENAME(tab.responsable) 
								FROM
									(
										SELECT DISTINCT
											CASE 
												WHEN i.fb_empleado_id IS NULL then 'Sin Asignar'
												ELSE e.nombreCompleto
											END as responsable
										FROM inc_incidencia i
											INNER JOIN inc_estado_incidencia ei ON ei.inc_estado_incidencia_id = i.inc_estado_incidencia_id
											LEFT JOIN fb_empleado e ON e.fb_empleado_id = i.fb_empleado_id
										WHERE
											i.is_deleted = 0 AND
											ei.is_deleted = 0 AND
											ei.inc_estado_incidencia_id NOT IN (9,10002) AND -- 10002:Culminado, 9:Anulado
											(i.inc_tipo_incidencia_id = @tipoinc OR @tipoinc = 0) AND
											(i.ambito = @ambito OR @ambito = 'A') AND
											(i.fb_cliente_id = @cliente_id OR @cliente_id = 0)
									) tab
								FOR XML PATH(''), TYPE
								).value('.', 'NVARCHAR(MAX)') 
							,1,1,'')

INSERT INTO #temporal
SELECT 
	CASE 
		WHEN i.fb_empleado_id IS NULL then 'Sin Asignar'
		ELSE e.nombreCompleto
	END as responsable,
	ei.nombre as estado,
	1 as cantidad
FROM inc_incidencia i
	INNER JOIN inc_estado_incidencia ei ON ei.inc_estado_incidencia_id = i.inc_estado_incidencia_id
	LEFT JOIN fb_empleado e ON e.fb_empleado_id = i.fb_empleado_id
WHERE
	i.is_deleted = 0 AND
	ei.is_deleted = 0 AND
	ei.inc_estado_incidencia_id NOT IN (9,10002) AND -- 10002:Culminado, 9:Anulado
	(i.inc_tipo_incidencia_id = @tipoinc OR @tipoinc = 0) AND
	(i.ambito = @ambito OR @ambito = 'A') AND
	(i.fb_cliente_id = @cliente_id OR @cliente_id = 0) 


IF EXISTS( SELECT * FROM #temporal) 
 BEGIN
	DECLARE @sql NVARCHAR(MAX)

	SET @sql ='
	SELECT * FROM (
		SELECT 
			responsable,
			estado,
			cantidad
		FROM #temporal
	) p
	PIVOT (
		COUNT(cantidad)
		FOR responsable in ('+ @columns +')
	) as pivot_table';

	EXECUTE sp_executesql @sql;
 END
ELSE
 BEGIN
	SELECT *
	FROM #temporal
 END

GO

