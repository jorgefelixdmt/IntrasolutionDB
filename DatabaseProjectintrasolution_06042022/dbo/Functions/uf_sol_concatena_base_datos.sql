/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_sol_concatena_base_datos]
Fecha Creacion: 16/07/2021
Autor: Mauro Roque
Descripcion: funcion que muestra nombre_bd del instalacion de bases de datos para que se muestre en grilla 
Llamado por: clase java
Usado por: Modulo: Solicitud / Instalacion
Parametros: @sol_instalacion_id - Id Instalacion
Uso: select dbo.[uf_sol_concatena_base_datos] (1)
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
CREATE function [dbo].[uf_sol_concatena_base_datos] (@sol_instalacion_id int)                         
returns varchar(1000)                          
                          
As                          
Begin                          
                            
                        
declare @nombre_bds_concatenado varchar(200)

select @nombre_bds_concatenado =COALESCE (@nombre_bds_concatenado +' : ', ' ' ) + ib.nombre 
from sol_instalacion_base_datos ib 
inner join sol_instalacion ins on ins.sol_instalacion_id = ib.sol_instalacion_id 
where ib.is_deleted=0 and ins.sol_instalacion_id = @sol_instalacion_id


return (@nombre_bds_concatenado)    

end

GO

