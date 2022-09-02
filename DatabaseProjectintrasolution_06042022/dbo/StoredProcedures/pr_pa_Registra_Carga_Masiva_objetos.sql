/*
Nombre: dbo.pr_pa_Registra_Carga_Masiva_objetos
Fecha Creación: 26/07/2021
Autor: Jorge Felix
Descripción: Actualiza los registros de carga masiva de Examenes medicos.
Llamado por: dbo.[pr_pa_Procesa_Carga_Masiva_objeto]
Usado por: Módulo Examen Medico. Carga Masiva Examenes Medicos
Parámetro(s):   @@exa_datos_medico_temporal_id numeric(10,0), @usuario_id numeric(10,0)
Uso: exec pr_pa_Registra_Carga_Masiva_objetos 2,1

********************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ------------------------------------------------------------------------------------------------
10/08/2021				Jorge Felix		  Se agregó el campo comentario_cabecera para que los objetos de BD registren sus cabeceras
13/10/2021				Mauro Roque		  se cambio el tipo de dato variable @comentario y @comentario_cabecera ahora es varchar(max)
28/02/2022              Valky Salinas     Se agregó creación de cabecera de entrega de objetos.
02/02/2022              Valky Salinas     Se agregó procedimiento que registra incidentes relacionados.
*********************************************************************************************************************************************
*/

CREATE procedure [dbo].[pr_pa_Registra_Carga_Masiva_objetos]
@pa_carga_lista_objetos_id numeric(10,0), @usuario_id numeric(10,0)
as
set nocount on
Set dateformat dmy

DECLARE @fb_uea_pe_id numeric(10,0),@inc_incidencia_id numeric(10,0), @programador varchar(150), @pa_categoria_objeto_id numeric(10,0), @pa_tipo_objeto_id numeric(10,0), @cliente varchar(150)
DECLARE @pa_carga_lista_objetos_detalle_id numeric(10,0),@nombre_objeto varchar(150), @categoria_objeto varchar(50),@tipo_objeto varchar(150),@objeto_relacionado varchar(150),@evento_relacionado varchar(150),@codigo_jira_incidente  varchar(100),@codigo_jira_pase varchar(100),@codigo_is_pase varchar(100)
DECLARE @tipo_cambio varchar(150), @pa_tipo_cambio_id numeric(10,0), @comentario varchar(max), @fb_empleado_id numeric(10,0), @fb_cliente_id numeric(10,0), @prd_producto_id numeric(10,0), @pry_proyecto_id numeric(10,0), @comentario_cabecera varchar(max)
DECLARE @fecha_ent datetime, @hora_ent varchar(200), @entrega_id numeric(10,0)

-- Creación de cabecera de entrega de objetos
SELECT
	@fecha_ent = fecha,
	@hora_ent = hora
FROM pa_carga_lista_objetos
WHERE
	pa_carga_lista_objetos_id = @pa_carga_lista_objetos_id

Insert into pa_entrega_objetos
	(
	fecha,
	hora,
	pa_entrega_objetos_estado_id,
	pa_carga_lista_objetos_id,
	created,
	created_by,
	updated,
	updated_by,
	owner_id,
	is_deleted
	)
values
	(
	@fecha_ent,
	@hora_ent,
	1, -- Incompleto
	@pa_carga_lista_objetos_id,
	getdate(),
	@usuario_id,
	getdate(),
	@usuario_id,
	@usuario_id,
	0
	)

SELECT TOP 1 @entrega_id = pa_entrega_objetos_id
FROM pa_entrega_objetos
WHERE is_deleted = 0 
ORDER BY created DESC


-- Creación de objetos
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
		ORDER BY nombre_objeto

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
		-- Recupera id de categoria objeto
		SELECT
			@pa_categoria_objeto_id = pa_categoria_objeto_id
		FROM pa_categoria_objeto
		WHERE (codigo = @categoria_objeto OR nombre = @categoria_objeto)

		-- Recupera id de incidencia y id empleado reponsable
		SELECT
			@inc_incidencia_id = inc_incidencia_id,
			@fb_empleado_id = fb_empleado_id,
			@fb_cliente_id = fb_cliente_id,
			@prd_producto_id = prd_producto_id,
			@pry_proyecto_id = @pry_proyecto_id
		FROM inc_incidencia
		WHERE (codigo_ticket = @codigo_is_pase)


		-- Recupera id de tipo objeto
		SELECT 
			@pa_tipo_objeto_id = pa_tipo_objeto_id
		FROM pa_tipo_objeto
		WHERE (codigo = @tipo_objeto or nombre = @tipo_objeto)

		-- Recupera id de cliente
		SELECT 
			@fb_cliente_id = fb_cliente_id
		FROM fb_cliente
		WHERE (codigo = @cliente or nombre = @cliente)

		-- Recupera id de tipo cambio
		SELECT  
			@pa_tipo_cambio_id = pa_tipo_cambio_id
		FROM pa_tipo_cambio
		WHERE (codigo = @tipo_cambio or nombre = @tipo_cambio)

		-- Recupera id del programador
		SELECT 
			@fb_empleado_id = fb_empleado_id
		FROM fb_empleado where fb_empleado_id = (Select fb_empleado_id from sc_user where sc_user_id = @usuario_id)

				Insert into pa_objetos
					(
					nombre_objeto,
					inc_incidencia_id,
					incidencia_jira_codigo,
					pa_categoria_objeto_id,
					pa_tipo_objeto_id,
					pa_tipo_cambio_id,
					fb_empleado_autor_id,
					fb_cliente_id,
					prd_producto_id,
					pry_proyecto_id,
					descripcion_objeto,
					observaciones,
					pa_entrega_objetos_id,
					created,
					created_by,
					updated,
					updated_by,
					owner_id,
					is_deleted
					)
				values
					(
					@nombre_objeto,
					@inc_incidencia_id,
					@codigo_jira_incidente,
					@pa_categoria_objeto_id,
					@pa_tipo_objeto_id,
					@pa_tipo_cambio_id,
					@fb_empleado_id,
					@fb_cliente_id,
					@prd_producto_id,
					@pry_proyecto_id,
					@comentario_cabecera,
					@comentario,
					@entrega_id,
					getdate(),
					@usuario_id,
					getdate(),
					@usuario_id,
					@usuario_id,
					0
					)

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

exec pr_pa_Registra_incidentes_relacionados @entrega_id, @usuario_id

GO

