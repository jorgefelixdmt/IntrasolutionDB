/**
NOMBRE: [dbo].[pr_ws_inc_calendario_planes_accion_combo]
CREACION: 2022-03-22
AUTOR: Jorge Felix
DESCRIPCION: Retorna nombres y id de los planes de accion donde el empleado es responsable para el webservice aplicacion movil
USADO POR: Registro de Tareas/Ejecución/Registro de Tareas
pr_ws_inc_calendario_planes_accion_combo 16
**/


CREATE PROCEDURE [dbo].[pr_ws_inc_calendario_planes_accion_combo]
@sc_user_id numeric(10,0)
AS
BEGIN

	Declare @fb_empleado_id numeric(10,0)
	Set @fb_empleado_id = (Select fb_empleado_id from sc_user where sc_user_id = @sc_user_id)
		Select 
			sac_accion_correctiva_id,
			codigo_accion_correctiva,
			accion_correctiva_detalle
		From sac_accion_correctiva
		Where fb_empleado_id_correcion = @fb_empleado_id and is_deleted = 0 and sac_estado_accion_correctiva_id in(1,2,5)
END

GO

