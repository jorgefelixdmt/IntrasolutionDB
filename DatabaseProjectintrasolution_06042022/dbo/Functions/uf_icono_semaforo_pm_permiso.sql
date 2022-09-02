

/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_icono_semaforo_pm_permiso]
Fecha Creacion: 15/05/2020
Autor: Mauro Roque
Descripcion: store retorna el color semaforo segun estado del permiso
Llamado por: CLASE JAVA
Usado por: Modulo: Consulta de Permisos
Parametros: @estado - ID de  estado permiso
Uso: select dbo.[uf_icono_semaforo_pm_permiso] (5)
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
create function [dbo].[uf_icono_semaforo_pm_permiso] (@estado int)                 
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
 ,@fecha_acordada varchar(1000)               
               
                   
  set @retorno_final = ''                  
                

                 
 IF   (@estado = 2 )             
               
 -- ESTADO = aprobado                     
               
   BEGIN                  
                      
      set @ruta_imagen_amarillo = '/Iconos_Semaforo/ico-2amarillo.png'                    
      set @ruta_imagen = @ruta_imagen_amarillo                 
                        
      set @imagen_retorno = '<center><a target="_blank"><img src="'+@ruta_imagen+'"></a><center>'                  
                        
   END                 
               
 ELSE IF (@estado = 3)           
               
  -- ESTADO = rechazado             
              
   BEGIN                  
                               
      set @ruta_imagen_rojo = '/Iconos_Semaforo/ico-1rojo.png'                  
      set @ruta_imagen = @ruta_imagen_rojo                 
                    
      set @imagen_retorno = '<center><a target="_blank"><img src="'+@ruta_imagen+'"></a><center>'                  
                       
   END               
            
              
 ELSE IF(@estado = 5)                
               
 --ESTADO = cerrado               
                
  BEGIN                
                            
      set @ruta_imagen_verde =  '/Iconos_Semaforo/ico-3verde.png'        
      set @ruta_imagen = @ruta_imagen_verde                
                    
      set @imagen_retorno = '<center><a target="_blank"><img src="'+@ruta_imagen+'"></a><center>'                  
                        
  END     
  
                
 ELSE IF(@estado = 4)                
               
 --ESTADO = sustentado               
                
  BEGIN                
                            
      set @ruta_imagen_verde =  '/Iconos_Semaforo/ico-4azul.png'        
      set @ruta_imagen = @ruta_imagen_verde                
                    
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

