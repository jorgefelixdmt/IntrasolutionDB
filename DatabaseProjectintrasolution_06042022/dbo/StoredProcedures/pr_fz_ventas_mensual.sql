/*
Creado por: Flavio García
Fecha Creacion: 22/05/2020
Descripcion: SP que devuelve las ventas totales por mes y por año. Devuelve resultados del año ingresado y el anterior
Parametros: @Anho   -    Año
[dbo].[pr_fz_ventas_mensual] 2020

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------
23/05/2020             Valky Salinas      Se quitó filtro por cliente.

*****************************************************************************************************************************

*/

CREATE procedure [dbo].[pr_fz_ventas_mensual]
@Anho int
as
SELECT *
FROM
    (
        Select 
			year(fecha_factura) as Anno,
			case 
				when month (fecha_factura) =1 then 'Enero' 
				when month (fecha_factura) =2 then 'Febrero'  
				when month (fecha_factura) =3 then 'Marzo'
				when month (fecha_factura) =4 then 'Abril'
				when month (fecha_factura) =5 then 'Mayo'
				when month (fecha_factura) =6 then 'Junio'
				when month (fecha_factura) =7 then 'Julio'
				when month (fecha_factura) =8 then 'Agosto'
				when month (fecha_factura) =9 then 'Septiembre'
				when month (fecha_factura) =10 then 'Octubre'
				when month (fecha_factura) =11 then 'Noviembre'
				else 'Diciembre'
			end  as Mes,
			sum(ISNULL(monto_soles,0) / dbo.fn_TipoCambio(fecha_factura) + ISNULL(monto_dolares,0)) as Valor 
		From fnz_venta 
		where 
			is_deleted=0 and
			(year(fecha_factura)=@Anho or  year(fecha_factura)=@Anho - 1)
		Group by year(fecha_factura), month(fecha_factura)  
    )t
PIVOT(
   SUM(Valor)
   for Mes in ([Enero],[Febrero],[Marzo],[Abril],[Mayo],[Junio],[Julio],[Agosto],[Septiembre],[Octubre],[Noviembre],[Diciembre])
) As tabla_pivot

GO

