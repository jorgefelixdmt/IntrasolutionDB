
  
  
CREATE FUNCTION [dbo].[uf_doc_Ruta_Documento] (    
 @doc_documento_id numeric(10,0)    
)    
RETURNS nvarchar(200)    
AS    
BEGIN    
     
 Declare @doc_folder_id numeric(10,0), @ruta_temporal varchar(200), @doc_folder_padre_id numeric(10,0), @nombre_folder varchar(200)    
 Set @ruta_temporal = ''    
     
    
 Select @doc_folder_id = doc_folder_id from doc_documento where doc_documento_id = @doc_documento_id    
 Set @nombre_folder = (select nombre from doc_folder where doc_folder_id = @doc_folder_id)    
 Set @doc_folder_id = (select doc_folder_padre_id from doc_folder where doc_folder_id = @doc_folder_id)    
     
 Set @ruta_temporal = @nombre_folder    
    
 WHILE @doc_folder_id <> 0    
    BEGIN    
   Set @nombre_folder = (select nombre from doc_folder where doc_folder_id = @doc_folder_id)    
   Set @ruta_temporal = @nombre_folder + ' \ ' + @ruta_temporal    
   Set @doc_folder_id = (select doc_folder_padre_id from doc_folder where doc_folder_id = @doc_folder_id)    
    END    
     
 Return(@ruta_temporal)    
END;

GO

