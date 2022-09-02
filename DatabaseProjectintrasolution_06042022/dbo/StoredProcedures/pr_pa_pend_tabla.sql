/*
Creado por: Valky Salinas
Fecha Creacion: 25/05/2020
Descripcion: Retorna los pases dado un cliente y un rango
[pr_pa_pend_tabla] 0,'01/01/2020','12/12/2020'

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------
25/05/2020             Valky Salinas      Se cogen todos los registros del año actual y el anterior.

*****************************************************************************************************************************

*/


CREATE PROCEDURE [dbo].[pr_pa_pend_tabla]
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

	SELECT 
		pr.codigo + ': ' + pr.nombre proyecto,
		dbo.uf_format_string_to_json(pa.descripcion) descripcion,
		pa.codigo_jira codigo_jira,
		CONVERT(varchar, pa.fecha_solicitud, 103) fecha,
		pe.nombre estado,
		DATEDIFF(day, pa.fecha_solicitud, GETDATE()) dias
	FROM pa_pase pa
			INNER JOIN pry_proyecto pr ON pr.pry_proyecto_id = pa.pry_proyecto_id
			INNER JOIN pa_pase_estado pe ON pa.pa_pase_estado_id = pe.pa_pase_estado_id
	WHERE 
		pr.is_deleted = 0 AND pa.is_deleted = 0 AND pe.is_deleted = 0 AND
		(pa.fb_cliente_id = @fb_cliente_id OR @fb_cliente_id = 0) AND
		(pa.fecha_solicitud BETWEEN @inicio AND @fin) AND
		pa.pa_pase_estado_id NOT IN (9,10004) -- culminado, cancelado
	ORDER BY pa.fecha_solicitud
	
END

GO

