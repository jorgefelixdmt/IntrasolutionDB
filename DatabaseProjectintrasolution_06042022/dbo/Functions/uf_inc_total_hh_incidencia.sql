/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_inc_total_hh_incidencia]
Fecha Creacion: 24/06/2021
Autor: Mauro Roque
Descripcion: funcion que suma el total de horas hombres de una incidencia para que se muestre en grilla de incidencia
			 para el Modulo Mesa de Ayuda
Llamado por: clase java
Usado por: Modulo: Mesa de Ayuda 
Parametros: @inc_incidencia_id - Id Incidencia
Uso: select dbo.[uf_inc_total_hh_incidencia] (1)
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
CREATE function [dbo].[uf_inc_total_hh_incidencia] (@inc_incidencia_id int)                         
returns numeric(10,0)                          
                          
As                          
Begin                          
                        
declare @total_hh numeric(10,0)

select @total_hh = sum(convert(int,ihh.numero_hh)) 
from inc_incidencia inc inner join inc_incidencia_hh ihh 
on inc.inc_incidencia_id = ihh.inc_incidencia_id 
where ihh.is_deleted=0 and inc.inc_incidencia_id = @inc_incidencia_id

return (@total_hh)    

end

GO

