/*
Creado por: Valky Salinas
Fecha Creacion: 25/05/2020
Descripcion: Retorna los años de las tablas de pases
[pr_home_obtiene_annos_pases] 1

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/


CREATE PROCEDURE [dbo].[pr_home_obtiene_annos_pases]
@fb_uea_pe_id numeric(10,0)
AS
BEGIN

	SELECT DISTINCT YEAR(fecha_solicitud) Anno
	FROM pa_pase
	WHERE is_deleted = 0
	ORDER BY 1 DESC

END

GO

