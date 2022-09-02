/*
Creado por: Valky Salinas
Fecha Creacion: 03/07/2020
Descripcion: SP que devuelve una lista de los proyectos vigentes
Parametros: @usuario   -    ID Usuario
[dbo].[pr_inc_lista_pendientes] 1,0,'A'

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/

CREATE procedure [dbo].[pr_inc_lista_pendientes]
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

SELECT 
	pr.codigo as proyecto,
	i.codigo_ticket + ': ' + LEFT(i.descripcion_incidente,60) as incidencia,
	CONVERT(VARCHAR,i.fecha,103) as fecha,
	CONVERT(VARCHAR,i.fecha,103) + ' - ' + ei.nombre as estado,
	p.codigo_jira as cod_pase,
	pe.nombre + ' - ' + CONVERT(VARCHAR,p.fecha_estado,103) as estado_pase
FROM inc_incidencia i
	LEFT JOIN pa_pase_asociado pa ON pa.codigo_jira = i.codigo_jira
	LEFT JOIN pa_pase p ON p.pa_pase_id = pa.pa_pase_id
	INNER JOIN pry_proyecto pr ON pr.pry_proyecto_id = i.pry_proyecto_id
	INNER JOIN inc_estado_incidencia ei ON ei.inc_estado_incidencia_id = i.inc_estado_incidencia_id
	LEFT JOIN pa_pase_estado pe ON pe.pa_pase_estado_id = p.pa_pase_estado_id
WHERE
	i.is_deleted = 0 AND
	pr.is_deleted = 0 AND
	ei.is_deleted = 0 AND
	ei.inc_estado_incidencia_id NOT IN (9,10002) AND -- Culminado, Anulado
	(i.inc_tipo_incidencia_id = @tipoinc OR @tipoinc = 0) AND
	(i.ambito = @ambito OR @ambito = 'A') AND
	(i.fb_cliente_id = @cliente_id OR @cliente_id = 0)

GO

