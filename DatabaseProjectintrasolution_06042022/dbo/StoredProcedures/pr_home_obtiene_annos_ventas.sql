/*
Creado por: Valky Salinas
Fecha Creacion: 23/05/2020
Descripcion: Retorna los años de las tablas de ventas
[pr_jira_obtiene_annos] 1

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/


CREATE PROCEDURE [dbo].[pr_home_obtiene_annos_ventas]
@fb_uea_pe_id numeric(10,0)
AS
BEGIN

	SELECT DISTINCT YEAR(fecha_factura) Anno
	FROM fnz_venta
	WHERE is_deleted = 0
	ORDER BY 1 DESC

END

GO

