
CREATE FUNCTION [dbo].[uf_netx_valor_tabla_techbuilder] (@pm_sequence_table_id numeric(10,0))    
RETURNS numeric(10,0)    
AS    
BEGIN    
     
declare @valor_id numeric(10,0)    
declare @id_sequence_table numeric(10,0)    
    
    
set @id_sequence_table = (select         
       pm_sequence_table_id      
       from pm_sequence_table    
       where       
        pm_sequence_table_id =@pm_sequence_table_id        
     )       
           
  --if (@id_sequence_table= 40 ) --si es sc_user_id    
  -- begin    
  --  set @valor_id =(select  top 1 sc_user_id  from sc_user order by 1 desc )    
        
  -- end     
  --if (@id_sequence_table = 52) --si es sc_user_role_id    
  -- begin    
  --  set @valor_id =(select  top 1 sc_user_role_id  from sc_user_role order by 1 desc )    
  -- end     
  --if (@id_sequence_table = 3) --si es sc_role_id    
  -- begin    
  --  set @valor_id =(select  top 1 sc_role_id  from sc_role order by 1 desc )    
  -- end     
  --if (@id_sequence_table = 55) --si es sc_access_id    
  -- begin    
  --  set @valor_id =(select  top 1 sc_access_id  from sc_access order by 1 desc )    
  -- end        
  --if (@id_sequence_table = 48) --si es sc_domain_table_id    
  -- begin    
  --  set @valor_id =(select  top 1 sc_domain_table_id  from sc_domain_table order by 1 desc )    
  -- end        
  --if (@id_sequence_table = 49) --si es sc_master_table_id    
  -- begin    
  --  set @valor_id =(select  top 1 sc_master_table_id  from sc_master_table order by 1 desc )    
  -- end        
  --if (@id_sequence_table = 1) --si es sc_table_id    
  -- begin    
  --  set @valor_id =(select  top 1 sc_table_id  from sc_table order by 1 desc )    
  -- end        
  --if (@id_sequence_table = 53) --si es sc_table_field_id    
  -- begin    
  --  set @valor_id =(select  top 1 sc_table_field_id  from sc_table_field order by 1 desc )    
  -- end     
  if (@id_sequence_table = 54) --si es sc_module_id    
   begin    
    set @valor_id =(select  top 1 sc_module_id  from sc_module where SC_SUPER_MODULE_ID <>1 and SC_MODULE_ID <80001 order by 1 desc )    
   end     
  --if (@id_sequence_table = 10) --si es sc_super_module_id    
  -- begin    
  --  set @valor_id =(select  top 1 sc_super_module_id  from sc_super_module order by 1 desc )    
  -- end                              
       
      
 RETURN(@valor_id);    
END;

GO

