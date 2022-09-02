/*
Creado por: Jorge Felix
Fecha Creacion: 27/01/2021
Descripcion: SP para gráfico de barras de incidencias pendientes por rango de dias <1, <1,3>, <3
Parametros: @usuario   -    ID Usuario
[dbo].[pr_pa_graf_pendientes_dias] 2

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/

CREATE procedure [dbo].[pr_pa_graf_pendientes_dias]
@usuario numeric(10,0)

AS

SET NOCOUNT ON;

DECLARE @cliente_id numeric(10,0)

SELECT TOP 1 
	@cliente_id = ISNULL(id_empresa,0) 
FROM SC_USER 
WHERE SC_USER_ID = @usuario

CREATE TABLE #temporal (estado varchar(200), rango varchar(200), num int)
CREATE TABLE #filtro (estado_id numeric(10,0))

IF @cliente_id = 0
 BEGIN
	INSERT INTO #filtro
	SELECT pa_pase_estado_id
	FROM pa_pase_estado
	WHERE 
		is_deleted = 0 AND 
		pa_pase_estado_id NOT IN (9,10004) -- Culminado, Cancelado
 END
ELSE
 BEGIN
	INSERT INTO #filtro
	SELECT pa_pase_estado_id
	FROM pa_pase_estado
	WHERE 
		is_deleted = 0 AND 
		(pa_pase_estado_id NOT IN (9,10004) AND pa_pase_estado_id >= 5) -- Culminado, Cancelado / Pasado a Cliente
 END

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
	pe.nombre,
	CASE 
		WHEN (DATEDIFF(day, p.fecha_solicitud , getdate()) >= 0 and DATEDIFF(day, p.fecha_solicitud , getdate()) <= 1) THEN '[0,1]'
		WHEN (DATEDIFF(day, p.fecha_solicitud , getdate()) >= 2 and DATEDIFF(day, p.fecha_solicitud , getdate()) <= 5) THEN '[2,5]'
		WHEN (DATEDIFF(day, p.fecha_solicitud , getdate()) >= 6 and DATEDIFF(day, p.fecha_solicitud , getdate()) <= 10) THEN '[6,10]'
		WHEN DATEDIFF(day, p.fecha_solicitud , getdate()) > 10 THEN '>10'
	END,
	1
FROM pa_pase p
	INNER JOIN pry_proyecto pr ON pr.pry_proyecto_id = p.pry_proyecto_id
	INNER JOIN pa_pase_estado pe ON pe.pa_pase_estado_id = p.pa_pase_estado_id
WHERE
	p.is_deleted = 0 AND
	pe.is_deleted = 0 AND
	p.pa_pase_estado_id IN (SELECT * FROM #filtro) AND
	(pr.fb_cliente_id = @cliente_id OR @cliente_id = 0)


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

