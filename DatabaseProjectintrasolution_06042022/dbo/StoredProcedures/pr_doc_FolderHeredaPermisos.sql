CREATE PROC [dbo].[pr_doc_FolderHeredaPermisos]
(
	@Id_Folder_Inicial numeric(10,0),
	@fb_usuario_id numeric(10,0)
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Id_Folder numeric(10,0)

	-- **** Selecciona el primer folder hijo	
	SET @Id_Folder = (SELECT Top 1 doc_folder_id FROM doc_folder WHERE doc_folder_padre_id = @Id_Folder_Inicial Order by doc_folder_id)

	WHILE @Id_Folder IS NOT NULL
	BEGIN
		-- **** Elimina los permisos existentes y le coloca los del folder padre
		Delete doc_folder_empleado Where doc_folder_id = @Id_Folder

		-- **** Copia los permisos del folder padre al folder hijo
		INSERT INTO doc_folder_empleado 
			SELECT  doc_folder_id=@Id_Folder,
					fb_empleado_id,
					tipo_permiso,
					created=GETDATE(),
					created_by=@fb_usuario_id,
					UPDATed=GETDATE(),
					updated_by=@fb_usuario_id,
					owner_id=@fb_usuario_id,
					is_deleted=0
				from doc_folder_empleado 
				Where doc_folder_id = @Id_Folder_Inicial

		-- **** Ejecuta el proceso de Heredar para los folder nieto
		EXEC dbo.pr_doc_FolderHeredaPermisos @Id_Folder, @fb_usuario_id

		-- **** Selecciona el siguiente folder hijo
		SET @Id_Folder = (SELECT Top 1 doc_folder_id FROM doc_folder WHERE doc_folder_padre_id = @Id_Folder_Inicial And doc_folder_id > @Id_Folder Order By doc_folder_id)
	END
END

GO

