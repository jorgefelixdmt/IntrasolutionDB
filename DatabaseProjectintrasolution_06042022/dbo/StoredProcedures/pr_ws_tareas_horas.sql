
/*
Nombre: dbo.pr_ws_tareas_horas
Fecha Creación: 10/03/2022
Autor: Jorge Felix
Descripción: Obtiene una lista de tareas por horas
Llamado por: Home Tareas
Usado por: Varios
Parámetro(s):   @usuario_id    Parámetros
	
Uso: exec pr_ws_tareas_horas 16

***********************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------
			
***********************************************************************************************

*/
CREATE procedure [dbo].[pr_ws_tareas_horas]
@usuario_id numeric(10,0)
as 

Set nocount on 

BEGIN
	
	Declare @fb_empleado_id numeric(10,0)
	Set @fb_empleado_id =(Select fb_empleado_id from sc_user where sc_user_id = @usuario_id)

	Select distinct
		h.inc_incidencia_hh_id 'id',
		--'codigo' = isnull(h.codigo,''),
		--'ticket' = isnull(inc.codigo_ticket,''),
		h.inc_incidencia_id 'incidencia_id',
		h.inc_tipo_tarea_id 'tipo_tarea_id',
		'nombre_tipo_tarea' = isnull(tt.nombre,''),
		h.inc_subtipo_tarea_id 'subtipo_tarea_id',
		'nombre_subtipo_tarea' = isnull(st.nombre,''),
		'nombre' = isnull(emp.nombreCompleto,''),
		emp.fb_empleado_id 'nombre_id',
		'fecha_inicio' =  isnull(h.fecha_hora_inicio,''),
		'hora_inicio' =  isnull(h.fecha_hora_inicio2,''),
		'fecha_fin' = isnull(h.fecha_hora_fin,''),
		'hora_fin' = isnull(h.fecha_hora_fin2,''),
		'observacion' = isnull(h.observacion,''),
		'incidencia' = inc.descripcion_incidente,
		'pase' = pa.descripcion,
		pase_id = pa.pa_pase_id,
		'accion_correctiva' = sac.accion_correctiva_detalle,
		accion_correctiva_id = sac.sac_accion_correctiva_id,
		codigo_accion = sac.codigo_accion_correctiva,
		'periodo' = periodo
	From inc_incidencia_hh h
	left join inc_incidencia inc on inc.inc_incidencia_id = h.inc_incidencia_id
	inner join inc_tipo_tarea tt on tt.inc_tipo_tarea_id = h.inc_tipo_tarea_id
	left join inc_subtipo_tarea st on st.inc_subtipo_tarea_id = h.inc_subtipo_tarea_id
	inner join fb_empleado emp on emp.fb_empleado_id = h.fb_empleado_responsable_id
	left join pa_pase pa on pa.pa_pase_id = h.pa_pase_id
	left join sac_accion_correctiva sac on sac.sac_accion_correctiva_id = h.sac_accion_correctiva_id
	Where 
	 (emp.fb_empleado_id = @fb_empleado_id or @fb_empleado_id = 0)
	and h.is_deleted=0
	order by fecha_inicio desc
END

GO

