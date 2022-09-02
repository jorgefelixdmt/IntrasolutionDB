


/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_pa_icono_semaforo_pase]
Fecha Creacion: 06/01/2021
Autor: Mauro Roque
Descripcion: funcion que icono "semaforo" segun estado del pase
Llamado por: clase java
Usado por: Modulo: PASE 
Parametros: @id_pase - pase id
Uso: select dbo.[uf_pa_icono_semaforo_pase] (1)

/*
5	50. ENVIADO A CLIENTE
10005 75. ENVIADO A PRD
6	60. INSTALADO QA CLIENTE
7	70. REVISADO QA CLIENTE
8	80. INSTALADO_PROD_CLIENTE
9	90. CULMINADO
*/                        


RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
17-08-2021				Guillermo Vergel		Se agregó estado 10005 y se colocó en el mismo color que el estado 5
**********************************************************************************************************
*/         
CREATE function [dbo].[uf_pa_icono_semaforo_pase] (@id_pase int)                         
returns varchar(1000)                          
                          
As                          
Begin                          
 Declare                           
                        
 @imagen_retorno varchar(1000)                        
                         
 ,@ruta_imagen varchar(1000)                          
 ,@ruta_imagen_rojo varchar(1000) 
 ,@ruta_imagen_rojo_claro varchar(1000)                            
 ,@ruta_imagen_amarillo varchar(1000)                          
 ,@ruta_imagen_verde varchar(1000) 
 ,@ruta_imagen_naranja varchar(1000)                            
 ,@ruta_imagen_azul varchar(1000)                         
                          
 ,@retorno_final varchar(1000)                       
 ,@fecha_fin_real varchar(1000)                       
 ,@estado int                     
                           
  set @retorno_final = ''                          

  set @estado = (select pa_pase_estado_id                       
      from pa_pase                  
      where is_deleted=0                       
      and pa_pase_id=@id_pase)                      
                
                 
  IF (@estado = 5 or @estado= 10005 )                       
                       
  BEGIN     -- ESTADO = 50. ENVIADO A CLIENTE --- 10005 75. ENVIADO A PRD        
                                    
      set @ruta_imagen_rojo_claro =  '/Iconos_Semaforo/ico-1rojo_muyclaro.png' -- valor claro                      
      set @ruta_imagen = @ruta_imagen_rojo_claro                        
                            
      set @imagen_retorno = '<center><a target="_blank"><img src="'+@ruta_imagen+'"></a><center>' 
                                
  END  
  
   ELSE IF (@estado = 6 )                      
                       
  BEGIN     -- ESTADO = 60. INSTALADO QA CLIENTE                   
                                    
                                   
      set @ruta_imagen_naranja = '/Iconos_Semaforo/ico-naranja.png'                          
      set @ruta_imagen = @ruta_imagen_naranja                         
                            
      set @imagen_retorno = '<center><a target="_blank"><img src="'+@ruta_imagen+'"></a><center>'  
                                
  END  
  
   ELSE IF (@estado = 7 )                      
                       
  BEGIN     -- ESTADO = 70. REVISADO QA CLIENTE
                                    
                                   
      set @ruta_imagen_amarillo = '/Iconos_Semaforo/ico-2amarillo.png'                          
      set @ruta_imagen = @ruta_imagen_amarillo                         
                            
      set @imagen_retorno = '<center><a target="_blank"><img src="'+@ruta_imagen+'"></a><center>'  
                                
  END    
 ELSE IF (@estado = 8 )                      
                       
  BEGIN     -- ESTADO = 80. INSTALADO_PROD_CLIENTE
                                    
                                   
      set @ruta_imagen_azul = '/Iconos_Semaforo/ico-4azul.png'                          
      set @ruta_imagen = @ruta_imagen_azul                         
                            
      set @imagen_retorno = '<center><a target="_blank"><img src="'+@ruta_imagen+'"></a><center>'  
                                
  END                  
   else  IF   (@estado  = 9)                      
                       
 -- ESTADO = 90. CULMINADO
                       
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

