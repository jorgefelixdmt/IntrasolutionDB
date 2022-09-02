
/*
Nombre: dbo.pr_exa_Registra_Carga_Masiva_Examen
Fecha Creación: 12/06/2020
Autor: Jorge Felix
Descripción: Actualiza los registros de carga masiva de Examenes medicos.
Llamado por: dbo.[pr_exa_Procesa_Carga_Masiva_Examen]
Usado por: Módulo Examen Medico. Carga Masiva Examenes Medicos
Parámetro(s):   @exa_datos_medico_temporal_id numeric(10,0), @usuario_id numeric(10,0)
Uso: exec pr_exa_Registra_Carga_Masiva_Examen 2,1

********************************************************************************************************************************************
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)      Autor              Comentarios
------------------     ---------------    ------------------------------------------------------------------------------------------------

*********************************************************************************************************************************************
*/

create procedure [dbo].[pr_exa_Registra_Carga_Masiva_Examen]
@exa_datos_medico_temporal_id numeric(10,0), @usuario_id numeric(10,0)
as
set nocount on
Set dateformat dmy

DECLARE @g_rol_empresa_id numeric(10,0), @fb_empresa_especializada_id numeric(10,0),@codigo_tributario varchar(50),@fb_uea_pe_id numeric(10,0),@fb_empleado_id numeric(10,0),@fb_cargo_id numeric(10,0),@sexo varchar(1),@fecha_nacimiento datetime,@edad numeric(10,0)

DECLARE @exa_datos_medico_temporal_detalle_id numeric(10,0),@codigo_trabajador varchar(50),@n_documento_identidad varchar(50),@apellido_nombre varchar(150),@talla numeric(10,2),@peso numeric(10,0),@IMC numeric(10,2),@clasificacion_IMC varchar(150),@enfermedad_patalogica varchar(50)

DECLARE @detalle_patalogico varchar(500),@estado numeric(1,0),@exa_enfermedad_patologica_id numeric(10,0),@identidadExamen numeric(10,0),@CodigoExiste numeric(10,0),@exa_clasificacion_IMC_id numeric(10,0)
DECLARE @exa_Datos_Medico_id numeric(10,0),@cargo_nombre varchar(150),@fecha_examen datetime

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
	ORDER BY apellido_nombre

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
		
	--g_rol_empresa_id, fb_empresa_especializada_id
		SELECT top 1
			@g_rol_empresa_id = g_rol_empresa_id,
			@fb_empresa_especializada_id = fb_empresa_especializada_id,
			@codigo_tributario = ruc_empresa,
			@fb_uea_pe_id = fb_uea_pe_id,
			@fb_empleado_id = fb_empleado_id,
			@fb_cargo_id = fb_cargo_id,
			@cargo_nombre = cargo_nombre, 
			@sexo = sexo,
			@fecha_nacimiento = fecha_nacimiento,
			@edad = (Select DATEDIFF(YEAR,fecha_nacimiento,GETDATE()))
		FROM fb_empleado
		WHERE (codigo = @codigo_trabajador OR codigo = @n_documento_identidad)
	 
	 	Set @CodigoExiste = (select count(*) from exa_Datos_Medico where documento_entidad =  @codigo_trabajador)
		Set @exa_clasificacion_IMC_id = (select exa_clasificacion_IMC_id from exa_clasificacion_IMC where @imc BETWEEN rango_minimo and rango_maximo)
		Set @exa_enfermedad_patologica_id = (select exa_enfermedad_patologica_id from exa_enfermedad_patologica where codigo= @enfermedad_patalogica and is_deleted=0)
		--Set @Clasificacion_IMC = (Select DATEDIFF(YEAR,@fecha_nacimiento,GETDATE()))

		If @CodigoExiste > 0
			Begin
				Set @exa_Datos_Medico_id = (select exa_Datos_Medico_id from exa_Datos_Medico where documento_entidad =  @codigo_trabajador)

				Update exa_Datos_Medico
					Set talla = @talla,
						peso = @peso,
						IMC = @IMC,
						exa_clasificacion_IMC_id = @exa_clasificacion_IMC_id
				where documento_entidad = @codigo_trabajador

				--Update exa_Datos_Medico_detalle
				--	Set exa_enfermedad_patologica_id = @exa_enfermedad_patologica_id,
				--		detalle_patalogico = @detalle_patalogico
				--where exa_datos_medico_id = @exa_Datos_Medico_id

				Insert into exa_Datos_Medico_detalle
					(
					exa_Datos_Medico_id,
					exa_enfermedad_patologica_id,
					detalle_patalogico,
					created,
					created_by,
					updated,
					updated_by,
					owner_id,
					is_deleted
					)
				values
					(
					@exa_Datos_Medico_id,
					@exa_enfermedad_patologica_id,
					@detalle_patalogico,
					getdate(),
					1,
					getdate(),
					1,
					1,
					0
					)
			End

		Else
			Begin
				Insert into exa_Datos_Medico
					(
					documento_entidad,
					nombre_completo,
					talla,
					peso,
					IMC,
					exa_clasificacion_IMC_id,
					g_rol_empresa_id,
					fb_empresa_especializada_id,
					codigo_tributario,
					fecha_examen,
					fb_uea_pe_id,
					fb_empleado_id,
					fb_cargo_id,
					cargo_nombre,
					sexo,
					fecha_nacimiento,
					edad,
					created,
					created_by,
					updated,
					updated_by,
					owner_id,
					is_deleted
					)
				values(
					@n_documento_identidad,
					@apellido_nombre,
					@talla,
					@peso,
					@IMC,
					@exa_clasificacion_IMC_id,
					@g_rol_empresa_id,
					@fb_empresa_especializada_id,
					@codigo_tributario,
					@fecha_examen,
					@fb_uea_pe_id,
					@fb_empleado_id,
					@fb_cargo_id,
					@cargo_nombre,
					@sexo,
					@fecha_nacimiento,
					@edad,
					getdate(),
					1,
					getdate(),
					1,
					1,
					0
					)

				Set @identidadExamen = @@IDENTITY
				--Set @identidadExamen = (Select max(exa_Datos_Medico_id) from exa_Datos_Medico where documento_entidad = @codigo_trabajador)

				Insert into exa_Datos_Medico_detalle
					(
					exa_Datos_Medico_id,
					exa_enfermedad_patologica_id,
					detalle_patalogico,
					created,
					created_by,
					updated,
					updated_by,
					owner_id,
					is_deleted
					)
				values
					(
					@identidadExamen,
					@exa_enfermedad_patologica_id,
					@detalle_patalogico,
					getdate(),
					1,
					getdate(),
					1,
					1,
					0
					)
			End

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

GO

