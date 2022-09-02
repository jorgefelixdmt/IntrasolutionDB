/*
Nombre: dbo.pr_pa_Procesa_Carga_Masiva_objetos
Fecha Creación: 26/07/2021
Autor: Jorge Felix
Descripción: Procesa los registros de una carga masiva de objetos modificados por las tareas y evalúa si hay errores.
Llamado por: Módulo Revisión de Carga Masiva objetos
Usado por: Módulo Gestión de Objetos
Parámetro(s):   @pa_carga_lista_objetos_id		ID de la carga
				@usuario_id                             ID usuario que evalúa la carga
				@fb_uea_pe_id							ID id de la unidad 
Uso: exec pr_pa_Procesa_Carga_Masiva_objetos 2,1,1

******************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ----------------------------------------------------------------------
10/08/2021				Jorge Felix			Se agregó el campo comentario_cabecera para que los objetos de BD registren sus cabeceras
02/09/2021				Jorge Felix			Se quito la validacion del codigo Incidencia, se quito validacion duplicado por jira, queda validacion duplicado por pase
02/09/2021				Jorge Felix			Se agrego validacion de cliente
13/10/2021				Mauro Roque			se cambio el tipo de dato variable @comentario y @comentario_cabecera ahora es varchar(max)
13/10/2021				Mauro Roque			se comentó validacion de cliente
******************************************************************************************************************
pr_pa_Procesa_Carga_Masiva_objetos 3,1,1
*/

CREATE PROCEDURE [dbo].[pr_pa_Procesa_Carga_Masiva_objetos]
@pa_carga_lista_objetos_id numeric(10,0), 
@usuario_id numeric(10,0), 
@fb_uea_pe_id numeric(10,0)
as
set nocount on

DECLARE @Contador numeric(10,0),@sc_user_id numeric(10,0),@countadoruser numeric(10,0), @nombre_objeto1 varchar(150), @nombre_objeto2 varchar(150), @inc_incidencia_id numeric(10,0)
DECLARE @numero_errores int, @errores_encontrados varchar(MAX), @fb_pais_id numeric(10,0), @pa_tipo_cambio_id numeric(10,0), @cliente varchar(150)
DECLARE @pa_carga_lista_objetos_detalle_id numeric(10,0), @nombre_objeto varchar(150),@categoria_objeto varchar(150),@tipo_objeto varchar(150), @evento_relacionado varchar(300)
DECLARE	@codigo_jira_incidente varchar(150), @codigo_jira_pase varchar(150),@codigo_is_pase varchar(150),@programador varchar(150),@tipo_cambio varchar(150), @fb_cliente_id numeric(10,0)

DECLARE @pa_categoria_objeto_id numeric(10,0),@pa_tipo_objeto_id numeric(10,0),@fb_empleado_id numeric(10,0),@objeto_relacionado varchar(300), @comentario varchar(max), @comentario_cabecera varchar(max)

DECLARE @error int
SET @error = 0

DECLARE CURSOR_REGS CURSOR FOR
		SELECT 
			pa_carga_lista_objetos_detalle_id,
			nombre_objeto,
			categoria_objeto,
			tipo_objeto,
			objeto_relacionado,
			evento_relacionado,
			cliente,
			codigo_jira_incidente,
			codigo_jira_pase,
			codigo_is_incidente,
			programador,
			tipo_cambio,
			comentario,
			comentario_cabecera
		FROM pa_carga_lista_objetos_detalle
		WHERE
			pa_carga_lista_objetos_id = @pa_carga_lista_objetos_id AND
			is_deleted = 0

OPEN CURSOR_REGS

FETCH NEXT FROM CURSOR_REGS INTO
		@pa_carga_lista_objetos_detalle_id,
		@nombre_objeto,
		@categoria_objeto,
		@tipo_objeto,
		@objeto_relacionado,
		@evento_relacionado,
		@cliente,
		@codigo_jira_incidente,
		@codigo_jira_pase,
		@codigo_is_pase,
		@programador,
		@tipo_cambio,
		@comentario,
		@comentario_cabecera

WHILE @@Fetch_Status = 0   
 BEGIN
	SET @numero_errores = 0
	SET @errores_encontrados = ''

	SET @sc_user_id = NULL
	SET @Contador = 0

-- Valida Codigo Jira del Incidente
	IF (@codigo_jira_incidente = '' OR @codigo_jira_incidente IS NULL)
		BEGIN
			SET @errores_encontrados = @errores_encontrados + '- Debe ingresar el código de la incidencia.' + CHAR(13) + CHAR(10)
			SET @numero_errores = @numero_errores + 1
		END

-- Valida nombre_objeto
	IF (@nombre_objeto = '' OR @nombre_objeto IS NULL)
		 BEGIN
			SET @errores_encontrados = @errores_encontrados + '- Debe ingresar el nombre del objeto en este pase.' + CHAR(13) + CHAR(10)
			SET @numero_errores = @numero_errores + 1
		 END
	ELSE
		 BEGIN
				SELECT
					@nombre_objeto2 = nombre_objeto
				FROM pa_carga_lista_objetos_detalle
				Where pa_carga_lista_objetos_id = @pa_carga_lista_objetos_id and nombre_objeto = @nombre_objeto
				GROUP BY nombre_objeto 
				HAVING COUNT(*)>1;

				IF @nombre_objeto2 is not null or @nombre_objeto2 <> ''
				 BEGIN
					SET @errores_encontrados = @errores_encontrados + '- El objeto se está duplicando en esta carga.' + CHAR(13) + CHAR(10)
					SET @numero_errores = @numero_errores + 1
				 END
		 END

-- Valida cliente
	IF (@cliente = '' OR @cliente IS NULL)
		 BEGIN
			SET @errores_encontrados = @errores_encontrados + '- Debe ingresar el cliente del objeto.' + CHAR(13) + CHAR(10)
			SET @numero_errores = @numero_errores + 1
		 END
		--ELSE
		-- BEGIN
		--		SELECT top 1
		--			@fb_cliente_id = fb_cliente_id
		--		FROM fb_cliente
		--		WHERE (codigo = @cliente OR nombre = @cliente)

		--		IF @fb_cliente_id IS NULL
		--		 BEGIN
		--			SET @errores_encontrados = @errores_encontrados + '- El Cliente ingresado no existe.' + CHAR(13) + CHAR(10)
		--			SET @numero_errores = @numero_errores + 1
		--		 END
		-- END

-- Valida categoria_objeto
	IF (@categoria_objeto = '' OR @categoria_objeto IS NULL)
		 BEGIN
			SET @errores_encontrados = @errores_encontrados + '- Debe ingresar la categoria del objeto.' + CHAR(13) + CHAR(10)
			SET @numero_errores = @numero_errores + 1
		 END
		ELSE
		 BEGIN
				SELECT top 1
					@pa_categoria_objeto_id = pa_categoria_objeto_id
				FROM pa_categoria_objeto
				WHERE (codigo = @categoria_objeto OR nombre = @categoria_objeto)

				IF @pa_categoria_objeto_id IS NULL
				 BEGIN
					SET @errores_encontrados = @errores_encontrados + '- La categoría ingresada no existe.' + CHAR(13) + CHAR(10)
					SET @numero_errores = @numero_errores + 1
				 END
		 END

-- Valida tipo objeto
	IF (@tipo_objeto = '' OR @tipo_objeto IS NULL)
		 BEGIN
			SET @errores_encontrados = @errores_encontrados + '- Debe ingresar el tipo de objeto.' + CHAR(13) + CHAR(10)
			SET @numero_errores = @numero_errores + 1
		 END
		ELSE
		 BEGIN
				SELECT top 1
					@pa_tipo_objeto_id = pa_tipo_objeto_id
				FROM pa_tipo_objeto
				WHERE (codigo = @tipo_objeto or nombre = @tipo_objeto)

				IF @pa_tipo_objeto_id IS NULL
				 BEGIN
					SET @errores_encontrados = @errores_encontrados + '- El tipo objeto ingresado no existe.' + CHAR(13) + CHAR(10)
					SET @numero_errores = @numero_errores + 1
				 END
		 END

-- Valida tipo de cambio
	IF (@tipo_cambio = '' OR @tipo_cambio IS NULL)
		 BEGIN
			SET @errores_encontrados = @errores_encontrados + '- Debe ingresar el tipo de cambio.' + CHAR(13) + CHAR(10)
			SET @numero_errores = @numero_errores + 1
		 END
		ELSE
		 BEGIN
				SELECT top 1
					@pa_tipo_cambio_id = pa_tipo_cambio_id
				FROM pa_tipo_cambio
				WHERE (codigo = @tipo_cambio or nombre = @tipo_cambio)

				IF @pa_tipo_objeto_id IS NULL
				 BEGIN
					SET @errores_encontrados = @errores_encontrados + '- El tipo cambio ingresado no existe.' + CHAR(13) + CHAR(10)
					SET @numero_errores = @numero_errores + 1
				 END
		 END

 --Valida el nombre del programador
	IF (@programador = '' OR @programador IS NULL)
		 BEGIN
				SELECT 
					@fb_empleado_id = fb_empleado_id
				FROM fb_empleado where fb_empleado_id = (Select fb_empleado_id from sc_user where sc_user_id = @usuario_id)
				--and (codigo = @programador or nombreCompleto = @programador)

				IF @fb_empleado_id IS NULL
				 BEGIN
					SET @errores_encontrados = @errores_encontrados + '- El nombre del usuario no existe.' + CHAR(13) + CHAR(10)
					SET @numero_errores = @numero_errores + 1
				 END
		 END

-- Valida comentario cabecera
	IF @categoria_objeto = 'BD'
		BEGIN
			IF (@comentario_cabecera = '' OR @comentario_cabecera IS NULL)
				 BEGIN
					SET @errores_encontrados = @errores_encontrados + '- Debe ingresar el comentario de la cabecera del objeto.' + CHAR(13) + CHAR(10)
					SET @numero_errores = @numero_errores + 1
				 END
		END

IF @numero_errores > 0
	 BEGIN
		SET @error = 1
	 END

	UPDATE pa_carga_lista_objetos_detalle
	SET errores_encontrados = @errores_encontrados, numero_errores = @numero_errores
	WHERE pa_carga_lista_objetos_detalle_id = @pa_carga_lista_objetos_detalle_id

	FETCH NEXT FROM CURSOR_REGS INTO
		@pa_carga_lista_objetos_detalle_id,
		@nombre_objeto,
		@categoria_objeto,
		@tipo_objeto,
		@objeto_relacionado,
		@evento_relacionado,
		@cliente,
		@codigo_jira_incidente,
		@codigo_jira_pase,
		@codigo_is_pase,
		@programador,
		@tipo_cambio,
		@comentario,
		@comentario_cabecera
 END

CLOSE CURSOR_REGS
DEALLOCATE CURSOR_REGS

IF @error = 0
 BEGIN
	exec pr_pa_Registra_Carga_Masiva_objetos @pa_carga_lista_objetos_id, @usuario_id
 END

SELECT @error as valida_error

GO

