/*      
****************************************************************************************************************************************
Nombre: dbo.pr_g_consulta_campos_url
Fecha Creacion: 09/07/2020
Autor: Mauro Roque
Descripcion: store que retona una url con extension https, agregando icono mundo en grilla
Llamado por: js
Usado por: Modulo: Enlaces Documentos
Parametros: @id_tabla - ID del tabla
			@tipo_table - Nombre de tabla donde obtiene el campo "url"
Uso: exec pr_g_consulta_campos_url 1,'G_ENLACE'
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
CREATE proc pr_g_consulta_campos_url
@id_tabla int,
@tipo_table varchar(50)
as
begin
declare @url_retorno varchar(500),@url_campo varchar(500),@ruta_imagen_MUNDO varchar(500)
   
  set @ruta_imagen_MUNDO = '/Iconos_Semaforo/mundo.png'    

 
  if @tipo_table = 'G_ENLACE'
  BEGIN
	 
	  select @url_campo=isnull(enlace_drive,'')  
	  from g_enlace 
	  where g_enlace_id = @id_tabla and enlace_drive like'%https://%'


		if @url_campo <> ''
			begin
				set @url_retorno = '<center><a href="'+@url_campo+'" target="_blank"><img src="'+@ruta_imagen_MUNDO+'"></a><center>'  
			end
	  else 
		  begin
				select @url_retorno= enlace_drive  from g_enlace  where g_enlace_id = @id_tabla
		  end
  END
   
  select isnull(@url_retorno,'') as url_campo

end

GO

