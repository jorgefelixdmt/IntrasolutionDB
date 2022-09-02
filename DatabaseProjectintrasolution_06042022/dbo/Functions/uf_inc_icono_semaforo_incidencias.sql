/*      
**********************************************
Nombre: dbo.[uf_inc_icono_semaforo_incidencias]
Fecha Creacion: 26/02/2021
Autor: Mauro Roque
Descripcion: funcion que muestra icono "semaforo" segun estado del incidencia para el Modulo Mesa de Ayuda
Llamado por: clase java
Usado por: Modulo: Mesa de Ayuda 
Parametros: @inc_incidencia_id - Id Incidencia
Uso: select dbo.[uf_inc_icono_semaforo_incidencias] (1)

/*
10. Solicitado
20. En Proceso de Atencion
30. En espera de Informacion del Cliente
40. Solucion Completada

45. Instalado en QA DTECH
46. Aprobado en QA DTECH
47. Enviado a Cliente

50. Instalado en Ambiente QA del Cliente
60. Aprobado en QA del Cliente
70. Pase a Ambiente Producción del Cliente Enviado
80. Pase a Ambiente Produccion Confirmado
90. Culminada por el Usuario
99. Anulado por el Cliente
*/


RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
15/03/2021				mauro roque				se agregaron nuevos estados... 
												45. Instalado en QA DTECH
												46. Aprobado en QA DTECH
												47. Enviado a Cliente
24/06/2021				MAURO ROQUE				EL ESTADO DE INCIDENCIA = 40 y 45 DEBE SER CONSIDERADO COMO SEMAFORO ROJO
************************************
*/         
CREATE function [dbo].[uf_inc_icono_semaforo_incidencias] (@inc_incidencia_id int)                         
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

  set @estado = (select inc_estado_incidencia_id                       
      from inc_incidencia                  
      where is_deleted=0                       
      and inc_incidencia_id=@inc_incidencia_id)                      
                
                 
  IF (@estado =10004 or @estado = 1 or  @estado = 2    or  @estado = 3 OR @estado = 4 or @estado= 10003 )                       
    --10. Solicitado
	--20. En Proceso de Atencion
	--30. En espera de Informacion del Cliente
	--40. Solucion Completada
	--45. Instalado en QA DTECH
		--46. Aprobado en QA DTECH
	             
  BEGIN        
                                    
      set @ruta_imagen_rojo_claro =  '/Iconos_Semaforo/ico-1rojo.png' -- rojo
    --set @ruta_imagen_rojo_claro =  '/Iconos_Semaforo/ico-1rojo_muyclaro.png' -- valor claro                      

                      
      set @ruta_imagen = @ruta_imagen_rojo_claro                        
                            
      set @imagen_retorno = '<center><a target="_blank"><img src="'+@ruta_imagen+'"></a><center>' 
                                
  END  
  
   ELSE IF (@estado= 10005 or @estado = 5 or  @estado = 6    or  @estado = 7   or @estado=8 )                      
	--47. Enviado a Cliente
	--50. Instalado en QA del Cliente
	--60. Aprobado en QA del Cliente
	--70. Pase a Producción Enviado
    --80. Pase a Producción Ejecutado
  BEGIN                            
      set @ruta_imagen_naranja = '/Iconos_Semaforo/ico-naranja.png'                          
      set @ruta_imagen = @ruta_imagen_naranja                         
                            
      set @imagen_retorno = '<center><a target="_blank"><img src="'+@ruta_imagen+'"></a><center>'  
                                
  END  
              
 ELSE  IF   (@estado = 10002    or  @estado = 9)                      
	--90. Culminada por el Usuario
    --99. Anulado por el Cliente
	                   
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

