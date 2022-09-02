

/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_inc_concatena_codigo_pase_jira]
Fecha Creacion: 24/06/2021
Autor: Mauro Roque
Descripcion: funcion que muestra codigo_jira del pase para que se muestre en grilla de incidencia para el Modulo Mesa de Ayuda
Llamado por: clase java
Usado por: Modulo: Mesa de Ayuda 
Parametros: @inc_incidencia_id - Id Incidencia
Uso: select dbo.[uf_inc_concatena_codigo_pase_jira] (1)
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
create function [dbo].[uf_inc_concatena_codigo_pase_jira] (@inc_incidencia_id int)                         
returns varchar(1000)                          
                          
As                          
Begin                          
                        
declare @codigo_jira_concatenado varchar(200)

select @codigo_jira_concatenado =COALESCE (@codigo_jira_concatenado +' : ', ' ' ) + pa.codigo_jira from pa_pase pa inner join pa_pase_asociado aso on pa.pa_pase_id = aso.pa_pase_id inner join inc_incidencia inc on inc.inc_incidencia_id = aso.inc_incidencia_id where aso.is_deleted=0 and inc.inc_incidencia_id = @inc_incidencia_id

return (@codigo_jira_concatenado)    

end

GO

