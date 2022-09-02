/**
NOMBRE: [dbo].[pr_graf_inc_calendario_tipo_tarea_combo]
CREACION: 2022-01-09
AUTOR: Jorge Felix
DESCRIPCION: Retorna nombres y id de los tipos de tareas
USADO POR: Registro de Tareas/Ejecución/Registro de Tareas
**/


CREATE PROCEDURE [dbo].[pr_graf_inc_calendario_tipo_tarea_combo]

AS
BEGIN
		select DISTINCT inc_tipo_tarea_id id,
		nombre tipo_tarea
			from inc_tipo_tarea 
			where is_deleted = 0 
END

GO

