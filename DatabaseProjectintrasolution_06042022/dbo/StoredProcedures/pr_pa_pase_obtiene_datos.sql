/*      
****************************************************************************************************************************************
Nombre: dbo.pr_pa_pase_obtiene_datos
Fecha Creacion: 02/06/2020
Autor: Mauro Roque
Descripcion:  Store que obtiene datos del pase software
Llamado por: js
Usado por: Modulo: Pases de Software
Parametros: @id_pase - ID pase 
Uso: pr_pa_pase_obtiene_datos 140032
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
14/01/2022				Mauro Roque		   se separó el select de los resultados de la variable @cadena
										   antes : 	select 'pr_Pase_SW_Inicia_Pase ' + @cadena + ' </br> </br> ' + 'pr_Pase_SW_Fin_Pase ' + @cadena as cadena
										   ahora :  select 'exec pr_Pase_SW_Inicia_Pase ' + @cadena as cadena_inicio,
											      'exec pr_Pase_SW_Fin_Pase ' + @cadena as cadena_fin
**********************************************************************************************************
*/
	
	CREATE proc [dbo].[pr_pa_pase_obtiene_datos]
	@id_pase varchar(max)
	as
	begin
	declare @cadena varchar(500)
	 
	SET @cadena = (
					select 
						convert(varchar(10),pas.pa_pase_id)+','''+
						ISNULL(pas.codigo_jira,'')+''','+
						convert(varchar(10),ISNULL(tip.pl_tipo_pase_id,0)) + ','''+
						ISNULL(pas.version,'')+ ''','''+
						ISNULL(pas.descripcion,'')+ ''','+
						convert(varchar(10),ISNULL(pas.flag_version_requerida_app,0))+ ','''+
						ISNULL(pas.version_requerida_app,'')+ ''','+
						convert(varchar(10),ISNULL(pas.flag_version_requerida_Frw,0))+ ','''+
						ISNULL(pas.version_requerida_frw,'') +''','+
						convert(varchar(10),ISNULL(pas.flag_version_requerida_app_std,0))+ ','''+
						ISNULL(pas.version_requerida_app_std,'') +''''
	                from pa_pase pas 
						left join pl_tipo_pase tip on pas.pl_tipo_pase_id = tip.pl_tipo_pase_id
					where pas.pa_pase_id = @id_pase 
				  )

	select 'exec pr_Pase_SW_Inicia_Pase ' + @cadena as cadena_inicio,
		   'exec pr_Pase_SW_Fin_Pase ' + @cadena as cadena_fin

	end

GO

