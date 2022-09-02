/*
Creado por: Valky Salinas
Fecha Creacion: 23/05/2020
Descripcion: SP que devuelve las ventas por estado pendiente
Parametros: @Anho   -    Año
[dbo].[pr_fnz_ventas_estado] 2020

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/

CREATE procedure [dbo].[pr_fnz_ventas_estado]
@Anho int

AS

SELECT 
	e.nombre estado,
	SUM(ISNULL(monto_soles,0) / dbo.fn_TipoCambio(fecha_factura) + ISNULL(monto_dolares,0)) cantidad
FROM fnz_venta v
	INNER JOIN fnz_estado_venta e ON v.fnz_estado_venta_id = e.fnz_estado_venta_id
WHERE 
	v.is_deleted = 0 AND
	e.is_deleted = 0 AND
	e.fnz_estado_venta_id IN (1,2) AND -- Facturado y Por Pagar
	YEAR(fecha_factura) = @Anho
GROUP BY e.nombre

GO

