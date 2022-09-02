

/*      
****************************************************************************************************************************************
Nombre: dbo.[pr_doc_consulta]
Fecha Creacion: --
Autor: Carlos Cubas
Descripcion: store que lista los documentos y archivos con extension pdf,word,excel,etc
Llamado por: SC_WEBSERVICE
Usado por: Modulo: Biblioteca de Documentos
Parametros: @doc_folder_id - ID del Documento
Uso: exec [pr_doc_consulta] 5
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
23-06-2020			Mauro Roque				se agrego la funcion que descarga icono en grilla, para poder visualizar el documento
											PDF en la grilla del Arbol de documentos
**********************************************************************************************************
*/    
CREATE proc [dbo].[pr_doc_consulta]                   
@doc_folder_id numeric(10,0)        
as      
begin      
Declare         
 @url varchar(1000)        
 ,@url_retorno varchar(1000)        
 ,@ruta_imagen varchar(1000)        
 ,@ruta_imagen_pdf varchar(1000)        
 ,@ruta_imagen_xls varchar(1000)        
 ,@ruta_imagen_word varchar(1000)        
 ,@ruta_imagen_ppt varchar(1000)        
 ,@ruta_imagen_zip varchar(1000)        
 ,@ruta_imagen_project varchar(1000)        
 ,@ruta_imagen_visio varchar(1000)        
 ,@ruta_imagen_imagen varchar(1000)        
 ,@ruta_imagen_access varchar(1000)        
 ,@ruta_imagen_otros varchar(1000)        
 ,@extension varchar(1000)        
 ,@ruta_alterna varchar(1000)        
 ,@app_name varchar(1000)        
 ,@retorno_final varchar(1000)        
 ,@nombre_archivo varchar(1000)      
         
         
   
 select @app_name = value from PM_PARAMETER where CODE = 'WAR'        
  
 select            
   *,     
   dbo.uf_link_descarga(archivo,null) as icono    
 from doc_documento where is_deleted = 0 and doc_folder_id = @doc_folder_id and flag_version='D' 
      
END

GO

