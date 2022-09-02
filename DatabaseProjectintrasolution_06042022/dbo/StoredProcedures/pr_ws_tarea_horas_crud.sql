
/*
Nombre: dbo.pr_ws_tarea_horas_crud
Fecha Creación: 10/03/2022
Autor: Jorge Felix
Descripción: Store procedure que puede insertar, actualizar o eliminar un registro de la tabla inc_incidencia_hh
Llamado por: Home Tareas
Usado por: Varios
Parámetro(s):   @usuario_id    Parámetros
	
Uso: exec pr_ws_tarea_horas_crud 1,0,1,0,50107,0,'prueba3','2022-03-16 18:30:00','2022-03-16 19:00:00',1,16

***********************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ---------------------------------------------------
			
***********************************************************************************************

*/
CREATE PROCEDURE [dbo].[pr_ws_tarea_horas_crud] 
	@type numeric(10, 0),
	@id numeric(10, 0) = null,
	@tipo_tarea numeric(10, 0) =null,
	@subtipo_tarea numeric(10, 0) = null,
	@incidente_id numeric(10,0) = null,
	@pase_id numeric(10,0) = null,
	@accion_correctiva_id numeric(10,0) = null,
	@observacion varchar(max) = null,
	@fecha_inicio varchar(50) = null,
	@fecha_fin varchar(50) = null,
	@uea numeric(10, 0) =null,
	@usuario_id numeric(10, 0)
AS
BEGIN
set dateformat ymd
	declare @nombreCompleto varchar(150)
	declare @cargoNombre varchar(150)
	declare @cargo_codigo varchar(150)
	declare @fb_empleado_id numeric(10,0)
	--declare @fecha_inicio2 varchar(10)
	--declare @fecha_fin2 varchar(10)

 set @fb_empleado_id =(Select fb_empleado_id from sc_user where sc_user_id = @usuario_id)
 select  @nombreCompleto = nombreCompleto,@cargoNombre =cargo_nombre,@cargo_codigo =cargo_codigo from fb_empleado where fb_empleado_id = @fb_empleado_id


IF @type = 1  
	BEGIN 
		set nocount on; 
			
		Insert into inc_incidencia_hh (
			inc_tipo_tarea_id,
			inc_subtipo_tarea_id,
			inc_incidencia_id,
			pa_pase_id,
			sac_accion_correctiva_id,
			numero_hh,
			periodo,
			observacion,
			fecha_hora_inicio,
			fecha_hora_fin,
			fecha_hora_inicio2,
			fecha_hora_fin2,
			fb_empleado_responsable_id,
			created,
			created_by,
			owner_id,
			is_deleted


		)
		values(
			@tipo_tarea,
			@subtipo_tarea,
			@incidente_id,
			@pase_id,
			@accion_correctiva_id,
			convert(numeric(10,2),DATEDIFF(mi,@fecha_inicio,@fecha_fin))/60,
			convert(varchar(4),year(@fecha_inicio)) +'-'+ right('00'+ convert(varchar(2),month(@fecha_inicio)),2),
			@observacion,
			@fecha_inicio,
			@fecha_fin,
			substring(CONVERT(VARCHAR(10),@fecha_inicio,108),1,5),
			substring(CONVERT(VARCHAR(10),@fecha_fin,108),1,5),
			@fb_empleado_id,
			getdate(),
			@usuario_id,
			@usuario_id,
			0	
		)
		set @id=  @@Identity
		--exec pr_graf_inc_calendario 0,@id,@usuario_id
		exec pr_ws_tareas_horas @usuario_id
	END 
	IF @type = 2
	BEGIN  
		set nocount on; 
	
		update inc_incidencia_hh set
			inc_tipo_tarea_id = @tipo_tarea,
			inc_subtipo_tarea_id = @subtipo_tarea,
			inc_incidencia_id = @incidente_id,
			pa_pase_id = @pase_id,
			sac_accion_correctiva_id = @accion_correctiva_id,
			numero_hh = convert(numeric(10,2),DATEDIFF(mi,@fecha_inicio,@fecha_fin))/60,
			periodo = convert(varchar(4),year(@fecha_inicio)) +'-'+ right('00'+ convert(varchar(2),month(@fecha_inicio)),2),
			fecha_hora_inicio = @fecha_inicio,
			fecha_hora_fin = @fecha_fin,
			fecha_hora_inicio2 = substring(CONVERT(VARCHAR(10),@fecha_inicio,108),1,5),
			fecha_hora_fin2 = substring(CONVERT(VARCHAR(10),@fecha_fin,108),1,5),
			observacion = @observacion,
			fb_empleado_responsable_id = @fb_empleado_id,
			updated = getdate(),
			updated_by = @usuario_id
		where inc_incidencia_hh_id = @id
		--exec pr_graf_inc_calendario 0,@id,@usuario_id
		exec pr_ws_tareas_horas @usuario_id
	END 
IF @type = 3
BEGIN  
		set nocount on; 
		update inc_incidencia_hh set 
			is_deleted			=1
		where 	 inc_incidencia_hh_id=@id
		--exec pr_graf_inc_calendario 0,@id,@usuario_id
		exec pr_ws_tareas_horas @usuario_id
	END 
END

GO

