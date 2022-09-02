/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_pry_icono_semaforo_proyecto_hito]
Fecha Creacion: 30/06/2020
Autor: Mauro Roque
Descripcion: funcion que icono "semaforo# segun estado del poryecto hito
Llamado por: clajse java
Usado por: Modulo: Proyectos / Pestaña hito
Parametros: @id_proycto_hito - proyecto hito id
Uso: select dbo.[uf_pry_icono_semaforo_proyecto_hito] (1)
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/         
CREATE function [dbo].[uf_pry_icono_semaforo_proyecto_hito] (@id_proycto_hito int)                         
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
 ,@fecha_fin_planificada varchar(1000)                       
 ,@estado int                     
                           
  set @retorno_final = ''                          
                        
  set @estado = (select pry_estado_hito_id                       
      from pry_proyecto_hito                      
      where is_deleted=0                       
      and pry_proyecto_hito_id=@id_proycto_hito)                      
                              
  set @fecha_fin_planificada = (select convert(varchar(10),fin_planificado,112)                       
      from pry_proyecto_hito                     
      where is_deleted=0                       
      and pry_proyecto_hito_id=@id_proycto_hito)                      
                         
                         
 IF   (@estado = 1 and @fecha_fin_planificada <  DATEADD(d,10, CONVERT (varchar(10), getdate(), 112))                     
  )                        
                       
 -- ESTADO = EN Pendiente Y FECHA fin planificada esta a 10 dias de Hoy                     
                         
                       
   BEGIN                          
                              
      set @ruta_imagen_amarillo = '/Iconos_Semaforo/ico-2amarillo.png'                            
      set @ruta_imagen = @ruta_imagen_amarillo                         
                                
      set @imagen_retorno = '<center><a target="_blank"><img src="'+@ruta_imagen+'"></a><center>'                          
                                
   END                         
                       
 ELSE IF (@estado = 1 and @fecha_fin_planificada<=CONVERT (varchar(10), getdate(), 112)                
                   
   )                      
                       
  -- ESTADO = EN Pendiente Y FECHA fin planificada  MENOR igual ha hoy                  
                      
   BEGIN                          
                                       
      set @ruta_imagen_rojo = '/Iconos_Semaforo/ico-1rojo.png'                          
      set @ruta_imagen = @ruta_imagen_rojo                         
                            
      set @imagen_retorno = '<center><a target="_blank"><img src="'+@ruta_imagen+'"></a><center>'                          
                               
   END                       
                    
                      
 ELSE IF(@estado = 6)                        
                       
 --ESTADO = terminado                       
                        
  BEGIN                        
                                    
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

