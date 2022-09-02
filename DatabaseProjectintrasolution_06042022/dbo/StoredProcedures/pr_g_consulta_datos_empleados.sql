
/*      
****************************************************************************************************************************************
Nombre: dbo.pr_g_consulta_datos_empleados
Fecha Creacion: 02/03/2020
Autor: Mauro Roque
Descripcion: consulta datos del empleado, para mostrar valores en formularios del sistema
Llamado por: Javascript
Usado por: Modulo: Solicitud de Vacaciones
Parametros: @fb_empleado_id - ID del empleado
Uso: **************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/


create proc [dbo].[pr_g_consulta_datos_empleados]           
@fb_empleado_id numeric(10,0)          
as          
select          
em.fb_empleado_id,        
em.numero_documento,          
em.nombreCompleto ,         
em.cargo_codigo,        
em.cargo_nombre    
from fb_empleado em      
where em.fb_empleado_id = @fb_empleado_id and em.is_deleted = 0

GO

