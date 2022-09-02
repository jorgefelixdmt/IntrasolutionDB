/*
Creado por: Valky Salinas
Fecha Creacion: 23/05/2020
Descripcion: SP que devuelve una lista de las facturas pendientes
Parametros: @Anho   -    Año
[dbo].[pr_fnz_lista_facturas_pendientes] 2020

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/

CREATE procedure [dbo].[pr_fnz_lista_facturas_pendientes]
@Anho int

AS

SELECT 
	v.numero_factura,
	CONVERT(varchar, v.fecha_factura, 103) fecha,
	c.codigo cliente,
	p.nombre proyecto,
	v.moneda,
	FORMAT(ISNULL(v.monto_soles,0) / dbo.fn_TipoCambio(v.fecha_factura) + ISNULL(v.monto_dolares,0), '#,#.00') monto,
	v.concepto_factura,
	DATEDIFF(day, v.fecha_factura, GETDATE()) dias
FROM fnz_venta v
	INNER JOIN fnz_estado_venta e ON v.fnz_estado_venta_id = e.fnz_estado_venta_id
	INNER JOIN fb_cliente c ON v.fb_cliente_id = c.fb_cliente_id
	INNER JOIN pry_proyecto p ON p.pry_proyecto_id = v.pry_proyecto_id
WHERE 
	v.is_deleted = 0 AND
	e.is_deleted = 0 AND
	c.is_deleted = 0 AND
	e.fnz_estado_venta_id IN (1,2) AND -- Facturado y Por Pagar
	YEAR(fecha_factura) = @Anho
ORDER BY v.fecha_factura DESC

GO

