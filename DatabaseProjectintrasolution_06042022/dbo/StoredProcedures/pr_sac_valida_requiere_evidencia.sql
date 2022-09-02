


create proc pr_sac_valida_requiere_evidencia    
@sac_accion_correctiva_id numeric(10,0)      
as    
DECLARE @flag_requiere_evidencia numeric(1,0)       
DECLARE @nro_evidencias numeric(10,0)    
DECLARE @retorno varchar(200)                  
DECLARE @contador numeric(1,0)       
    
 -- obteniendo valor // @flag_requiere_evidencia 1 = SI : NO = 0        
 select @flag_requiere_evidencia=value                
 from pm_parameter                  
 where code='SAC_REQUIERE_EVIDENCIA' and is_deleted=0    
 
     
  -- contador de evidencia                 
 select @nro_evidencias=COUNT(*)                  
 from sac_accion_correctiva_evidencia                  
 where sac_accion_correctiva_id=@sac_accion_correctiva_id and is_deleted=0    
     
 if (@flag_requiere_evidencia=1 and @nro_evidencias=0  )                  
    
   -- SI REQUIERE EVIDENCIA Y CONTADOR DE EVIDENCIA ES = 0    
   begin                  
               
  set @retorno ='la pestaña evidencia no contiene registros'            
  set @contador=1                  
   end    
 else    
 begin    
  set @contador=0    
 end    
       
       
  select  @retorno as mensaje , @contador as contador

GO

