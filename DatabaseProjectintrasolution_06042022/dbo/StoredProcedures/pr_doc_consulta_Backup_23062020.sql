


/*      
****************************************************************************************************************************************
Nombre: dbo.[pr_doc_consulta_Backup_23062020]
Fecha Creacion: 23-06-2020
Autor: Mauro Roque
Descripcion: se ha creado un backup del store pr_doc_consulta con el nombre pr_doc_consulta_Backup_23062020 no utiliza la funcion
			 Link descarga, que permite visualizar documentos PDF.
Llamado por: SC_WEBSERVICE
Usado por: Modulo: Biblioteca de Documentos
Parametros: @doc_folder_id - ID del Documento
Uso: exec [pr_doc_consulta] 5
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/ 
create proc [dbo].[pr_doc_consulta_Backup_23062020]               
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
     
     
 /*set @retorno_final = ''    
   
  select        
		@nombre_archivo = archivo  
	from doc_documento 
	where is_deleted = 0 
		and doc_folder_id = @doc_folder_id  
		and flag_version='D'
	*/	
     
 -- exec pr_doc_consulta 15
 select @app_name = value from PM_PARAMETER where CODE = 'WAR'    
   
   set @ruta_imagen_pdf = '/'+@app_name+'/classpathResources/com/limati/framework/statics/common/images/png/pdf1.png'  
         
		   
    set @url = '/'+@app_name+'/document/downloadImage2/458701/8253/'+@nombre_archivo+'/'+@ruta_alterna 
	       
 select        
   *, 
   CASE 
   WHEN (archivo is null OR archivo = '') THEN ''

   WHEN (reverse(left(reverse(archivo),charindex('.',reverse(archivo))-1)))= 'pdf' 	
   --THEN '<center><img src="'+'/'+@app_name+'/classpathResources/com/limati/framework/statics/common/images/png/pdf1.png'+'"></a><center><center>'
   THEN '<center><img src="'+'/'+@app_name+'/classpathResources/com/limati/framework/statics/common/images/png/pdf1.png'+'"></a><center><center>'
 
 --then '<center><div href="#" onclick="abrirPDF('''+@url+''' )" target="_blank"><img src="'+'/'+@app_name+'/classpathResources/com/limati/framework/statics/common/images/png/pdf1.png'+'"></div><center>'

	--set @url_retorno = '<center><div href="#" onclick="abrirPDF('''+@url+''' )" target="_blank"><img src="'+@ruta_imagen_pdf+'"></div><center>' 

   WHEN ((reverse(left(reverse(archivo),charindex('.',reverse(archivo))-1)))= 'xls' OR (reverse(left(reverse(archivo),charindex('.',reverse(archivo))-1)))= 'xlsx') 	THEN '<center><img src="'+'/'+@app_name+'/classpathResources/com/limati/framework/statics/

common/images/png/excel1.png'+'"></a><center><center>'
   WHEN ((reverse(left(reverse(archivo),charindex('.',reverse(archivo))-1)))= 'doc' OR (reverse(left(reverse(archivo),charindex('.',reverse(archivo))-1)))= 'docx') 	THEN '<center><img src="'+'/'+@app_name+'/classpathResources/com/limati/framework/statics/

common/images/png/word5.png'+'"></a><center><center>'
   WHEN ((reverse(left(reverse(archivo),charindex('.',reverse(archivo))-1)))= 'ppt' OR (reverse(left(reverse(archivo),charindex('.',reverse(archivo))-1)))= 'pptx') 	THEN '<center><img src="'+'/'+@app_name+'/classpathResources/com/limati/framework/statics/

common/images/png/powerpoint1.png'+'"></a><center><center>'
   WHEN ((reverse(left(reverse(archivo),charindex('.',reverse(archivo))-1)))= 'vsd' OR (reverse(left(reverse(archivo),charindex('.',reverse(archivo))-1)))= 'vsdx') 	THEN '<center><img src="'+'/'+@app_name+'/classpathResources/com/limati/framework/statics/

common/images/png/visio.png'+'"></a><center><center>'
   WHEN ((reverse(left(reverse(archivo),charindex('.',reverse(archivo))-1)))= 'mpp' OR (reverse(left(reverse(archivo),charindex('.',reverse(archivo))-1)))= 'mppx') 	THEN '<center><img src="'+'/'+@app_name+'/classpathResources/com/limati/framework/statics/

common/images/png/project.png'+'"></a><center><center>'
   WHEN ((reverse(left(reverse(archivo),charindex('.',reverse(archivo))-1)))= 'zip' OR (reverse(left(reverse(archivo),charindex('.',reverse(archivo))-1)))= 'rar') 	THEN '<center><img src="'+'/'+@app_name+'/classpathResources/com/limati/framework/statics/c

ommon/images/png/zip.png'+'"></a><center><center>'
   WHEN ((reverse(left(reverse(archivo),charindex('.',reverse(archivo))-1)))= 'png' OR (reverse(left(reverse(archivo),charindex('.',reverse(archivo))-1)))= 'jpg' OR (reverse(left(reverse(archivo),charindex('.',reverse(archivo))-1)))= 'bmp') 	THEN '<center

><img src="'+'/'+@app_name+'/classpathResources/com/limati/framework/statics/common/images/png/foto.png'+'"></a><center><center>'
   WHEN ((reverse(left(reverse(archivo),charindex('.',reverse(archivo))-1)))= 'accdb') 	THEN '<center><img src="'+'/'+@app_name+'/classpathResources/com/limati/framework/statics/common/images/png/access.png'+'"></a><center><center>'
   ELSE '<center><img src="'+'/'+@app_name+'/classpathResources/com/limati/framework/statics/common/images/gif/article.gif'+'"></a><center><center>'
   END as icono
 from doc_documento where is_deleted = 0 and doc_folder_id = @doc_folder_id and flag_version='D' 
  
  
END

GO

