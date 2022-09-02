/*
Creado por: Valky Salinas
Fecha Creacion: 23/05/2020
Descripcion: SP que devuelve las ventaspor cliente
Parametros: @Anho   -    Año
[dbo].[pr_fnz_ventas_cliente] 2020

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/

CREATE procedure [dbo].[pr_fnz_ventas_cliente]
@Anho int

AS

SELECT 
	c.nombre cliente,
	SUM(ISNULL(monto_soles,0) / dbo.fn_TipoCambio(fecha_factura) + ISNULL(monto_dolares,0)) cantidad
FROM fnz_venta V
	INNER JOIN fb_cliente c ON v.fb_cliente_id = c.fb_cliente_id
WHERE 
	v.is_deleted = 0 AND
	c.is_deleted = 0 AND
	YEAR(fecha_factura) = @Anho
GROUP BY c.nombre

GO

