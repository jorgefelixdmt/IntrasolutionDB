
/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_pro_icono_semaforo_propuesta]
Fecha Creacion: 03/07/2020
Autor: Mauro Roque
Descripcion: funcion que icono "semaforo" segun estado del la propuesta
Llamado por: clase java
Usado por: Modulo: Propuesta 
Parametros: @id_propuesta - propuesta id
Uso: select dbo.[uf_pro_icono_semaforo_propuesta] (1)
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/         
create function [dbo].[uf_pro_icono_semaforo_propuesta] (@id_propuesta int)                         
returns varchar(1000)                          
                          
As                          
Begin                          
 Declare                           
                        
 @imagen_retorno varchar(1000)                        
                         
 ,@ruta_imagen varchar(1000)                          
 ,@ruta_imagen_rojo varchar(1000)                          
 ,@ruta_imagen_amarillo varchar(1000)                          
 ,@ruta_imagen_verde varchar(1000)                         
 ,@ruta_imagen_azul varchar(1000)                         
                          
 ,@retorno_final varchar(1000)                       
 ,@fecha_fin_real varchar(1000)                       
 ,@estado int                     
                           
  set @retorno_final = ''                          
                        
  set @estado = (select pro_estado_propuesta_id                       
      from pro_propuesta                      
      where is_deleted=0                       
      and pro_propuesta_id=@id_propuesta)                      
                
                 
  IF (@estado = 5  )                       
                       
  BEGIN     -- ESTADO = Aprobado por el Cliente                 
                                    
      set @ruta_imagen_verde =  '/Iconos_Semaforo/ico-3verde.png' -- valor vacio                      
      set @ruta_imagen = @ruta_imagen_verde                        
                            
      set @imagen_retorno = '<center><a target="_blank"><img src="'+@ruta_imagen+'"></a><center>' 
                                
  END  
  
   ELSE IF (@estado = 7 )                      
                       
  BEGIN     -- ESTADO = eliminado                   
                                    
                                   
      set @ruta_imagen_rojo = '/Iconos_Semaforo/ico-1rojo.png'                          
      set @ruta_imagen = @ruta_imagen_rojo                         
                            
      set @imagen_retorno = '<center><a target="_blank"><img src="'+@ruta_imagen+'"></a><center>'  
                                
  END                     
   else  IF   (@estado <> 6 or @estado<> 5 or @estado<>7)                      
                       
 -- ESTADO = diferente rechazado               
                       
   BEGIN                          
                              
      set @ruta_imagen_amarillo = '/Iconos_Semaforo/ico-2amarillo.png'                            
      set @ruta_imagen = @ruta_imagen_amarillo                         
                                
      set @imagen_retorno = '<center><a target="_blank"><img src="'+@ruta_imagen+'"></a><center>'                          
                                
   END                    
 ELSE                          
   BEGIN                          
      set @imagen_retorno = ''                           
   END                          
                             
      set @retorno_final = @imagen_retorno                          
    
 return (@retorno_final)                        
                         
End

GO

