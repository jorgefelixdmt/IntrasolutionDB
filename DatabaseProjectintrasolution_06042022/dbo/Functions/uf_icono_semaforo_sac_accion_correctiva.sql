


/*      
****************************************************************************************************************************************
Nombre: dbo.[uf_icono_semaforo_sac_accion_correctiva]
Fecha Creacion: 20/08/2019
Autor: Mauro Roque
Descripcion: funcion que genera codigo correlativo de planes de accion segun tipo origen
Llamado por: trigger
Usado por: Modulo: SAC
Parametros: @estado - ID de estado SAC
			@sac_accion_correctiva_id - Id de SAC
Uso: select dbo.[uf_icono_semaforo_sac_accion_correctiva] (1,1)
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
CREATE function [dbo].[uf_icono_semaforo_sac_accion_correctiva] (@estado int,@sac_accion_correctiva_id int)             
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
            
  set @estado = (select sac_estado_accion_correctiva_id           
      from sac_accion_correctiva          
      where is_deleted=0           
      and sac_accion_correctiva_id=@sac_accion_correctiva_id)          
                  
  set @fecha_acordada = (select convert(varchar(10),fecha_acordada_ejecucion,112)           
      from sac_accion_correctiva         
      where is_deleted=0           
      and sac_accion_correctiva_id=@sac_accion_correctiva_id)          
             
       /*      
				 IF   (@estado = 1 and @fecha_acordada>CONVERT (varchar(10), getdate(), 112)          
				 OR @estado = 1 and @fecha_acordada=CONVERT (varchar(10), getdate(), 112)          
				 OR @estado = 6)            
					   -- ESTADO = EN Pendiente Y FECHA ACORDADA MAYOR QUE HOY          
				 -- ESTADO = EN Pendiente Y FECHA ACORDADA = QUE HOY          
				 -- ESTADO = EJECUTADO   
	 */ 
	              
 IF   (@estado = 1 and @fecha_acordada>CONVERT (varchar(10), getdate(), 112)          
  OR @estado = 1 and @fecha_acordada=CONVERT (varchar(10), getdate(), 112)  
	   )      
 -- ESTADO = EN Pendiente Y FECHA ACORDADA MAYOR QUE HOY          
 -- ESTADO = EN Pendiente Y FECHA ACORDADA = QUE HOY          
  
   BEGIN              
                  
      set @ruta_imagen_amarillo = '/Iconos_Semaforo/ico-2amarillo.png'                
      set @ruta_imagen = @ruta_imagen_amarillo             
                    
      set @imagen_retorno = '<center><a target="_blank"><img src="'+@ruta_imagen+'"></a><center>'              
                    
   END             
           
 ELSE IF (@estado = 1 and @fecha_acordada<CONVERT (varchar(10), getdate(), 112)    
 OR @estado=1       
   )          
           
  -- ESTADO = EN Pendiente Y FECHA ACORDADA  MENOR QUE HOY          
          
   BEGIN              
                           
      set @ruta_imagen_rojo = '/Iconos_Semaforo/ico-1rojo.png'              
      set @ruta_imagen = @ruta_imagen_rojo             
                
      set @imagen_retorno = '<center><a target="_blank"><img src="'+@ruta_imagen+'"></a><center>'              
                   
   END           
           
          
 ELSE IF(@estado = 6)            
           
 --ESTADO = ejecutado           
            
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

