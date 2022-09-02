

/*      
****************************************************************************************************************************************
Nombre: dbo.[VISTA_FB_ENVIO_EMAIL_LOG]
Fecha Creacion: 22/04/2020
Autor: Mauro Roque
Descripcion: vista que muestra el listado de envios de correos
Llamado por: Clase Java
Usado por: Modulo: Envio Email Log
Uso: select * from [VISTA_FB_ENVIO_EMAIL_LOG]
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
**********************************************************************************************************
*/
create view [dbo].[VISTA_FB_ENVIO_EMAIL_LOG]
AS
SELECT 
fb_envio_email_log_id,
uea.fb_uea_pe_id as fb_uea_pe_id,
uea.nombre as nombre_sede,
us.SC_USER_ID as sc_user_id,
us.NAME as nombre_usuario,
codigo_email as codigo_email,
perfil as perfil,
a_email as a_email,
asunto as asunto,
mensaje as mensaje,
numero_error as numero_error ,
mensaje_error as mensaje_error,
fechahora as fecha,
convert(char(5), fechahora, 108) as hh_mm,
elog.modulo_id, -- agregado 20-04-2020
elog.origen_id, -- agregado 20-04-2020
elog.enviado, -- agregado 20-04-2020
elog.created,
elog.created_by,
elog.updated,
elog.updated_by,
elog.owner_id,
elog.is_deleted
 FROM fb_envio_email_log elog left join fb_uea_pe uea
 on elog.fb_uea_pe_id=uea.fb_uea_pe_id left join SC_USER us
 on elog.sc_user_id=us.SC_USER_ID 
 WHERE elog.is_deleted=0

GO

