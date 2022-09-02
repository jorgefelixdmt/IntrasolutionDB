

/*      
****************************************************************************************************************************************
Nombre: dbo.[VISTA_SC_AUDIT_VALUE]
Fecha Creacion: 23/04/2020
Autor: Mauro Roque
Descripcion: lista registros de auditoria, de los modulos del sistema
Llamado por: Clase java
Usado por: Modulo: Auditoria de Registros
Uso: select * from [VISTA_SC_AUDIT_VALUE]
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/

CREATE view [dbo].[VISTA_SC_AUDIT_VALUE]
AS
SELECT 
sc_audit_value_id,
module_name as modulo,
table_name as tabla,
table_id as table_id,
user_name as usuario,
module_id as module_id,
date_action as fecha,
convert(char(5), date_action, 108) as hh_mm,
value_old as value_old,
value_new as value_new,
action_name as accion,
user_id as id_usuario,
value_id as value_id,
created,
created_by,
updated,
updated_by,
owner_id,
is_deleted
 FROM SC_AUDIT_VALUE

GO

