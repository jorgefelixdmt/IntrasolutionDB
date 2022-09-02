CREATE PROCEDURE [dbo].[pr_doc_FolderCopiarPermisos] --5975,1
(
	@doc_folder_id numeric(10,0),
	@fb_usuario_id numeric(10,0)
)
AS
BEGIN
	Declare @doc_folder_padre_id numeric(10,0)
    -- Recupera el id del folder padre
    SET @doc_folder_padre_id = (SELECT doc_folder_padre_id FROM doc_folder WHERE doc_folder_id =@doc_folder_id)

	Begin

INSERT INTO doc_folder_empleado 
SELECT  doc_folder_id = @doc_folder_id,
fb_empleado_id,
tipo_permiso,
created=GETDATE(),
created_by=@fb_usuario_id,
UPDATed=GETDATE(),
updated_by=@fb_usuario_id,
owner_id=@fb_usuario_id,
is_deleted=0
from doc_folder_empleado 
Where doc_folder_id =@doc_folder_padre_id
end
end

GO

