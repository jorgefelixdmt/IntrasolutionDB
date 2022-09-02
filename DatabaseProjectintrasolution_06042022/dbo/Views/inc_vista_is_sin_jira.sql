CREATE VIEW inc_vista_is_sin_jira AS
SELECT
	inc.inc_incidencia_id,
	inc.codigo_ticket,
	inc.codigo_jira,
	pr.nombre as proyecto,
	(
		SELECT TOP 1 ei.nombre
		FROM inc_incidencia_seguimiento ise
			INNER JOIN inc_estado_incidencia ei ON ise.inc_estado_incidencia_id = ei.inc_estado_incidencia_id
		WHERE
			ise.is_deleted = 0
		ORDER BY ise.created DESC
	) as estado,
	inc.owner_id,
	inc.created,
	inc.created_by,
	inc.updated,
	inc.updated_by,
	inc.is_deleted
FROM inc_incidencia inc
	INNER JOIN pry_proyecto pr ON inc.pry_proyecto_id = pr.pry_proyecto_id
WHERE 
	inc.codigo_jira = '' AND
	inc.is_deleted = 0

GO

