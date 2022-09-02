/*
Creado por: Valky Salinas
Fecha Creacion: 20/05/2020
Descripcion: Retorna los años de los proyectos existentes
[pr_jira_obtiene_annos] 1

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/


CREATE PROCEDURE [dbo].[pr_jira_obtiene_annos]
@fb_uea_pe_id numeric(10,0)
AS
BEGIN

	SELECT DISTINCT YEAR(fecha_inicio_estimada) Anno
	FROM pry_proyecto
	WHERE is_deleted = 0
	ORDER BY 1 DESC

END

GO

