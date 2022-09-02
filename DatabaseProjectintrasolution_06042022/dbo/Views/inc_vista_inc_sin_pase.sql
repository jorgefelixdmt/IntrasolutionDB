
CREATE VIEW [dbo].[inc_vista_inc_sin_pase] AS
SELECT 
	inc.inc_incidencia_id,
	inc.descripcion_incidente,
	inc.codigo_ticket,
	inc.codigo_jira,
	pr.nombre as proyecto,
	ei.nombre as estado,
	inc.owner_id,
	inc.created,
	inc.created_by,
	inc.updated,
	inc.updated_by,
	inc.is_deleted
FROM inc_incidencia inc
	INNER JOIN pry_proyecto pr ON inc.pry_proyecto_id = pr.pry_proyecto_id
	INNER JOIN inc_estado_incidencia ei ON inc.inc_estado_incidencia_id = ei.inc_estado_incidencia_id
WHERE 
	inc.is_deleted = 0 AND
	inc.inc_estado_incidencia_id >= 80 AND
	inc.codigo_jira NOT IN (
							SELECT codigo_jira
							FROM pa_pase_asociado
							WHERE is_deleted = 0
	                       )

GO

