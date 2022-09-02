

CREATE VIEW [dbo].[vw_pry_proyecto_saldo]

AS

Select

       pry.pry_proyecto_id,

       pry.codigo as codigo_proyecto,

       pry.Nombre as proyecto,

       pry.fb_cliente_id,

       cli.nombre as cliente,

       pry.moneda,

       case UPPER(pry.moneda)

             when 'SOLES' then convert(numeric(10,2),monto_soles / 3.5)

             When 'DOLARES' then convert(numeric(10,2),monto_dolares)

       End as monto_proyecto_dolares,

       case UPPER(pry.moneda)

             when 'SOLES' then (Select sum(convert(numeric(10,2),monto_soles)) from fnz_Venta Where pry_proyecto_id = pry.pry_proyecto_id and is_deleted = 0  and fnz_estado_venta_id <> 4) / 3.5

             When 'DOLARES' then (Select sum(convert(numeric(10,2),monto_dolares)) from fnz_Venta Where pry_proyecto_id = pry.pry_proyecto_id and is_deleted = 0  and fnz_estado_venta_id <> 4)

       End as monto_facturado_dolares,

	   case UPPER(pry.moneda)
			
			 when 'SOLES' then convert(numeric(10,2),monto_soles / 3.5) - (Select sum(convert(numeric(10,2),monto_soles)) from fnz_Venta Where pry_proyecto_id = pry.pry_proyecto_id and is_deleted = 0  and fnz_estado_venta_id <> 4) / 3.5
			 
			 when 'DOLARES' then convert(numeric(10,2),monto_dolares) - (Select sum(convert(numeric(10,2),monto_dolares)) from fnz_Venta Where pry_proyecto_id = pry.pry_proyecto_id and is_deleted = 0  and fnz_estado_venta_id <> 4)

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
		is_deleted = 0
From pry_proyecto pry

       inner join fb_cliente cli on cli.fb_cliente_id = pry.fb_cliente_id

       inner join prd_producto prd on prd.prd_producto_id = pry.prd_producto_id

Where

       pry.is_deleted = 0

       -- and pry.estado = 1 --- PARAMETRO (Todos = 1)

       and cli.codigo not in ('DTECH')

--Order by 1

GO

