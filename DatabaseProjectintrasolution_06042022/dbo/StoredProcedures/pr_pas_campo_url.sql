

/*      
****************************************************************************************************************************************
Nombre: dbo.pr_pas_campo_url
Fecha Creacion: 25/05/2020
Autor: Mauro Roque
Descripcion: store que retona una url con extension https, agregando icono mundo en grilla
Llamado por: js
Usado por: Modulo: Pases de Software
Parametros: @id_pase - ID del pase
Uso: exec pr_pas_campo_url 5
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
create proc pr_pas_campo_url
@id_pase int
as
begin
declare @app_name varchar(200)
declare @url_retorno varchar(500),@url_pase varchar(500),@ruta_imagen varchar(500),@ruta_imagen_pdf varchar(500)
   
  select @app_name = value from PM_PARAMETER where CODE = 'WAR'  

  --set @ruta_imagen_pdf = '/'+@app_name+'/classpathResources/com/limati/framework/statics/common/images/png/zip.png'   

  set @ruta_imagen_pdf = '/Iconos_Semaforo/mundo.png'    


  select @url_pase=isnull(url_pase,'')  from pa_pase where pa_pase_id = @id_pase

   if @url_pase <> ''
  begin
   set @url_retorno = '<center><a href="'+@url_pase+'" target="_blank"><img src="'+@ruta_imagen_pdf+'"></a><center>'  

  end
 
  select isnull(@url_retorno,'') as url_pase

end

GO

