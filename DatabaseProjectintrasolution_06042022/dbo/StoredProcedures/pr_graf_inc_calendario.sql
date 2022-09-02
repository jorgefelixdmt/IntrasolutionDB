/**
	NOMBRE: [dbo].[pr_graf_inc_calendario] 
	FECHA: 2022-01-09
	AUTOR: Jorge Felix
	DESCRIPCION: Raliza la funcion de Agregar, Editar y eliminar de las tareas del colaborador
	TABLA AFECTADA: inc_incidencia_hh
	USADO POR: Intrasolution->Registro de Tareas
	PARAMETROS:
		@anio: año o 0
		@tareaid => id del Registro de Tarea
		@usuario_id=> id del usuario asignado a esa tarea
		pr_graf_inc_calendario 0,0,1
**/

CREATE PROCEDURE [dbo].[pr_graf_inc_calendario]
@anio int,
@tareaid int,
@usuario_id int
AS
BEGIN

	Declare @fb_empleado_id numeric(10,0)
	Set @fb_empleado_id =(Select fb_empleado_id from sc_user where sc_user_id = @usuario_id)

	Select distinct
		h.inc_incidencia_hh_id 'id',
		'codigo' = isnull(h.codigo,''),
		'ticket' = isnull(inc.codigo_ticket,''),
		h.inc_incidencia_id 'incidencia_id',
		h.inc_tipo_tarea_id 'tipo_tarea_id',
		'nombre_tipo_tarea' = isnull(tt.nombre,''),
		h.inc_subtipo_tarea_id 'subtipo_tarea_id',
		'nombre_subtipo_tarea' = isnull(st.nombre,''),
		'nombre' = isnull(emp.nombreCompleto,''),
		emp.fb_empleado_id 'nombre_id',
		'hora_inicio' =  isnull(h.fecha_hora_inicio,''),
		'hora_fin' = isnull(h.fecha_hora_fin,''),
		'observacion' = isnull(h.observacion,'')
	From inc_incidencia_hh h
	inner join inc_incidencia inc on inc.inc_incidencia_id = h.inc_incidencia_id
	inner join fb_empleado emp on emp.fb_empleado_id = inc.fb_empleado_id
	left join inc_tipo_tarea tt on tt.inc_tipo_tarea_id = h.inc_tipo_tarea_id
	left join inc_subtipo_tarea st on st.inc_subtipo_tarea_id = h.inc_subtipo_tarea_id
	Where (h.inc_incidencia_hh_id = @tareaid or @tareaid = 0)
	and (emp.fb_empleado_id = @fb_empleado_id or @fb_empleado_id = 0)
	and (year(h.fecha_hora_inicio)=@anio or @anio=0)
	and h.is_deleted=0
END

GO

