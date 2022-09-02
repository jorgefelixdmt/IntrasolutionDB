/**
NOMBRE: [dbo].[pr_graf_inc_calendario_incidencia_combo]
CREACION: 2022-01-09
AUTOR: Jorge Felix
DESCRIPCION: Retorna nombres y id de las incidencias donde el empleado es responsable
USADO POR: Registro de Tareas/Ejecución/Registro de Tareas
**/


CREATE PROCEDURE [dbo].[pr_graf_inc_calendario_incidencia_combo]
@sc_user_id numeric(10,0)
AS
BEGIN
	Declare @fb_empleado_id numeric(10,0)
	Set @fb_empleado_id = (Select fb_empleado_id from sc_user where sc_user_id = @sc_user_id)

		select DISTINCT inc_incidencia_id id,
		codigo_ticket
			from inc_incidencia
			where is_deleted = 0 and fb_empleado_id = @fb_empleado_id
END

GO

