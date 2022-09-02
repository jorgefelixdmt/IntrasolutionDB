/*      
**********************************************
Nombre: dbo.pr_fnz_valida_monto_factura
Fecha Creacion: 06/11/2020
Autor: Mauro Roque
Descripcion: store que consulta los montos de un proyecto, dentro del modulo Ventas, al seleccionar la lupa proyecto.
Llamado por: js
Usado por: Modulo: Ventas
Parametros: @id_proyecto - ID de Proyecto
Uso: pr_fnz_valida_monto_factura 4
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

************************************
*/
CREATE proc pr_fnz_valida_monto_factura
@id_proyecto int
as
begin

declare @monto_d numeric(15,3),@monto_s numeric(15,3)
declare @total_con_igv_d numeric(15,3),@total_con_igv_s numeric(15,3)

set @monto_d = (select monto_dolares from pry_proyecto where pry_proyecto_id = @id_proyecto )
set @monto_s = (select monto_soles from pry_proyecto where pry_proyecto_id = @id_proyecto )

set @total_con_igv_d =   0.18 *@monto_d + @monto_d
set @total_con_igv_s =   0.18 *@monto_s + @monto_s


select @total_con_igv_d as monto_dolares_proyecto, @total_con_igv_s as monto_soles_proyecto
end

GO

