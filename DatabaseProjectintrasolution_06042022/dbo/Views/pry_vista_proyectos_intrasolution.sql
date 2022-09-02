CREATE VIEW pry_vista_proyectos_intrasolution AS

SELECT DISTINCT 
	pr.pry_proyecto_id, 
	pr.codigo, 
	pr.nombre,
	pr.owner_id,
	pr.created,
	pr.created_by,
	pr.updated,
	pr.updated_by,
	pr.is_deleted
FROM inc_incidencia inc
	INNER JOIN pry_proyecto pr ON inc.pry_proyecto_id = pr.pry_proyecto_id
WHERE inc.is_deleted = 0

GO

