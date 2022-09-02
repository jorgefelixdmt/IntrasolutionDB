CREATE TABLE [dbo].[inc_incidencia] (
    [inc_incidencia_id]                 NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [nombre_modulo]                     VARCHAR (50)   NULL,
    [datos_importante]                  VARCHAR (MAX)  NULL,
    [datos_adicionales]                 VARCHAR (500)  NULL,
    [inc_tipo_incidencia_id]            NUMERIC (10)   NULL,
    [descripcion_error]                 VARCHAR (MAX)  NULL,
    [archivo_pasos_error]               VARCHAR (200)  NULL,
    [archivo_pasos_error_size]          NUMERIC (10)   NULL,
    [documento_error]                   VARCHAR (200)  NULL,
    [documento_error_size]              NUMERIC (10)   NULL,
    [fb_cliente_id]                     NUMERIC (10)   NULL,
    [inc_nivel_incidencia_id]           NUMERIC (10)   NULL,
    [descripcion_nivel_incidencia]      VARCHAR (MAX)  NULL,
    [responsable]                       VARCHAR (256)  NULL,
    [inc_estado_incidencia_id]          NUMERIC (10)   NULL,
    [created]                           DATETIME       NULL,
    [created_by]                        NUMERIC (10)   NULL,
    [updated]                           DATETIME       NULL,
    [updated_by]                        NUMERIC (10)   NULL,
    [owner_id]                          NUMERIC (10)   NULL,
    [is_deleted]                        NUMERIC (1)    NULL,
    [codigo_ticket]                     VARCHAR (50)   NULL,
    [codigo_jira]                       VARCHAR (50)   NULL,
    [pry_proyecto_id]                   NUMERIC (10)   NULL,
    [prd_producto_id]                   NUMERIC (10)   NULL,
    [fecha]                             DATETIME       NULL,
    [hora]                              VARCHAR (20)   NULL,
    [reportado_por]                     VARCHAR (200)  NULL,
    [descripcion_incidente]             VARCHAR (MAX)  NULL,
    [pasos_reproducir]                  VARCHAR (MAX)  NULL,
    [informacion_adicional]             VARCHAR (MAX)  NULL,
    [nombre_proyecto]                   VARCHAR (200)  NULL,
    [fb_contacto_id]                    NUMERIC (10)   NULL,
    [email_contacto]                    VARCHAR (500)  NULL,
    [titulo_incidencia]                 VARCHAR (5000) NULL,
    [fb_empleado_id]                    NUMERIC (10)   NULL,
    [incidencia_tipo]                   VARCHAR (10)   NULL,
    [flag_pase]                         VARCHAR (5)    NULL,
    [ambito]                            VARCHAR (200)  NULL,
    [inc_incidencia_relacionada_id]     NUMERIC (10)   NULL,
    [fb_cliente_relacionado_id]         NUMERIC (10)   NULL,
    [archivo_informe_incidente]         VARCHAR (400)  NULL,
    [paquete_archivo]                   VARCHAR (400)  NULL,
    [archivo_procedimiento_instalacion] VARCHAR (400)  NULL,
    [archivo_casos_prueba]              VARCHAR (400)  NULL,
    [archivo_procedimiento_usuario]     VARCHAR (400)  NULL,
    [fb_analista_dtech_id]              NUMERIC (10)   NULL,
    [responsable_ti_cliente]            VARCHAR (200)  NULL,
    [email_aviso_cliente]               VARCHAR (400)  NULL,
    [fb_responsable_ti_cliente_id]      NUMERIC (10)   NULL,
    [inc_tipo_contacto_id]              NUMERIC (10)   NULL,
    [inc_categoria_causa_id]            NUMERIC (10)   NULL,
    [inc_tipo_causa_id]                 NUMERIC (10)   NULL,
    [descripcion_causa]                 VARCHAR (MAX)  NULL,
    [fecha_solucion]                    DATETIME       NULL,
    [hora_solucion]                     VARCHAR (50)   NULL,
    CONSTRAINT [PK_fb_incidencia] PRIMARY KEY CLUSTERED ([inc_incidencia_id] ASC)
);


GO

/*      
****************************************************************************************************************************************
Nombre: dbo.[tr_inc_incidencia_gestiona_estados]
Fecha Creacion: --
Autor: --
Descripcion: Trigger que gestiona estados de incidentes.
Llamado por: Java
Usado por: Modulo: Mesa de Ayuda
Parametros: --
Uso: --
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------

**********************************************************************************************************
*/
CREATE TRIGGER [dbo].[tr_inc_incidencia_gestiona_estados]  
on [dbo].[inc_incidencia]  
after update  
as  
 BEGIN  

	DECLARE @inc_incidencia_id NUMERIC(10,0)
	DECLARE @estado_antes numeric(10,0), @estado_despues numeric(10,0)

	DECLARE @pase_id numeric(10,0), @total int, @aprobados int, @estado_pase numeric(10,0)
    
	SET @inc_incidencia_id = (SELECT inc_incidencia_id FROM inserted)  
	SET @estado_antes = (SELECT inc_estado_incidencia_id FROM deleted) 
	SET @estado_despues = (SELECT inc_estado_incidencia_id FROM inserted) 
	
	IF update(inc_estado_incidencia_id)
	 BEGIN
		IF @estado_despues = 4 -- Solución completada
		 BEGIN
			exec pr_inc_aviso_incidencia_completa @inc_incidencia_id
		 END

		IF @estado_antes = 10003 AND @estado_despues = 1 -- Instalado en QA DMT >> Solicitado (Rechazo)
		 BEGIN
			SELECT 
				@pase_id = pa.pa_pase_id,
				@estado_pase = p.pa_pase_estado_id
			FROM inc_incidencia i
				INNER JOIN pa_pase_asociado pa ON pa.inc_incidencia_id = i.inc_incidencia_id
				INNER JOIN pa_pase p ON p.pa_pase_id = pa.pa_pase_id
			WHERE
				pa.is_deleted = 0 AND
				i.inc_incidencia_id = @inc_incidencia_id

			IF @estado_pase <> 1 -- Solicitado
			 BEGIN
				INSERT INTO pa_pase_seguimiento (pa_pase_id, fecha, fb_verificador_id, flag_conforme, observacion, pa_pase_estado_id, created, created_by, updated, updated_by, owner_id, is_deleted)
				SELECT
					@pase_id,
					GETDATE(),
					1,
					'S',
					'Actualización automática por rechazo de incidencias relacionadas.',
					1,
					GETDATE(), 
					1,
					GETDATE(),
					1,
					1,
					0

				exec pr_inc_aviso_incidencia_rechazada_qa_dmt @inc_incidencia_id
			 END
		 END

		IF @estado_despues = 10004 -- Aprobado QA DMT
		 BEGIN
			SELECT @pase_id = pa.pa_pase_id
			FROM inc_incidencia i
				INNER JOIN pa_pase_asociado pa ON pa.inc_incidencia_id = i.inc_incidencia_id
			WHERE
				pa.is_deleted = 0 AND
				i.inc_incidencia_id = @inc_incidencia_id

			SELECT @total = COUNT(*)
			FROM pa_pase_asociado pa
				INNER JOIN inc_incidencia i ON i.inc_incidencia_id = pa.inc_incidencia_id
			WHERE
				pa.is_deleted = 0 AND
				pa.pa_pase_id = @pase_id

			SELECT @aprobados = COUNT(*)
			FROM pa_pase_asociado pa
				INNER JOIN inc_incidencia i ON i.inc_incidencia_id = pa.inc_incidencia_id
			WHERE
				pa.is_deleted = 0 AND
				pa.pa_pase_id = @pase_id AND
				i.inc_estado_incidencia_id = 10004 -- Aprobado QA DMT

			IF @total = @aprobados -- Todos aprobados
			 BEGIN
				INSERT INTO pa_pase_seguimiento (pa_pase_id, fecha, fb_verificador_id, flag_conforme, observacion, pa_pase_estado_id, created, created_by, updated, updated_by, owner_id, is_deleted)
				SELECT
					@pase_id,
					GETDATE(),
					1,
					'S',
					'Actualización automática por aprobación de incidencias relacionadas.',
					4,
					GETDATE(), 
					1,
					GETDATE(),
					1,
					1,
					0
			 END
		 END
	 END
 END

GO


/*      
****************************************************************************************************************************************
Nombre: dbo.[tr_inc_incidencia_genera_cod]
Fecha Creacion: --
Autor: --
Descripcion: Trigger que genera codigo tickt correlativo y envia correo aviso email de incidencia 
Llamado por: Java
Usado por: Modulo: Mesa de Ayuda
Parametros: --
Uso: --
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
26/04/2021				Mauro Roque				se modifico la funcion sql que genera codigo ticket correlativo
												ahora llama funciona "[uf_inc_codigo_incidencia_v2]" antes "[uf_inc_codigo_incidencia]"

20/10/2021				Mauro Roque				se ha creado la funcion sql que genera codigo ticket correlativo
												ahora llama funcion nueva "[uf_inc_codigo_incidencia_v3]" antes "[uf_inc_codigo_incidencia_v2]"

02/12/2021              Valky Salinas           Se agregó ID de incidencia a función que genera código.

31/01/2022              Valky Salinas           Se agregó correo a responsable.
												
**********************************************************************************************************
*/
CREATE TRIGGER [dbo].[tr_inc_incidencia_genera_cod]  
on [dbo].[inc_incidencia]  
after insert  
as  
BEGIN  
DECLARE @codigo_ticket VARCHAR(50) , @codigo_cliente VARCHAR(50) 
DECLARE @inc_incidencia_id NUMERIC(10,0)  ,@fb_cliente_id int, @anno VARCHAR(4)
    
	 SET @inc_incidencia_id = (SELECT inc_incidencia_id FROM inserted)  
	 SET @fb_cliente_id = (SELECT fb_cliente_id FROM inserted)  
	 SET @anno = (SELECT year(fecha) FROM inserted)  

	 SET @codigo_ticket = [dbo].[uf_inc_codigo_incidencia_v3](@anno,@inc_incidencia_id)  
	 SET @codigo_cliente = (SELECT upper(codigo) FROM fb_cliente WHERE fb_cliente_id = @fb_cliente_id)

		 UPDATE [inc_incidencia] 
		 SET codigo_ticket = @codigo_ticket + '-' +@codigo_cliente
		 WHERE inc_incidencia_id = @inc_incidencia_id
 
		 EXEC pr_inc_aviso_registro_incidencia @inc_incidencia_id  
		 EXEC pr_inc_aviso_registro_incidencia_responsable @inc_incidencia_id

DECLARE @inc_estado_incidencia_id NUMERIC(10,0),@fecha DATETIME

 
    SET @inc_incidencia_id = (SELECT inc_incidencia_id FROM inserted)
	SET @fecha = (SELECT fecha FROM inserted)   
	 
	SET @inc_estado_incidencia_id = (SELECT inc_estado_incidencia_id FROM inserted)   
	
			insert into inc_incidencia_seguimiento
			(
		
			inc_incidencia_id,
			fecha,
			hora,
			fb_verificador_id,
			flag_conforme,
			observacion,
			archivo,
			inc_estado_incidencia_id,
			created,
			created_by,
			updated,
			updated_by,
			owner_id,
			is_deleted

			)
			SELECT
			@inc_incidencia_id,
			fecha,
			convert(char(5), getdate(), 108) as hh_mm,      
			null, -- fb_verificador_id
			'S',
			descripcion_incidente,
			null, -- archivo
			inc_estado_incidencia_id,
			
			GETDATE(),
			1,
			GETDATE(),
			1,
			1,
			0
			FROM inc_incidencia 
			WHERE inc_incidencia_id = @inc_incidencia_id
END

GO

