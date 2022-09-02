

CREATE VIEW pry_vista_proyectos_jira AS

SELECT DISTINCT 
	jpr.ID pry_proyecto_id, 
	jpr.pkey, 
	jpr.pname,
	pr.owner_id,
	pr.created,
	pr.created_by,
	pr.updated,
	pr.updated_by,
	pr.is_deleted
FROM inc_incidencia inc
	INNER JOIN pry_proyecto pr ON inc.pry_proyecto_id = pr.pry_proyecto_id
	INNER JOIN pry_proyecto_jira pj ON pj.proyecto_IS_id = pr.pry_proyecto_id
	INNER JOIN DTECH_185.jira_db.dbo.project jpr ON pj.proyecto_J_id = jpr.ID
WHERE inc.is_deleted = 0

GO

