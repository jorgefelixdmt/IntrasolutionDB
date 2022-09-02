/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_inc_total_hh_pase]
Fecha Creacion: 24/06/2021
Autor: Mauro Roque
Descripcion: funcion que suma el total de horas hombres del pase para que se muestre en grilla de incidencia para el Modulo Mesa de Ayuda
Llamado por: clase java
Usado por: Modulo: Mesa de Ayuda 
Parametros: @inc_incidencia_id - Id Incidencia
Uso: select dbo.[uf_inc_total_hh_pase] (1)
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
create function [dbo].[uf_inc_total_hh_pase] (@inc_incidencia_id int)                         
returns numeric(10,0)                          
                          
As                          
Begin                          
                        
declare @total_hh numeric(10,0)

select @total_hh = sum(convert(int,aso.horas)) 
from pa_pase pa inner join pa_pase_asociado aso 
on pa.pa_pase_id = aso.pa_pase_id inner join inc_incidencia inc 
on inc.inc_incidencia_id = aso.inc_incidencia_id 
where aso.is_deleted=0 and inc.inc_incidencia_id = @inc_incidencia_id

return (@total_hh)    

end

GO

