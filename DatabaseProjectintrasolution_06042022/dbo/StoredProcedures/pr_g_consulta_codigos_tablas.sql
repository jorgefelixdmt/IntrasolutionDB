






/*      
****************************************************************************************************************************************
Nombre: dbo.[pr_g_consulta_codigos_tablas]
Fecha Creacion: 27/02/2020
Autor: Mauro Roque
Descripcion: Store que consulta los codigos autogenerados del sistema
Llamado por: javascript
Usado por: Varios Modulos
Parametros: @parametro Primary key de la tabla
Uso: [pr_g_consulta_codigos_tablas] 1
**************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
12/07/2021				Mauro Roque				se agrego variable para el campo codigo de la tabla sol_solicitud
08/03/2022				Mauro Roque				se agrego variable para el campo codigo de la tabla inc_prueba
**********************************************************************************************************
*/
CREATE proc [dbo].[pr_g_consulta_codigos_tablas]       --125                     
@parametro numeric(10,0)                            
as                      
declare @codigo_propuesta varchar(50)   
declare @codigo_proyecto varchar(50)
declare @codigo_vacaciones varchar(50)  
declare @codigo_documentario varchar(50)  

declare @cod_sospechoso varchar(200) 
declare @cod_control_covid varchar(200) 
declare @cod_incidencia varchar(200) 
declare @cod_accidente varchar(200) 
declare @cod_sac varchar(200)    
declare @cod_capacitacion varchar(200)    
declare @id_estado_incidencia int

declare @cod_sol_categoria varchar(200)    
declare @cod_sol_solicitud varchar(200)       

declare @cod_prueba varchar(200) 

set @codigo_propuesta = (select codigo from pro_propuesta where pro_propuesta_id = @parametro)   
set @codigo_proyecto = (select codigo from pry_proyecto where pry_proyecto_id = @parametro)   
set @codigo_vacaciones = (select codigo from vac_solicitud_vacaciones where vac_solicitud_vacaciones_id = @parametro)   
set @codigo_documentario = (select codigo from dc_documento where dc_documento_id = @parametro)   

set @cod_sospechoso  = (select numero_caso from cv_caso_sospechoso where cv_caso_sospechoso_id = @parametro)    
set @cod_control_covid  = (select codigo from cv_control_covid_diario where cv_control_covid_diario_id = @parametro)    
set @cod_incidencia  = (select codigo_ticket from inc_incidencia where inc_incidencia_id = @parametro)    
         
set @cod_accidente  = (select codigo from inc_informe_final where inc_informe_final_id = @parametro)    
set @cod_sac  = (select codigo_accion_correctiva from sac_accion_correctiva where sac_accion_correctiva_id = @parametro)    
set @cod_capacitacion  = (select codigo from cap_curso where cap_curso_id = @parametro)    

set @id_estado_incidencia  = (select inc_estado_incidencia_id from inc_incidencia where inc_incidencia_id = @parametro) 
 
set @cod_sol_categoria  = (select codigo from sol_item where sol_item_id = @parametro) 
set @cod_sol_solicitud  = (select codigo from sol_solicitud where sol_solicitud_id = @parametro) 
set @cod_prueba  = (select codigo from inc_prueba where inc_prueba_id = @parametro) 

           				   
select  @codigo_propuesta as codigo_propuesta,
		@codigo_proyecto as codigo_proyecto,
		@codigo_vacaciones as codigo_vacaciones,
		@codigo_documentario as codigo_documentario,
		@cod_sospechoso as cod_sospechoso,
		@cod_control_covid as cod_control_covid,
		@cod_incidencia as cod_incidencia,
		@cod_accidente as cod_accidente,
		@cod_sac as cod_sac,
		@cod_capacitacion as cod_capacitacion,
		@id_estado_incidencia as id_estado_incidencia,
		@cod_sol_categoria as cod_sol_item,
		@cod_sol_solicitud as cod_solicitud,
		@cod_prueba as cod_prueba

GO

