/*
Creado por: Jorge Felix
Fecha Creacion: 27/10/2020
Descripcion: SP que muestra datos de los proycetos por cliente monto del proyecto, monto facturado, el saldo y el estado para el reporte
Parametros:   
[dbo].[pr_fnz_proyecto_saldo] 
Utilizado por: Boton que llama a Reporte en modulo Saldo de Proyectos 
*****************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------------------------------------

*****************************************************************************************************************************
pr_fnz_proyecto_saldo 1,1
*/
CREATE procedure [dbo].[pr_fnz_proyecto_saldo]
@fb_uea_pe_id as numeric(10,0),
@idusu as numeric(10,0)
AS
Declare @Usuario varchar(150)
Set @Usuario = (Select name from sc_user where sc_user_id = @idusu)
Select
       pry.pry_proyecto_id,
       pry.codigo as codigo_proyecto,
       pry.Nombre as proyecto,
       pry.fb_cliente_id,
       cli.nombre as cliente,
       pry.moneda,
       case UPPER(pry.moneda)
             when 'SOLES' then isnull(convert(numeric(10,2),monto_soles / 3.5),0)
             When 'DOLARES' then isnull(convert(numeric(10,2),monto_dolares),0)
       End as monto_proyecto_dolares,
       case UPPER(pry.moneda)
             when 'SOLES' then isnull((Select sum(convert(numeric(10,2),monto_soles)) from fnz_Venta Where pry_proyecto_id = pry.pry_proyecto_id and is_deleted = 0  and fnz_estado_venta_id <> 4) / 3.5,0)
             When 'DOLARES' then isnull((Select sum(convert(numeric(10,2),monto_dolares)) from fnz_Venta Where pry_proyecto_id = pry.pry_proyecto_id and is_deleted = 0  and fnz_estado_venta_id <> 4),0)
       End as monto_facturado_dolares,
	   case UPPER(pry.moneda)
			 when 'SOLES' then isnull(convert(numeric(10,2),monto_soles / 3.5) - (Select sum(convert(numeric(10,2),monto_soles)) from fnz_Venta Where pry_proyecto_id = pry.pry_proyecto_id and is_deleted = 0  and fnz_estado_venta_id <> 4) / 3.5,0)
			 when 'DOLARES' then isnull(convert(numeric(10,2),monto_dolares) - (Select sum(convert(numeric(10,2),monto_dolares)) from fnz_Venta Where pry_proyecto_id = pry.pry_proyecto_id and is_deleted = 0  and fnz_estado_venta_id <> 4),0)
		End as saldo_dolares,
		case (pry.estado) 
			when 1 then 'ACTIVO'
			When 0 then 'INACTIVO'
		End as estado,
		created = getdate(),
		created_by = 1,
		updated = getdate(),
		updated_by = 1,
		owner_id = 1,
		is_deleted = 0,
		Usuario = @Usuario 
From pry_proyecto pry
       inner join fb_cliente cli on cli.fb_cliente_id = pry.fb_cliente_id
       inner join prd_producto prd on prd.prd_producto_id = pry.prd_producto_id
Where
       pry.is_deleted = 0
       -- and pry.estado = 1 --- PARAMETRO (Todos = 1)
       and cli.codigo not in ('DTECH')
Order by 1

GO

