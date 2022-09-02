    
CREATE proc pr_inc_valida_investigacion_completa           
@inc_informe_final_id numeric(10,0)            
as            
      
declare @nro_equipo_inves numeric(10,0)         
declare @nro_accidentes numeric(10,0)         
declare @nro_causas numeric(10,0)         
declare @nro_accion_correc numeric(10,0)           
declare @nro_evidencia numeric(10,0)           
      
        
            
declare @retorno varchar(200)            
declare @contador numeric(1,0)            
             
 -- pestana equipos          
 select @nro_equipo_inves=COUNT(*)            
 from inc_informe_final_equipo            
 where inc_informe_final_id=@inc_informe_final_id and is_deleted=0            
       
       
 -- pestana accidentes      
 select @nro_accidentes=COUNT(*)            
 from inc_informe_final_accidentado            
 where inc_informe_final_id=@inc_informe_final_id and is_deleted=0           
       
  -- pestana causas      
 select @nro_causas=COUNT(*)            
 from inc_informe_final_causa      
 where inc_informe_final_id=@inc_informe_final_id and is_deleted=0            
            
             
  -- pestana accion es correctivas          
 select @nro_accion_correc= COUNT(*)            
  from sac_accion_correctiva         
  where inc_informe_final_id=@inc_informe_final_id and is_deleted=0            
              
     -- pestana evidencias         
 select @nro_evidencia= COUNT(*)            
  from inc_informe_final_evidencia         
  where inc_informe_final_id=@inc_informe_final_id and is_deleted=0             
               
 if (@nro_accidentes=0 and @nro_equipo_inves=0 and @nro_causas=0 and @nro_accion_correc=0 and @nro_evidencia=0)            
  begin            
         
         
  set @retorno ='las pestañas no contienen registros'      
  set @contador=0            
  end            
else            
 begin           
          
  set @contador=1         
         
      
  update inc_informe_final            
  set preliminar_final=1, inc_estado_investigacion_id=3,inc_estado_info_preliminar_id=3            
  where inc_informe_final_id = @inc_informe_final_id        
          
  update ifi            
  set ifi.estado_inves_nombre  = iei.nombre         
  from inc_informe_final ifi inner join inc_estado_investigacion iei        
  on ifi.inc_estado_investigacion_id=iei.inc_estado_investigacion_id        
  where ifi.inc_informe_final_id = @inc_informe_final_id        
       
        
  set @retorno='Inves. Completa paso a Inves. Enviado'          
            
  end            
      
  select @retorno as mensaje , @contador as contador

GO

