



/*
procedure: dbo.uf_link_descarga
create date (YYYY-MM-DD): 2019-01-01
Autor: dominiotech
description: esta función concatena una cadena  con formato URL que sirve para que desde las grillas se pueda descargar los documentos al dar clic en los íconos
Call by: esta función como es genérica es llamado desde varios objetos:
			vistas
			código java (clases bean)
affected table(s): no afecta ninguna tabla
Used By: Esta función es parte del framework por lo tanto es usado por varios módulos
Parameter(s): @nombre_archivo - nombre del archivo que se desea descargar
				@ruta_personalizada - código de la ruta física donde el framework buscará el documento a descargar.
fecha actualizacion :
24-06-2020  Mauro Max : se agrego un estilo a la opcion PDF para que mueste "la manito" en el icono pdf de la grilla generica
*/
CREATE function [dbo].[uf_link_descarga] (@nombre_archivo varchar(500), @ruta_personalizada varchar(100))  
returns varchar(1000)  
  
As  
Begin  
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
   
   
 set @retorno_final = ''  
   
 if(@nombre_archivo != '')  
 begin  
   
   select @app_name = value from PM_PARAMETER where CODE = 'WAR'  
     
   set @ruta_imagen_pdf = '/'+@app_name+'/classpathResources/com/limati/framework/statics/common/images/png/pdf1.png'  
     
   set @ruta_imagen_xls = '/'+@app_name+'/classpathResources/com/limati/framework/statics/common/images/png/excel1.png'  
     
   set @ruta_imagen_word = '/'+@app_name+'/classpathResources/com/limati/framework/statics/common/images/png/word5.png'  
     
   set @ruta_imagen_access = '/'+@app_name+'/classpathResources/com/limati/framework/statics/common/images/png/access.png'  
     
   set @ruta_imagen_imagen = '/'+@app_name+'/classpathResources/com/limati/framework/statics/common/images/png/foto.png'  
     
   set @ruta_imagen_ppt = '/'+@app_name+'/classpathResources/com/limati/framework/statics/common/images/png/powerpoint1.png'  
     
   set @ruta_imagen_project = '/'+@app_name+'/classpathResources/com/limati/framework/statics/common/images/png/project.png'  
     
   set @ruta_imagen_visio = '/'+@app_name+'/classpathResources/com/limati/framework/statics/common/images/png/visio.png'  
     
   set @ruta_imagen_zip = '/'+@app_name+'/classpathResources/com/limati/framework/statics/common/images/png/zip.png'  
     
   set @ruta_imagen_otros = '/'+@app_name+'/classpathResources/com/limati/framework/statics/common/images/gif/article.gif'  
      
	if(charindex('.',reverse(@nombre_archivo))=0)
	begin
	return ''
	end
	

   set @extension = reverse(left(reverse(@nombre_archivo),charindex('.',reverse(@nombre_archivo))-1))  
     
   if(@ruta_personalizada IS NULL)  
   begin  
    set @ruta_alterna = 'null'  
   end  
   else  
   begin  
      
    IF EXISTS (select TOP 1 value from PM_PARAMETER WHERE CODE = @ruta_personalizada)  
     BEGIN  
      set @ruta_alterna = @ruta_personalizada  
     END  
       
    ELSE  
     BEGIN  
     set @ruta_alterna = 'null'  
     END  
      
   end  
     
   ------------------------------------  
      
   if(@extension = 'pdf')  
   begin  
    set @ruta_imagen = @ruta_imagen_pdf  
   end  
   -----------------------------------------  
   else if(@extension = 'xls' or @extension = 'xlsx')  
   begin  
    set @ruta_imagen = @ruta_imagen_xls  
   end  
   ------------------------------------------  
   else if(@extension = 'doc' or @extension = 'docx')  
   begin  
    set @ruta_imagen = @ruta_imagen_word  
   end  
     
   else if(@extension = 'ppt' or @extension = 'pptx')  
   begin  
    set @ruta_imagen = @ruta_imagen_ppt  
   end   
     
   else if(@extension = 'vsd' or @extension = 'vsdx')  
   begin  
    set @ruta_imagen = @ruta_imagen_visio  
   end  
     
   else if(@extension = 'mpp')  
   begin  
    set @ruta_imagen = @ruta_imagen_project  
   end     
     
   else if(@extension = 'zip' or @extension = 'rar')  
   begin  
    set @ruta_imagen = @ruta_imagen_zip  
   end      
     
   else if(@extension = 'png' or @extension = 'jpg' or @extension = 'bmp')  
   begin  
    set @ruta_imagen = @ruta_imagen_imagen  
   end  

   else if(@extension = 'accdb')  
   begin  
    set @ruta_imagen = @ruta_imagen_access  
   end    
     
     
   else  
   begin  
    set @ruta_imagen = @ruta_imagen_otros  
   end  
   ------------------------------------------   <div style="cursor: pointer; cursor: hand;">EJEMPLO MANO </div> 
    
	-- select dbo.fn_FormatFileSize(archivo_size))
	declare @tamño_archivo varchar(20)

	set @tamño_archivo = (select dbo.fn_FormatFileSize((select archivo_size from g_enlace where archivo=@nombre_archivo)))


   if(@extension = 'pdf')  
   begin  
    set @url = '/'+@app_name+'/document/downloadImage2/458701/8253/'+@nombre_archivo+'/'+@ruta_alterna 
	set @url_retorno = '<center><div  title="Tamaño.." style="cursor: pointer; cursor: hand;" alt="Ver" href="#" onclick="abrirPDF('''+@url+''' )" target="_blank"><img src="'+@ruta_imagen+'"> </div><center>' 
   end  


    else if(@extension = 'doc' or @extension = 'docx')  
   begin  
    set @url = '/'+@app_name+'/document/downloadImage2/458701/8253/'+@nombre_archivo+'/'+@ruta_alterna 
	set @url_retorno = '<center><div href="#" onclick="abrirDoc('''+@url+''' )" target="_blank"><img src="'+@ruta_imagen+'"></div><center>'   
   end 
   
   /*
   -----------------------------------------  
   else if(@extension = 'xls' or @extension = 'xlsx')  
   begin  
    set @url = '/'+@app_name+'/document/downloadImage2/458701/8253/'+@nombre_archivo+'/'+@ruta_alterna 
	set @url_retorno = '<center><div href="#" onclick="abrirDoc('''+@url+''' )" target="_blank"><img src="'+@ruta_imagen+'"></div><center>'  
   end  
   ------------------------------------------  
   
     
   else if(@extension = 'ppt' or @extension = 'pptx')  
   begin  
    set @url = '/'+@app_name+'/document/downloadImage2/458701/8253/'+@nombre_archivo+'/'+@ruta_alterna 
	set @url_retorno = '<center><div href="#" onclick="abrirDoc('''+@url+''' )" target="_blank"><img src="'+@ruta_imagen+'"></div><center>'  
   end   
   */
   else  
   begin  
	set @url = '/'+@app_name+'/document/downloadImage/458701/8253/'+@nombre_archivo+'/'+@ruta_alterna 
	set @url_retorno = '<center><a href="'+@url+'" target="_blank"><img src="'+@ruta_imagen+'"></a><center>'  
   end 

     
 END  
 else  
 begin  
  set @url_retorno = ''   
 end  
   
 set @retorno_final = @url_retorno  
   
 return (@retorno_final)  
End

GO

