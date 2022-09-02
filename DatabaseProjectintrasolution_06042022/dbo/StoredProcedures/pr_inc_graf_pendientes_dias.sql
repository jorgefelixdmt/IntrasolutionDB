/*
Creado por: Jorge Felix
Fecha Creacion: 27/01/2021
Descripcion: SP para gráfico de barras de incidencias pendientes por rango de dias <1, <1,3>, <3
Parametros: @usuario   -    ID Usuario
[dbo].[pr_inc_graf_pendientes_dias] 2

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/

CREATE procedure [dbo].[pr_inc_graf_pendientes_dias]
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

CREATE TABLE #temporal (estado varchar(200), rango varchar(200), num int)

DECLARE @columns NVARCHAR(MAX) = '';

SET @columns = STUFF((
								SELECT ',' + QUOTENAME(tab.rango) 
								FROM
									(
										SELECT '[0,1]' as rango
										UNION
										SELECT'[2,5]'
										UNION
										SELECT'[6,10]'
										UNION
										SELECT'>10'
									) tab
								FOR XML PATH(''), TYPE
								).value('.', 'NVARCHAR(MAX)') 
							,1,1,'')

INSERT INTO #temporal
SELECT 
	ei.nombre,
	CASE 
		WHEN (DATEDIFF(day, i.fecha , getdate()) >= 0 and DATEDIFF(day, i.fecha , getdate()) <= 1) THEN '[0,1]'
		WHEN (DATEDIFF(day, i.fecha , getdate()) >= 2 and DATEDIFF(day, i.fecha , getdate()) <= 5) THEN '[2,5]'
		WHEN (DATEDIFF(day, i.fecha , getdate()) >= 6 and DATEDIFF(day, i.fecha , getdate()) <= 10) THEN '[6,10]'
		WHEN DATEDIFF(day, i.fecha , getdate()) > 10 THEN '>10'
	END,
	1
FROM inc_incidencia i
	INNER JOIN inc_estado_incidencia ei ON ei.inc_estado_incidencia_id = i.inc_estado_incidencia_id
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
			estado,
			rango,
			num
		FROM #temporal
	) p
	PIVOT (
		COUNT(num)
		FOR rango in ('+ @columns +')
	) as pivot_table';

	EXECUTE sp_executesql @sql;
 END
ELSE
 BEGIN
	SELECT *
	FROM #temporal
 END

GO

