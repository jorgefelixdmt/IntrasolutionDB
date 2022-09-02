/**
NOMBRE: [dbo].[pr_graf_inc_calendario_empleado_combo] 16
CREACION: 2022-01-08
AUTOR: Jorge Felix
DESCRIPCION: Retorna nombres y id de los empledos que pueden ser responsables de alguna tarea
USADO POR: Registro de Tareas/Ejecución/Registro de Tareas
**/


CREATE PROCEDURE [dbo].[pr_graf_inc_calendario_empleado_combo]
@usuario_id numeric(10,0)
AS
BEGIN
		Declare @fb_empleado_id numeric(10,0)
		Set @fb_empleado_id = (Select fb_empleado_id from sc_user where sc_user_id = @usuario_id)

		select DISTINCT empleado.fb_empleado_id id,
		empleado.nombreCompleto empleado
			from fb_empleado empleado
			where empleado.is_deleted = 0 and estado = 1 and clase_trabajador ='ACT' and fb_empleado_id = @fb_empleado_id
END

GO

