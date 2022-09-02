/*      
****************************************************************************************************************************************
Nombre: dbo.vista_pa_objetos_modificados_por_incidencia
Fecha Creacion: 13/01/2022
Autor: Mauro Roque
Descripcion: Vista que lista los objetos modificados por codigo jira de incidencia
Llamado por: Clase java 
Usado por: Modulo: Mesa Ayuda - Pestaña Objetos modificados
Uso: select * from vista_pa_objetos_modificados_por_incidencia
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
create view vista_pa_objetos_modificados_por_incidencia
as
select
pa.pa_objetos_id,
pa.incidencia_jira_codigo,
pa_categoria_objeto_id,
pa_tipo_objeto_id,
pa_tipo_cambio_id,
nombre_objeto,
descripcion_objeto,
observaciones,
fb_empleado_autor_id,
inc.inc_incidencia_id,
pa.created,
pa.created_by,
pa.updated,
pa.updated_by,
pa.owner_id,
pa.is_deleted
from pa_objetos pa left join inc_incidencia inc
on pa.incidencia_jira_codigo = inc.codigo_jira
where pa.is_deleted=0 and inc.is_deleted=0

GO

