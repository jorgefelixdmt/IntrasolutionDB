
create proc pr_fnz_obtiene_valor_monto_con_igv
@monto decimal(17,2)
as
declare @total decimal(17,2)

set @total = (select dbo.[uf_fnz_monto_con_igv] (@monto,1))

select @total as total_monto_con_igv

GO

