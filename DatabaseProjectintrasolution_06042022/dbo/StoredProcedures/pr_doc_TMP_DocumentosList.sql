Create proc [dbo].[pr_doc_TMP_DocumentosList]
	@Usuario_id numeric(10,0)
As
Select * from doc_documento 
	Where (doc_folder_id not in (select doc_folder_id from doc_folder_empleado Where fb_uea_pe_id = 1)
		or doc_folder_id in (select doc_folder_id from doc_folder_empleado
								Where fb_empleado_id = @usuario_id and fb_uea_pe_id = 1))
		--or Tipo_Permiso = 'P') -- Publicador
		and flag_version = 'D'

GO

