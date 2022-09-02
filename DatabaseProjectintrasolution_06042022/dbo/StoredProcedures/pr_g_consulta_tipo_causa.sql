


/*  
Autor  : Mauro Max   
Fecha  : 23 - 02 - 2017  
Descripcion : consulta tipo causa   
  
  
 exec pr_g_consulta_tipo_causa 2  
*/  
CREATE PROC pr_g_consulta_tipo_causa  
@id_causa NUMERIC(10,0)  
as  
SELECT    
  codigo,  
  descripcion,  
  nivel,  
  codigoRel  
 FROM   g_tipo_causa  
 WHERE   
  g_tipo_causa_id=@id_causa  
  and is_deleted =0

GO

