/*
Creado por: Valky Salinas
Fecha Creacion: 03/07/2020
Descripcion: SP para gráfico de barras de incidencias pendientes por Estado
Parametros: @usuario   -    ID Usuario
            @anho      -    Año
[dbo].[pr_inc_estado_anho] 1,0

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/

CREATE procedure [dbo].[pr_inc_estado_anho]
@usuario numeric(10,0),
@anho int

AS

SET NOCOUNT ON;

DECLARE @cliente_id numeric(10,0)

SELECT TOP 1 
	@cliente_id = ISNULL(id_empresa,0) 
FROM SC_USER 
WHERE SC_USER_ID = @usuario


SELECT 
	ei.nombre estado,
	COUNT(*) cantidad
FROM inc_incidencia i
	LEFT JOIN pa_pase_asociado pa ON pa.codigo_jira = i.codigo_jira
	LEFT JOIN pa_pase p ON p.pa_pase_id = pa.pa_pase_id
	INNER JOIN pry_proyecto pr ON pr.pry_proyecto_id = i.pry_proyecto_id
	INNER JOIN inc_estado_incidencia ei ON ei.inc_estado_incidencia_id = i.inc_estado_incidencia_id
	LEFT JOIN pa_pase_estado pe ON pe.pa_pase_estado_id = p.pa_pase_estado_id
WHERE
	i.is_deleted = 0 AND
	pr.is_deleted = 0 AND
	pr.estado = 1 AND
	ei.is_deleted = 0 AND
	(i.fb_cliente_id = @cliente_id OR @cliente_id = 0) AND
	(YEAR(i.fecha) = @anho OR @anho = 0)
GROUP BY ei.nombre
ORDER BY ei.nombre

GO

