  
CREATE PROC [dbo].[pr_doc_HeredaInsertaFolderEmpleado]    
(    
 @fb_empleado_id numeric(10,0),    
 @Id_Folder_Inicial numeric(10,0),    
 @fb_usuario_id numeric(10,0)    
)    
AS    
BEGIN    
 SET NOCOUNT ON    
 DECLARE @Id_Folder numeric(10,0)    
 DECLARE @mensaje varchar(200)    
    
  --SI EL EL FOLDER NO TIENE PERMISOS NO HACE NADA    
   IF NOT EXISTS (SELECT * FROM doc_folder_empleado WHERE  doc_folder_id=@Id_Folder_Inicial    
              AND IS_DELETED=0)      
  BEGIN    
   SELECT '' as mensaje    
   RETURN    
  END    
    
 --VERIFICA SI EL EMPLEADO TIENE PERMISOS EN EL FOLDER    
 IF NOT EXISTS (SELECT * FROM doc_folder_empleado     
    WHERE fb_empleado_id=@fb_empleado_id     
     AND doc_folder_id=@Id_Folder_Inicial AND IS_DELETED=0)       
       
  BEGIN    
   -- **** Selecciona el primer folder      
   SET @Id_Folder = (SELECT Top 1 doc_folder_id     
         FROM doc_folder    
         WHERE doc_folder_id = @Id_Folder_Inicial and doc_folder_padre_id <> 0     
         Order by doc_folder_id)    
       
   IF @Id_Folder IS NOT NULL    
    BEGIN    
     -- **** inserta los permisos     
     INSERT INTO doc_folder_empleado     
      (doc_folder_id,fb_empleado_id,tipo_permiso,created,created_by,UPDATed,updated_by,owner_id,is_deleted)    
      VALUES  ( @Id_Folder,    
        @fb_empleado_id,    
        'L',    
        GETDATE(),    
        @fb_usuario_id,    
        GETDATE(),    
        @fb_usuario_id,    
        @fb_usuario_id,    
        0)    
     SET @mensaje = 'El Sistema Otorgará los permisos a las carpetas para visualizar este documento'     
     select @mensaje as mensaje    
     -- **** Selecciona el siguiente folder padre    
     SET @Id_Folder = (SELECT Top 1 doc_folder_padre_id     
           FROM doc_folder    
           WHERE doc_folder_id = @Id_Folder_Inicial     
           Order By doc_folder_id)    
        
     -- **** Ejecuta el proceso de Heredar para los folder padre    
     EXEC dbo.pr_doc_HeredaInsertaFolderEmpleado @fb_empleado_id,@Id_Folder, @fb_usuario_id    
    END    
   END    
  ELSE    
   BEGIN    
      
    SET @mensaje = 'El Usuario ya tiene permisos.'     
     SELECT @mensaje as mensaje    
           
   END    
      
END

GO

