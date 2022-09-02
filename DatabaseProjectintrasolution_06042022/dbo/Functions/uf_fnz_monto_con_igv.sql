


/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_fnz_monto_con_igv]
Fecha Creacion: 20/05/2020
Autor: Mauro Roque
Descripcion: FUNCION QUE CALCULA EL MONTO CON IGV INCLUIDO
Llamado por: js
Usado por: Modulo: FINANZAS / VENTAS
Parametros: @monto - Monto Base
			@id_grupo - id Grupo 
Uso: select dbo.[uf_fnz_monto_con_igv] (15.18,1)
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
create FUNCTION [dbo].[uf_fnz_monto_con_igv] (@monto numeric(17,2),@id_grupo int)
RETURNS numeric(17,2)
AS
BEGIN
	
DECLARE @base   numeric(17,2),@REDONDEO_BASE numeric(17,2),@total_igv numeric(17,2),@total_final numeric(17,2)
	--IGV 18%
	set @base = ( select (@monto/1.18) )

	SET @REDONDEO_BASE = (ROUND(@base,2))

	set @total_igv = @monto - @REDONDEO_BASE
	
	set @total_final = @monto + @total_igv
	
 RETURN(@total_final);

END;

GO

