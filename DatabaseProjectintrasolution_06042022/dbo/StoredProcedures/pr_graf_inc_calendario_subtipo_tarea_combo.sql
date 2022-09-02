/**
NOMBRE: [dbo].[pr_graf_inc_calendario_subtipo_tarea_combo]
CREACION: 2022-01-09
AUTOR: Jorge Felix
DESCRIPCION: Retorna nombres y id de los subtipos de tareas
USADO POR: Registro de Tareas/Ejecución/Registro de Tareas
**/


CREATE PROCEDURE [dbo].[pr_graf_inc_calendario_subtipo_tarea_combo]
--@inc_tipo_tarea_id numeric(10,0) 
AS
BEGIN
		select DISTINCT inc_subtipo_tarea_id id,
		nombre subtipo_tarea
			from inc_subtipo_tarea 
			where is_deleted = 0 --and inc_tipo_tarea_id = @inc_tipo_tarea_id
END

GO

