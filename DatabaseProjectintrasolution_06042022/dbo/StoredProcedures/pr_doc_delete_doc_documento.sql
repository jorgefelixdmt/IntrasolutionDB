  
  
CREATE proc pr_doc_delete_doc_documento    
@doc_documento_id numeric(10,0)    
as    
--select titulo from doc_documento    
delete from doc_documento    
where doc_documento_id=@doc_documento_id

GO

