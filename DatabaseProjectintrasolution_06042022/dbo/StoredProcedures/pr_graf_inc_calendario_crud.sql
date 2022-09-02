
/**
	NOMBRE: [dbo].[pr_graf_inc_calendario_crud] 
	FECHA: 2019-07-16
	AUTOR: Enrique Huaman
	DESCRIPCION: Raliza la funcion de Agregar, Editar y eliminar de las horas de las tarea
	TABLA AFECTADA: inc_incidencia_hh
	USADO POR: Intrasolution->Registro de Tareas
	PARAMETROS:
		@type: 1=>crear,2=>actualizar,3=>eliminar
		@id => id de la tarea
		--@gerencia=> id del tipo de tarea
		@fecha=> fecha de inicio de la tarea
		@uea=> id de la unidad
		@empleado_id=> id del empleado asignado a esa verificacion
		@usuario=> id de la persona que a creado la verificacion

**/
CREATE PROCEDURE [dbo].[pr_graf_inc_calendario_crud] 
	@type numeric(10, 0),
	@id numeric(10, 0),
	--@gerencia numeric(10, 0),
	@tipo_tarea numeric(10, 0),
	@subtipo_tarea numeric(10, 0),
	@incidente_id numeric(10,0),
	@observacion varchar(max),
	@fecha_inicio datetime,
	@fecha_fin datetime,
	@uea numeric(10, 0),
	@usuario numeric(10, 0)
AS
BEGIN
	declare @nombreCompleto varchar(150)
	declare @cargoNombre varchar(150)
	declare @cargo_codigo varchar(150)
	declare @fb_empleado_id numeric(10,0)

 set @fb_empleado_id =(Select fb_empleado_id from sc_user where sc_user_id = @usuario)
 select  @nombreCompleto = nombreCompleto,@cargoNombre =cargo_nombre,@cargo_codigo =cargo_codigo from fb_empleado where fb_empleado_id = @fb_empleado_id


IF @type = 1  
	BEGIN 
		set nocount on; 
			
		Insert into inc_incidencia_hh (
			inc_tipo_tarea_id,
			inc_subtipo_tarea_id,
			inc_incidencia_id,
			observacion,
			fecha_hora_inicio,
			fecha_hora_fin,
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
			@observacion,
			@fecha_inicio,
			@fecha_fin,
			@fb_empleado_id,
			getdate(),
			@usuario,
			@usuario,
			0
			
		)
		set @id=  @@Identity

		--exec pr_graf_inc_calendario 0,@id,0
		exec pr_graf_inc_calendario 0,@id,@usuario
	END 
	IF @type = 2
	BEGIN  
		set nocount on; 
	
		update inc_incidencia_hh set
			inc_tipo_tarea_id = @tipo_tarea,
			inc_subtipo_tarea_id = @subtipo_tarea,
			inc_incidencia_id = @incidente_id,
			fecha_hora_inicio = @fecha_inicio,
			fecha_hora_fin = @fecha_fin,
			observacion = @observacion,
			fb_empleado_responsable_id = @fb_empleado_id,
			updated = getdate(),
			updated_by = @usuario
		where inc_incidencia_hh_id = @id

		--exec pr_graf_inc_calendario 0,@id,0
		exec pr_graf_inc_calendario 0,@id,@usuario

	END 
IF @type = 3
BEGIN  
		set nocount on; 
		update inc_incidencia_hh set 
			is_deleted			=1
		where 	 inc_incidencia_hh_id=@id

		--exec pr_graf_inc_calendario 0,@id,0
		exec pr_graf_inc_calendario 0,@id,@usuario
	END 
END

GO

