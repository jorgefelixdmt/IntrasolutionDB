
/*      
****************************************************************************************************************************************
Nombre: dbo.vista_roles
Fecha Creacion: 23/04/2020
Autor: Mauro Roque
Descripcion: Lista los roles del sistema asociados a un home
Llamado por: Clase Java
Usado por: Modulo: Home y Portlet
Uso: select * from vista_roles
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
create view vista_roles
as
select
SC_ROLE_ID as sc_role_id,
CODE as code,
NAME as name,
description as descripcion,
fb_home_id as fb_home_id,
CREATED as created,
CREATED_BY as created_by,
UPDATED as updated,
UPDATED_BY as updated_by,
OWNER_ID as owner_id,
IS_DELETED as is_deleted
from SC_ROLE

GO

