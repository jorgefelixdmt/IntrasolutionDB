
 /*  
 Autor : Mauro Roque  
 Descripcion : valida que los accidentes y acciones inmediatas tengan registros  
      antes de cambiar de estado reporte completo a enviado   
 exe pr_inc_valida_reporte_completo 5  
 */     
      
        
CREATE proc pr_inc_valida_reporte_completo          
@inc_informe_final_id numeric(10,0)          
as          
          
declare @nro_accidentes numeric(10,0)           
declare @nro_acciones_inme numeric(10,0)       
      
declare @retorno varchar(200)          
declare @contador numeric(1,0)          
           
 select @nro_accidentes=COUNT(*)          
 from inc_informe_final_accidentado          
 where inc_informe_final_id=@inc_informe_final_id and is_deleted=0          
          
 select @nro_acciones_inme= COUNT(*)          
  from inc_informe_final_accion_inmediata           
  where inc_informe_final_id=@inc_informe_final_id and is_deleted=0          
            
           
        
             
 if (@nro_accidentes=0 or @nro_acciones_inme=0 )          
  begin          
       
       
  set @retorno ='las Pestañas Accidentes y Correciones no contienen registros'            
  set @contador=0          
  end          
else          
 begin         
        
  set @contador=1       
       
  update inc_informe_final            
  set preliminar_final=1, inc_estado_info_preliminar_id=3,inc_estado_investigacion_id=1            
  where inc_informe_final_id = @inc_informe_final_id         
          
  update ifi            
  set ifi.estado_info_preliminar_nombre  = iiep.nombre , ifi.estado_inves_nombre = iei.nombre        
  from inc_informe_final ifi inner join inc_estado_info_preliminar iiep        
  on ifi.inc_estado_info_preliminar_id=iiep.inc_estado_info_preliminar_id inner join inc_estado_investigacion iei        
  on ifi.inc_estado_investigacion_id=iei.inc_estado_investigacion_id        
  where ifi.inc_informe_final_id = @inc_informe_final_id        
      
  set @retorno='Reporte Enviado a Investigación'        
          
  end          
  select @retorno as mensaje , @contador as contador

GO

