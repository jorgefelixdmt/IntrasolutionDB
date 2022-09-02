/*
Creado por: Valky Salinas
Fecha Creacion: 25/05/2020
Descripcion: Retorna la cantidad de pases dado un cliente y las divide por estado
[pr_pa_pase_pend_cliente] 0,'01/01/2019','12/12/2020'

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/


CREATE PROCEDURE [dbo].[pr_pa_pase_pend_cliente]
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

	CREATE TABLE #temporal (proyecto varchar(200), estado_pase varchar(200), cantidad int)

	DECLARE @columns NVARCHAR(MAX) = '';

	IF EXISTS ( SElECT p.pa_pase_id FROM pa_pase p
					INNER JOIN fb_cliente c ON c.fb_cliente_id = p.fb_cliente_id
				WHERE p.is_deleted = 0 AND c.is_deleted = 0 AND (p.fb_cliente_id = @fb_cliente_id OR @fb_cliente_id = 0))
	 BEGIN
		SET @columns = STUFF((
								SELECT ',' + QUOTENAME(tab.codigo) 
								FROM
									(
										SELECT DISTINCT pr.codigo codigo
										FROM pa_pase pa
											INNER JOIN pry_proyecto pr ON pr.pry_proyecto_id = pa.pry_proyecto_id
										WHERE 
											pr.is_deleted = 0 AND pa.is_deleted = 0 AND 
											(pa.fb_cliente_id = @fb_cliente_id OR @fb_cliente_id = 0) AND
											(pa.fecha_solicitud BETWEEN @inicio AND @fin) AND
											pa.pa_pase_estado_id NOT IN (9,10004) -- culminado, cancelado
									) tab
								FOR XML PATH(''), TYPE
								).value('.', 'NVARCHAR(MAX)') 
							,1,1,'')

		INSERT INTO #temporal
		SELECT 
			pr.codigo proyecto,
			pe.codigo estado_pase,
			COUNT(*) cantidad
		FROM pa_pase pa
			INNER JOIN pry_proyecto pr ON pr.pry_proyecto_id = pa.pry_proyecto_id
			INNER JOIN pa_pase_estado pe ON pa.pa_pase_estado_id = pe.pa_pase_estado_id
		WHERE 
			pr.is_deleted = 0 AND pa.is_deleted = 0 AND pe.is_deleted = 0 AND
			(pa.fb_cliente_id = @fb_cliente_id OR @fb_cliente_id = 0) AND
			(pa.fecha_solicitud BETWEEN @inicio AND @fin) AND
			pa.pa_pase_estado_id NOT IN (9,10004) -- culminado, cancelado
		GROUP BY pr.codigo, pe.codigo

		IF EXISTS( SELECT * FROM #temporal) 
		 BEGIN
			DECLARE @sql NVARCHAR(MAX)

			SET @sql ='
				SELECT estado_pase,' + @columns + '
				FROM
					(
						SELECT * FROM (
						  SELECT 
								proyecto,
								estado_pase,
								cantidad
						  FROM #temporal
						) p
						PIVOT (
						  SUM(cantidad)
						  FOR proyecto in ('+ @columns +')
						) as pivot_table
					) t
				  INNER JOIN pa_pase_estado pe ON pe.codigo = t.estado_pase
				ORDER BY pe.orden DESC';

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

