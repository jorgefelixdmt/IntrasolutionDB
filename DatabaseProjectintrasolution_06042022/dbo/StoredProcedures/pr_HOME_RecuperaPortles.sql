/*
Creado por: Valky Salinas
Fecha Creacion: 13/03/2020
Descripcion: Store Procedure que devuelve los portlets dado un home.
[pr_HOME_RecuperaPortles] 1

*********************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    -------------------------------------------------------------------------

*********************************************************************************************************************

*/

CREATE proc [dbo].[pr_HOME_RecuperaPortles]    
 @Home  varchar(32)    
AS    
   Select      
         p.codigo,    
         p.titulo,    
         p.tipo,    
   p.flag_expand,    
   p.flag_reload,    
   p.flag_download,    
   hp.flag_header,    
         IsNull(p.file_css,'') as file_css,    
         IsNull(p.file_js,'') as file_js,    
         IsNull(p.file_asp,'') as file_asp,    
         hp.ancho,    
         hp.altura,    
         hp.color,    
         hp.orden_fila,    
         hp.orden_columna    
     from fb_home_portlet hp    
         inner join fb_portlet p on p.fb_portlet_id = hp.fb_portlet_id    
         inner join fb_home h on h.fb_home_id = hp.fb_home_id    
     Where h.fb_home_id =  @Home    
         and hp.is_deleted = 0    
         and p.is_deleted = 0    
     Order by hp.orden_fila, hp.orden_columna

GO

