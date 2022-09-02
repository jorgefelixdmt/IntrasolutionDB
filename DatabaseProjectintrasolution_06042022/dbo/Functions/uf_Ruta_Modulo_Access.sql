

/*      
****************************************************************************************************************************************
Nombre: dbo.uf_Ruta_Modulo_Access
Fecha Creacion: (YYYY-MM-DD): 2020-04-24
Autor:  Carlos Cubas
Descripcion: esta función devuelve una cadena con el nombre de las carpetas donde se ubica el módulo consultado
Call by: esta función como es genérica es llamado desde módulo Roles-Usuario clase ModuleBean.
Llamado por: Esta función es parte del framework
Usado por: Modulo: Roles/Accesos "Esta función es parte del framework"
Parametros:@SC_MODULE_id id del módulo que se consulta.
Uso: select dbo.[uf_Ruta_Modulo_Access] (5411)
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/


CREATE FUNCTION [dbo].[uf_Ruta_Modulo_Access] (@SC_MODULE_id int)  
RETURNS nvarchar(500)  
AS  
BEGIN  
   
DECLARE   
 @ruta  nvarchar(500),  
 @concatenado  nvarchar(500),  
 @contador numeric(10,0),  
 @super_modulo_id numeric(10,0),  
 @modulo_id numeric(10,0),  
 @super_modulo varchar(100),  
 @modulo varchar(100),  
 @objeto_llamado numeric(10,0)  
  
    Select @modulo = NAME from  SC_MODULE  where SC_MODULE_id =@SC_MODULE_id  
   
 if (select MODULE_CALL from SC_MODULE  where SC_MODULE_id = @SC_MODULE_id) is null   
  Begin  
   Select @super_modulo_id = SC_SUPER_MODULE_id, @modulo = NAME from  SC_MODULE  where SC_MODULE_id =@SC_MODULE_id   
   Set @ruta = (select NAME from SC_SUPER_MODULE  where SC_SUPER_MODULE_id = @super_modulo_id) + ' / ' 
  End  
 else  
  Begin  
   Set @ruta = ''  
   WHILE (select MODULE_CALL from  SC_MODULE  where SC_MODULE_id =@SC_MODULE_id  ) is  not null  
    begin  
              
     Set @ruta =  (select NAME from  SC_MODULE  where SC_MODULE_id =  
        (select MODULE_CALL from  SC_MODULE  where SC_MODULE_id =@SC_MODULE_id  )) +' / ' + @ruta  
      
     set @SC_MODULE_id = (select MODULE_CALL from  SC_MODULE  where SC_MODULE_id =@SC_MODULE_id);                      
    End  
  
    Select @super_modulo_id = SC_SUPER_MODULE_id from  SC_MODULE  where SC_MODULE_id = @SC_MODULE_id  
    Set @ruta = (select NAME from SC_SUPER_MODULE   where SC_SUPER_MODULE_id = @super_modulo_id) + ' / '+ @ruta
  
  End  
  
 RETURN(@ruta);  
END;

GO

