/*
Creado por: Valky Salinas
Fecha Creacion: 03/07/2020
Descripcion: SP que devuelve data de gráficos de pases pendientes por estado
Parametros: @usuario   -    ID Usuario
[dbo].[pr_pa_pendientes_estado] 1

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/

CREATE procedure [dbo].[pr_pa_pendientes_estado]
@usuario numeric(10,0)

AS

SET NOCOUNT ON;

DECLARE @cliente_id numeric(10,0)

SELECT TOP 1 
	@cliente_id = ISNULL(id_empresa,0) 
FROM SC_USER 
WHERE SC_USER_ID = @usuario

CREATE TABLE #temporal (proyecto varchar(200), estado varchar(200), num int)
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
								SELECT ',' + QUOTENAME(tab.proyecto) 
								FROM
									(
										SELECT DISTINCT
											pr.codigo as proyecto
										FROM pa_pase p
											INNER JOIN pry_proyecto pr ON pr.pry_proyecto_id = p.pry_proyecto_id
											INNER JOIN pa_pase_estado pe ON pe.pa_pase_estado_id = p.pa_pase_estado_id
										WHERE
											p.is_deleted = 0 AND
											pr.is_deleted = 0 AND
											pe.is_deleted = 0 AND
											p.pa_pase_estado_id IN (SELECT * FROM #filtro) AND 
											(pr.fb_cliente_id = @cliente_id OR @cliente_id = 0)
									) tab
								FOR XML PATH(''), TYPE
								).value('.', 'NVARCHAR(MAX)') 
							,1,1,'')

INSERT INTO #temporal
SELECT 
	pr.codigo,
	pe.nombre,
	1
FROM pa_pase p
	INNER JOIN pry_proyecto pr ON pr.pry_proyecto_id = p.pry_proyecto_id
	INNER JOIN pa_pase_estado pe ON pe.pa_pase_estado_id = p.pa_pase_estado_id
WHERE
	p.is_deleted = 0 AND
	pr.is_deleted = 0 AND
	pe.is_deleted = 0 AND
	p.pa_pase_estado_id IN (SELECT * FROM #filtro) AND
	(pr.fb_cliente_id = @cliente_id OR @cliente_id = 0)

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

