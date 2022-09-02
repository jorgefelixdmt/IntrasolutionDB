





/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_Valida_HoraMinuto]
Fecha Creacion: 12/05/20202
Autor: Mauro Roque
Descripcion: FUNCION QUE RETORNA VALOR "1" ES VERDADERO CASO CONTRARIO ES VALOR FALSO
Llamado por: Store [pr_g_valida_solo_numeros]
Parametros: @parametro - valor "hora"
Uso: select dbo.[uf_Valida_HoraMinuto] ('541')
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
CREATE FUNCTION [dbo].[uf_Valida_HoraMinuto](@parametro varchar(8))
RETURNS VARCHAR(10)
AS
BEGIN
		declare @cadena_patron varchar(15)
		declare @contador numeric(10,0)
		declare @lencadena numeric(10,0)
		declare @resultado numeric(10,0)
		set @resultado =0 
		set @contador = 1
		set @cadena_patron =  '0123456789:'
		set @lencadena = len(@parametro)

		while @contador <= @lencadena
				begin

				set @resultado = (select CHARINDEX(SUBSTRING (@parametro,@contador,1),@cadena_patron)) 
						if @resultado=0
						begin
							break
						end
				set @contador = @contador +1
				end

RETURN (@resultado)
END

GO

