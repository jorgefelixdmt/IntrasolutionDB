    
CREATE proc pr_doc_delete_folder_usuarios    
@doc_folder_id numeric(10,0)    
as    
    
declare @nro_doc numeric(10,0)     
declare @nro_folder numeric(10,0)     
declare @retorno varchar(200)    
declare @contador numeric(1,0)    
     
 select @nro_doc=COUNT(*)    
 from doc_documento    
 where doc_folder_id=@doc_folder_id and is_deleted=0    
    
 select @nro_folder= COUNT(*)    
  from doc_folder     
  where doc_folder_padre_id=@doc_folder_id    
      
 if (@nro_doc=0 and @nro_folder=0)    
 begin    
 delete from doc_folder where doc_folder_id=@doc_folder_id    
 set @retorno='Folder Eliminado'    
 set @contador=1    
 end    
else    
begin    
    set @retorno ='Folder contiene Nro Docs : '+CONVERT(varchar,@nro_doc)+' y Nro Folders : '+CONVERT(varchar,@nro_folder)    
 set @contador=0    
 end    
  select @retorno as mensaje , @contador as contador

GO

