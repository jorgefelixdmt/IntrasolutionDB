/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_pry_icono_semaforo_proyecto]
Fecha Creacion: 02/07/2020
Autor: Mauro Roque
Descripcion: funcion que icono "semaforo" segun estado del poryecto
Llamado por: clase java
Usado por: Modulo: Proyectos 
Parametros: @id_proyecto - proyecto id
Uso: select dbo.[uf_pry_icono_semaforo_proyecto] (1)
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/         
create function [dbo].[uf_pry_icono_semaforo_proyecto] (@id_proyecto int)                         
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
                        
  set @estado = (select estado                       
      from pry_proyecto                      
      where is_deleted=0                       
      and pry_proyecto_id=@id_proyecto)                      
                              
  set @fecha_fin_real = (select convert(varchar(10),fecha_fin_real,112)                       
      from pry_proyecto                   
      where is_deleted=0                       
      and pry_proyecto_id=@id_proyecto)                      
                         
                         
 IF   (@estado = 1 and @fecha_fin_real<CONVERT (varchar(10), getdate(), 112))                        
                       
 -- ESTADO = activo y Fecha fin real  menor que hoy               
                       
   BEGIN                          
                              
      set @ruta_imagen_amarillo = '/Iconos_Semaforo/ico-2amarillo.png'                            
      set @ruta_imagen = @ruta_imagen_amarillo                         
                                
      set @imagen_retorno = '<center><a target="_blank"><img src="'+@ruta_imagen+'"></a><center>'                          
                                
   END 
                 
 ELSE IF (@estado = 1 and  (@fecha_fin_real > CONVERT (varchar(10), getdate(), 112)) or  (@fecha_fin_real is null) )                       
                       
  BEGIN     -- ESTADO = activo y Fecha fin real  mayor que hoy o fecha fin real vacio                    
                                    
      set @ruta_imagen_verde =  '/Iconos_Semaforo/ico-3verde.png' -- valor vacio                      
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

