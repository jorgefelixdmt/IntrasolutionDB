CREATE Proc [dbo].[pr_doc_Documento_Version_Upd]  
@in_id_doc int, --- NUEVO ID DEL PADRE  
@older_id_doc int -- ID DEL PADRE ANTERIOR  
As  
  
  
-- A TODOS LOS HIJOS DEL PADRE ANTEIOR LE COLOCA EL ID DEL NUEVO PADRE   
UPDATE        doc_documento  
Set           flag_version='V' ,  
              doc_documento_origen_id=@in_id_doc  
WHERE doc_documento_origen_id= @older_id_doc  
  
-- AL NUEVO PADRE LE COLOCA EL TIPO                 
UPDATE doc_documento set flag_version='D'  
WHERE doc_documento_id = @in_Id_doc

GO

