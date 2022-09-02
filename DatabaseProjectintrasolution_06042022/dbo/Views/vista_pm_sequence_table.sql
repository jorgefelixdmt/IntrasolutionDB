
CREATE view vista_pm_sequence_table      
as      
select      
p.PM_SEQUENCE_TABLE_ID AS pm_sequence_table_id,      
p.SEQUENCE_NAME AS sequence_name,  
p.TABLE_NAME as table_name,      
p.TABLE_TIPO as table_tipo,  
P.NEXT_SEQUENCE_ID AS netx_sequence_id,      
NULL AS CREATED, NULL AS CREATED_BY,            
NULL AS OWNER_ID, NULL AS UPDATED,            
NULL AS UPDATED_BY, 0 AS IS_DELETED             
from PM_SEQUENCE_TABLE p

GO

