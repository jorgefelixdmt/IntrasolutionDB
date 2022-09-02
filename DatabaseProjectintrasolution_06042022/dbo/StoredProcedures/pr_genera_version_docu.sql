  
  
  
  
  CREATE proc [dbo].[pr_genera_version_docu]      
    
 @doc_documento_id numeric(10,0),    
 @version   varchar(3)          
   As      
          
   DECLARE @contador int      
    
 SET @version = right('00'+ convert(varchar,convert(int,@version)+1),3)     
     
 Update doc_documento     
  Set version =  @version    
  Where doc_documento_id = @doc_documento_id

GO

