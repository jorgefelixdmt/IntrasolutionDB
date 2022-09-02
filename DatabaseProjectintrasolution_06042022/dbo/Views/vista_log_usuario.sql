

/*
****************************************************************************************************************************************
Nombre: dbo.[vista_log_usuario]
Fecha Creacion: 20/08/2019
Autor: Mauro Roque
Descripcion: Lista Registros de session por usuarios
Llamado por: js
Usado por: Modulo: Log Usuarios
Uso: select * from [vista_log_usuario] order by fecha_ingreso desc
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
29-04-2020				mauro roque				se agrego el campo "authentication_type"
												1: SQL, 2: Active Directory, 3: función personalizada
**********************************************************************************************************
*/
CREATE view [dbo].[vista_log_usuario]        
as        
	select         
		logi.sc_login_log_id,        
		logi.remote_ip,
		logi.[user] as  login_usuario,        
		logi.user_name as nombre_usuario,        
		logi.date as fecha_ingreso,   
		convert(char(5), logi.date, 108) as hh_mm,      
		case logi.type
		when 1 then 'Sesión Iniciada'
		when 2 then 'Sesión Finalizada'
		when 3 then 'Ingreso a Modulo'
		else NULL end as type,     
		user_u.DNI dni,        
		logi.id_uea as fb_uea_pe_id,  
		 logi.module_id as modulo_id,  
		 logi.module_name as nombre_modulo,  
		 logi.access_type_id as tipo_acceso_id,  
		 logi.access_type_name as nombre_acceso, 
		 uea.nombre as nombre_uea,  
		case logi.authentication_type
		when 1 then 'SQL'
		when 2 then 'Active Directory'
		when 3 then 'Funcion Personalizada - Fortuna'
		else 'Otros' end as authentication_type,
		NULL AS CREATED,            
		NULL   AS CREATED_BY,             
		NULL AS OWNER_ID,            
		NULL AS UPDATED,            
		NULL AS UPDATED_BY,             
		0 AS IS_DELETED          
	from sc_login_log logi         
	left join sc_user user_u on  logi.user_name=user_u.name         
	left join fb_uea_pe uea on uea.fb_uea_pe_id = logi.id_uea

GO

