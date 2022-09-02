
/*
Nombre: dbo.pr_exa_Procesa_Carga_Masiva_Examen
Fecha Creación: 12/05/2020
Autor: Jorge Felix
Descripción: Procesa los registros de una carga masiva de examenes medicos y evalúa si hay errores.
Llamado por: Módulo Revisión de Carga Masiva Examenes Medicos
Usado por: Módulo Gestión de Examenes Medicos
Parámetro(s):   @exa_datos_medico_temporal_id		ID de la carga
				@usuario_id                             ID usuario que evalúa la carga
				@fb_uea_pe_id							ID id de la unidad 
Uso: exec pr_exa_Procesa_Carga_Masiva_Examen 1,1,1

******************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ----------------------------------------------------------------------

******************************************************************************************************************
pr_exa_Procesa_Carga_Masiva_Examen 3,1,1
*/

create PROCEDURE [dbo].[pr_exa_Procesa_Carga_Masiva_Examen]
@exa_datos_medico_temporal_id numeric(10,0), 
@usuario_id numeric(10,0), 
@fb_uea_pe_id numeric(10,0)
as
set nocount on

DECLARE @Contador numeric(10,0),@sc_user_id numeric(10,0),@countadoruser numeric(10,0), @SC_DOMAIN_TABLE_ID numeric(10,0), @CODE_CLASE varchar(50),@fecha_cese datetime, @fecha_cese2 datetime
DECLARE @numero_errores int, @errores_encontrados varchar(MAX), @fb_pais_id numeric(10,0)
DECLARE @exa_datos_medico_temporal_detalle_id numeric(10,0), @codigo_trabajador varchar(50),@n_documento_identidad varchar(50),@apellido_nombre varchar(150),@talla numeric(10,2)
DECLARE	@peso numeric(10,2), @IMC numeric(10,0),@clasificacion_IMC varchar(200),@enfermedad_patalogica varchar(150),@detalle_patalogico varchar(500),@estado numeric(1,0)

DECLARE @codigo varchar(50), @numero_documento varchar(50),@nombreCompleto varchar(200),@nombreClasificacion varchar(150),@nombreEnfermedad varchar(150),@fecha_examen datetime

DECLARE @error int
SET @error = 0

DECLARE CURSOR_REGS CURSOR FOR
		SELECT 
			exa_datos_medico_temporal_detalle_id,
			codigo_trabajador,
			n_documento_identidad,
			apellido_nombre,
			fecha_examen,
			talla,
			peso,
			IMC,
			clasificacion_IMC,
			enfermedad_patalogica,
			detalle_patalogico,
			estado
		FROM exa_datos_medico_temporal_detalle
		WHERE
			exa_datos_medico_temporal_id = @exa_datos_medico_temporal_id AND
			is_deleted = 0

OPEN CURSOR_REGS

FETCH NEXT FROM CURSOR_REGS INTO
		@exa_datos_medico_temporal_detalle_id,
		@codigo_trabajador,
		@n_documento_identidad,
		@apellido_nombre,
		@fecha_examen,
		@talla,
		@peso,
		@IMC,
		@clasificacion_IMC,
		@enfermedad_patalogica,
		@detalle_patalogico,
		@estado

WHILE @@Fetch_Status = 0   
 BEGIN
	SET @numero_errores = 0
	SET @errores_encontrados = ''
	--SET @SC_DOMAIN_TABLE_ID = NULL
	--SET @fb_empresa_especializada_id = NULL
	--SET @fb_pais_id = NULL
	SET @sc_user_id = NULL
	SET @Contador = 0


-- Valida Codigo_trabajador
	IF (@codigo_trabajador = '' OR @codigo_trabajador IS NULL)
		 BEGIN
			SET @errores_encontrados = @errores_encontrados + '- Debe ingresar el codigo del trabajador.' + CHAR(13) + CHAR(10)
			SET @numero_errores = @numero_errores + 1
		 END
		ELSE
		 BEGIN
				SELECT top 1
					@codigo = codigo
				FROM fb_empleado
				WHERE (codigo = @codigo_trabajador OR numero_documento = @n_documento_identidad)

				IF @codigo IS NULL
				 BEGIN
					SET @errores_encontrados = @errores_encontrados + '- El codigo ingresado no existe.' + CHAR(13) + CHAR(10)
					SET @numero_errores = @numero_errores + 1
				 END
		 END

-- Valida numero documento
	IF (@n_documento_identidad = '' OR @n_documento_identidad IS NULL)
		 BEGIN
			SET @errores_encontrados = @errores_encontrados + '- Debe ingresar el numero de documento del trabajador.' + CHAR(13) + CHAR(10)
			SET @numero_errores = @numero_errores + 1
		 END
		ELSE
		 BEGIN
				SELECT top 1
					@numero_documento = numero_documento
				FROM fb_empleado
				WHERE (codigo = @n_documento_identidad OR numero_documento = @n_documento_identidad)

				IF @codigo IS NULL
				 BEGIN
					SET @errores_encontrados = @errores_encontrados + '- El codigo ingresado no existe.' + CHAR(13) + CHAR(10)
					SET @numero_errores = @numero_errores + 1
				 END
		 END

-- Valida nombre completo
	IF (@apellido_nombre = '' OR @apellido_nombre IS NULL)
		 BEGIN
			SET @errores_encontrados = @errores_encontrados + '- Debe ingresar el nombre del trabajador.' + CHAR(13) + CHAR(10)
			SET @numero_errores = @numero_errores + 1
		 END
		ELSE
		 BEGIN
				SELECT top 1
					@nombreCompleto = nombreCompleto
				FROM fb_empleado
				WHERE (codigo = @codigo_trabajador)

				IF @nombreCompleto IS NULL
				 BEGIN
					SET @errores_encontrados = @errores_encontrados + '- El nombre ingresado no existe.' + CHAR(13) + CHAR(10)
					SET @numero_errores = @numero_errores + 1
				 END
		 END

-- Valida fecha de examen
	IF (@fecha_examen = '' OR @fecha_examen IS NULL)
		 BEGIN
			SET @errores_encontrados = @errores_encontrados + '- Debe ingresar la fecha de examen.' + CHAR(13) + CHAR(10)
			SET @numero_errores = @numero_errores + 1
		 END

-- Valida talla
	IF (@talla IS NULL)
		 BEGIN
			SET @errores_encontrados = @errores_encontrados + '- Debe ingresar la talla del trabajador.' + CHAR(13) + CHAR(10)
			SET @numero_errores = @numero_errores + 1
		 END

-- Valida peso
	IF (@peso IS NULL)
		 BEGIN
			SET @errores_encontrados = @errores_encontrados + '- Debe ingresar el peso del trabajador.' + CHAR(13) + CHAR(10)
			SET @numero_errores = @numero_errores + 1
		 END

-- Valida IMC
	IF (@IMC IS NULL)
		 BEGIN
			SET @errores_encontrados = @errores_encontrados + '- Debe ingresar el IMC del trabajador.' + CHAR(13) + CHAR(10)
			SET @numero_errores = @numero_errores + 1
		 END


-- Valida Enfermeda Patologica
	IF (@enfermedad_patalogica = '' OR @enfermedad_patalogica IS NULL)
		 BEGIN
			SET @errores_encontrados = @errores_encontrados + '- Debe ingresar la Enfermedad Patologica.' + CHAR(13) + CHAR(10)
			SET @numero_errores = @numero_errores + 1
		 END
		ELSE
		 BEGIN
				SELECT top 1
					@nombreEnfermedad = nombre
				FROM exa_enfermedad_patologica
				WHERE (codigo = @enfermedad_patalogica)

				IF @nombreEnfermedad IS NULL
				 BEGIN
					SET @errores_encontrados = @errores_encontrados + '- La enfermedad patologica ingresada no existe.' + CHAR(13) + CHAR(10)
					SET @numero_errores = @numero_errores + 1
				 END
		 END



IF @numero_errores > 0
	 BEGIN
		SET @error = 1
	 END

	UPDATE exa_datos_medico_temporal_detalle
	SET errores_encontrados = @errores_encontrados, numero_errores = @numero_errores
	WHERE exa_datos_medico_temporal_detalle_id = @exa_datos_medico_temporal_detalle_id

	FETCH NEXT FROM CURSOR_REGS INTO
		@exa_datos_medico_temporal_detalle_id,
		@codigo_trabajador,
		@n_documento_identidad,
		@apellido_nombre,
		@fecha_examen,
		@talla,
		@peso,
		@IMC,
		@clasificacion_IMC,
		@enfermedad_patalogica,
		@detalle_patalogico,
		@estado
 END

CLOSE CURSOR_REGS
DEALLOCATE CURSOR_REGS

IF @error = 0
 BEGIN
	exec pr_exa_Registra_Carga_Masiva_Examen @exa_datos_medico_temporal_id, @usuario_id
 END

SELECT @error as valida_error

GO

