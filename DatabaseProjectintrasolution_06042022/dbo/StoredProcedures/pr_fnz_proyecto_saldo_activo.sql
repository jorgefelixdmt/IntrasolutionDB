
/*
Creado por: Jorge Felix
Fecha Creacion: 01/11/2020
Descripcion: SP que devuelve los saldos por proyecto
Parametros: 
[dbo].[pr_fnz_proyecto_saldo_activo] 

*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************

*/

CREATE procedure [dbo].[pr_fnz_proyecto_saldo_activo]
--@Anho int

AS

Select
       pry.codigo as proyecto,
	   case UPPER(pry.moneda)
			 when 'SOLES' then FORMAT(isnull(convert(numeric(10,2),monto_soles / 3.5) - (Select sum(convert(numeric(10,2),monto_soles)) from fnz_Venta Where pry_proyecto_id = pry.pry_proyecto_id and is_deleted = 0  and fnz_estado_venta_id <> 4) / 3.5,0), '#,#.00')
			 when 'DOLARES' then FORMAT(isnull(convert(numeric(10,2),monto_dolares) - (Select sum(convert(numeric(10,2),monto_dolares)) from fnz_Venta Where pry_proyecto_id = pry.pry_proyecto_id and is_deleted = 0  and fnz_estado_venta_id <> 4),0), '#,#.00')
		End as cantidad
From pry_proyecto pry
       inner join fb_cliente cli on cli.fb_cliente_id = pry.fb_cliente_id
       inner join prd_producto prd on prd.prd_producto_id = pry.prd_producto_id
Where
       pry.is_deleted = 0
       and pry.estado = 1 --- PARAMETRO (Todos = 1)
       and cli.codigo not in ('DTECH')
	   and (isnull(convert(numeric(10,2),monto_soles / 3.5) - (Select sum(convert(numeric(10,2),monto_soles)) from fnz_Venta Where pry_proyecto_id = pry.pry_proyecto_id and is_deleted = 0  and fnz_estado_venta_id <> 4) / 3.5,0) >1 
	   or isnull(convert(numeric(10,2),monto_dolares) - (Select sum(convert(numeric(10,2),monto_dolares)) from fnz_Venta Where pry_proyecto_id = pry.pry_proyecto_id and is_deleted = 0  and fnz_estado_venta_id <> 4),0)>1 )
Order by 1

GO

