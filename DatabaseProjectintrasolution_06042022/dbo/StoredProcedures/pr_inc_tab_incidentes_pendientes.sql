/*
Creado por: Valky Salinas
Fecha Creacion: 22/02/2021
Descripcion: SP para tabla de incidencias pendientes
Parametros: @usuario   -    ID Usuario
[dbo].[pr_inc_tab_incidentes_pendientes] 1,0,'A'

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/

CREATE procedure [dbo].[pr_inc_tab_incidentes_pendientes]
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
	i.codigo_ticket ticket,
	i.codigo_jira jira,
	i.titulo_incidencia incidencia,
	ISNULL(p.codigo,'Sin Proyecto') proyecto,
	ISNULL(e.nombreCompleto,'Sin Responsable') responsable,
	ti.nombre tipo,
	CASE
		WHEN i.ambito = 'INT' THEN 'Interno'
		WHEN i.ambito = 'EXT' THEN 'Externo'
		ELSE NULL
	END ambito,
	ei.nombre estado,
	CONVERT(VARCHAR(10), i.fecha, 120) fecha,
	pa.codigo_jira as codigo_pase
FROM inc_incidencia i
	LEFT JOIN pry_proyecto p ON i.pry_proyecto_id = p.pry_proyecto_id
	LEFT JOIN inc_tipo_incidencia ti ON i.inc_tipo_incidencia_id = ti.inc_tipo_incidencia_id
	LEFT JOIN fb_empleado e ON i.fb_empleado_id = e.fb_empleado_id
	LEFT JOIN pa_pase_asociado paa ON paa.inc_incidencia_id = i.inc_incidencia_id and paa.is_deleted = 0
	LEFT JOIN pa_pase pa ON pa.pa_pase_id = paa.pa_pase_id
	INNER JOIN inc_estado_incidencia ei ON i.inc_estado_incidencia_id = ei.inc_estado_incidencia_id
WHERE
	i.is_deleted = 0 AND
	i.inc_estado_incidencia_id NOT IN (9,10002) AND -- 10002:Culminado, 9:Anulado
	(i.inc_tipo_incidencia_id = @tipoinc OR @tipoinc = 0) AND
	(i.ambito = @ambito OR @ambito = 'A') AND
	(i.fb_cliente_id = @cliente_id OR @cliente_id = 0)
ORDER BY i.fecha

GO

