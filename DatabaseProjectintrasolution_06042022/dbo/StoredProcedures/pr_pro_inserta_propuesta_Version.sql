
/*      
****************************************************************************************************************************************
Nombre: dbo.[pr_pro_inserta_propuesta_Version]
Fecha Creacion: 26/02/2020
Autor: Mauro Roque
Descripcion: inserta propuesta version
Llamado por: javascript
Usado por: Modulo: Propuesta
Parametros: @pro_propuesta_id - id de la Propuesta,
			
Uso: [pr_pro_inserta_propuesta_Version] 1
**************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
27-02-2020				Mauro Roque				inserta valor "01" al campo version, cuando es nueva version
												actualiza la version de la propuesta sumandole 1 de la version generada
**********************************************************************************************************
*/

CREATE proc [dbo].[pr_pro_inserta_propuesta_Version]
@pro_propuesta_id numeric(10,0)
as
begin

declare @version_actualizado_propuesta varchar(10)

insert into pro_propuesta_version
(
pro_propuesta_id,
fecha_documento,
monto_propuesta_version,
observaciones,
archivo_propuesta_version,
numero_version,
created,
created_by,
updated,
updated_by,
owner_id,
is_deleted
)
select  
pro_propuesta_id,
fecha_documento,
null,
observacion,
archivo_propuesta,
case when version is null or version = ''
then '1'
else version end,
getdate(),
1,
getdate(),
1,
1,
0
from pro_propuesta
where pro_propuesta_id = @pro_propuesta_id
 
 update pro_propuesta
 set version = (select max(numero_version) from pro_propuesta_version where is_deleted=0 and pro_propuesta_id = @pro_propuesta_id) + 1
 where pro_propuesta_id = @pro_propuesta_id

set @version_actualizado_propuesta = (select version from pro_propuesta where is_deleted=0 and pro_propuesta_id = @pro_propuesta_id)

 select @version_actualizado_propuesta as version_actualizado_propuesta
end

GO

