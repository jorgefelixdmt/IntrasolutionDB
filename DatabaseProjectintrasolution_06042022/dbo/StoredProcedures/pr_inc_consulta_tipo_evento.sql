

CREATE proc pr_inc_consulta_tipo_evento  
@inc_informe_final_id numeric(10,0)  
as  
declare @accidente_incapacitante numeric(10,0)  
declare @accidente_leve numeric(10,0)  
declare @dano_propiedad numeric(10,0)  
declare @incidente numeric(10,0)  
declare @perdida_proceso numeric(10,0)  
declare @accidente_ambiental numeric(10,0)  
  
DECLARE @retorno VARCHAR(200)  
  
select  
@accidente_incapacitante=accidente_incapacitante,  
@accidente_leve=accidente_leve,  
@dano_propiedad=dano_propiedad,  
@incidente=incidente,  
@perdida_proceso=perdida_proceso,   
@accidente_ambiental=accidente_ambiental  
  
 from inc_informe_final where fb_uea_pe_id=1 and is_deleted=0 and inc_informe_final_id=@inc_informe_final_id  
  
   
      
 if (@accidente_incapacitante=1 )      
  begin       
       
  set @retorno = 'AI;'      
  
  end  
 else   
 begin  
 set @retorno = ''   
 end       
      
  if (@accidente_leve=1 )      
  begin       
       
  set @retorno = @retorno + 'IP;'      
  
  end        
    
  else   
 begin  
 set @retorno = @retorno   
 end     
   
  if (@dano_propiedad=1 )      
  begin       
       
  set @retorno = @retorno + 'DM;'      
  
  end        
  
 else   
 begin  
 set @retorno = @retorno   
 end     
   
      
 if (@incidente=1 )      
  begin       
       
  set @retorno = @retorno + 'I;'      
  
  end       
    
   else   
 begin  
 set @retorno = @retorno   
 end     
   
  IF (@perdida_proceso=1 )      
  begin       
      
  set @retorno = @retorno + 'DP;'    
        
  end  
    
   else   
 begin  
 set @retorno = @retorno   
 end     
   
  IF (@accidente_ambiental=1 )      
  begin       
      
  set @retorno = @retorno + 'A;'    
        
  end        
    
   else   
 begin  
 set @retorno = @retorno   
 end     
   
 update inc_informe_final  
 set otro_tipo_reporte= @retorno  
 where inc_informe_final_id=@inc_informe_final_id  
    
select @retorno as mensaje

GO

