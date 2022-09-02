CREATE TABLE [dbo].[pa_pase] (
    [pa_pase_id]                     NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [fecha_solicitud]                DATETIME      NULL,
    [fb_solicitante_id]              NUMERIC (10)  NULL,
    [codigo_jira]                    VARCHAR (100) NULL,
    [pry_proyecto_id]                NUMERIC (10)  NULL,
    [fb_empresa_id]                  NUMERIC (10)  NULL,
    [descripcion]                    VARCHAR (MAX) NULL,
    [email_analista]                 VARCHAR (500) NULL,
    [email_constructor_pase]         VARCHAR (500) NULL,
    [email_qa_cliente]               VARCHAR (500) NULL,
    [email_qa_empresa]               VARCHAR (500) NULL,
    [email_usuario_cliente]          VARCHAR (500) NULL,
    [pa_pase_estado_id]              NUMERIC (10)  NULL,
    [created]                        DATETIME      NULL,
    [created_by]                     NUMERIC (18)  NULL,
    [updated]                        DATETIME      NULL,
    [updated_by]                     NUMERIC (10)  NULL,
    [owner_id]                       NUMERIC (10)  NULL,
    [is_deleted]                     NUMERIC (10)  NULL,
    [fb_cliente_id]                  NUMERIC (10)  NULL,
    [fecha_estado]                   DATETIME      NULL,
    [informe]                        VARCHAR (200) NULL,
    [url_pase]                       VARCHAR (500) NULL,
    [pl_tipo_pase_id]                NUMERIC (10)  NULL,
    [version]                        VARCHAR (50)  NULL,
    [flag_version_requerida_app]     NUMERIC (1)   NULL,
    [version_requerida_app]          VARCHAR (50)  NULL,
    [flag_version_requerida_Frw]     NUMERIC (1)   NULL,
    [version_requerida_frw]          VARCHAR (50)  NULL,
    [url_jira]                       VARCHAR (500) NULL,
    [flag_version_requerida_app_std] NUMERIC (1)   NULL,
    [version_requerida_app_std]      VARCHAR (50)  NULL,
    [flag_version_requerida_std]     NUMERIC (10)  NULL,
    [version_requerida_std]          VARCHAR (200) NULL,
    [flag_obs_qa_dmt]                NUMERIC (1)   NULL,
    [flag_obs_qa_cliente]            NUMERIC (1)   NULL,
    [nombre_archivo_pase]            VARCHAR (200) NULL,
    CONSTRAINT [PK_pa_pase] PRIMARY KEY CLUSTERED ([pa_pase_id] ASC)
);


GO

/*      
****************************************************************************************************************************************
Nombre: dbo.[tr_pa_pase_insert_seguimiento]
Fecha Creacion: 25/05/2020
Autor: Mauro Roque
Descripcion: trigger que inserta un seguimiento de pases de softwae
Usado por: Modulo: pases de Software
tablas que afecta - pa_pase_seguimiento INSERTA
Uso: 
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
14/01/2022				Mauro Roque			   Se agrego nuevo insert into pa_pase_seguimiento donde grabar estado pase "20. PREPARADO"

16/03/2022              Valky Salinas          Se quitó actualización automática a preparado.

**********************************************************************************************************
*/

CREATE TRIGGER [dbo].[tr_pa_pase_insert_seguimiento]
   ON  [dbo].[pa_pase]
   AFTER INSERT
AS 
 BEGIN
	SET NOCOUNT ON;

	DECLARE @pa_pase_estado_id numeric(10,0),@fecha_estado datetime

	declare @pa_pase_id numeric(10,0)
 
    set @pa_pase_id = (select pa_pase_id from inserted)
	set @fecha_estado = (select fecha_estado from inserted)   
	 
 set @pa_pase_estado_id = (select pa_pase_estado_id from inserted)   
	
			insert into pa_pase_seguimiento
			(
		
			pa_pase_id,
			fecha,
			fb_verificador_id,
			flag_conforme,
			observacion,
			archivo,
			pa_pase_estado_id,
			pa_pase_siguiente_id,
			created,
			created_by,
			updated,
			updated_by,
			owner_id,
			is_deleted

			)
			select
			@pa_pase_id,
			fecha_solicitud,
			fb_solicitante_id,
			'S',
			descripcion,
			null, -- archivo
			pa_pase_estado_id,
			null, --pa_pase_siguiente_id
			GETDATE(),
			1,
			GETDATE(),
			1,
			1,
			0
			from pa_pase 
			where pa_pase_id = @pa_pase_id
/*
	-- agregado inicio cuando es estado del pase "Preparado"
		insert into pa_pase_seguimiento
			(
		
			pa_pase_id,
			fecha,
			fb_verificador_id,
			flag_conforme,
			observacion,
			archivo,
			pa_pase_estado_id,
			pa_pase_siguiente_id,
			created,
			created_by,
			updated,
			updated_by,
			owner_id,
			is_deleted

			)
			select
			@pa_pase_id,
			fecha_solicitud,
			12, -- Mauro Roque : Id de la tabla fb_empleado
			'S',
			descripcion,
			null, -- archivo
			2, -- Estado Pase : 20. PREPARADO
			null, --pa_pase_siguiente_id
			GETDATE(),
			1,
			GETDATE(),
			1,
			1,
			0
			from pa_pase 
			where pa_pase_id = @pa_pase_id
			*/


 END

GO




/*      
****************************************************************************************************************************************
Nombre: dbo.[tr_pa_pase_gestion_estados]
Fecha Creacion: 15/1/2021
Autor: Mauro Roque
Descripcion: trigger que gestiona cambios de estados en pases
Usado por: Modulo: pases de Software
tablas que afecta - pa_pase
Uso: 
RESUMEN DE CAMBIOS
Fecha(dd-mm-aaaa)       Autor                  Comentarios
------------------      -----------------      -------------------------------------------------------------------------------------
22/12/2021              Valky Salinas          Se cambió actualización de estado de incidencias a cursor.

16/03/2022              Valky Salinas          Se agregó inserción de acciones correctivas.

****************************************************************************************************************************************
*/

CREATE TRIGGER [dbo].[tr_pa_pase_gestion_estados]
   ON  [dbo].[pa_pase]
   AFTER UPDATE
AS 
 BEGIN
	SET NOCOUNT ON;

	DECLARE @pa_pase_id NUMERIC(10,0)
	DECLARE @estado_antes numeric(10,0), @estado_despues numeric(10,0)
    
	SET @pa_pase_id = (SELECT pa_pase_id FROM inserted)  
	SET @estado_antes = (SELECT pa_pase_estado_id FROM deleted) 
	SET @estado_despues = (SELECT pa_pase_estado_id FROM inserted) 
	
	IF update(pa_pase_estado_id)
	 BEGIN
		IF @estado_despues = 2 -- Preparado
		 BEGIN
			exec pr_pa_aviso_pase_preparado @pa_pase_id
		 END
		 
		IF @estado_despues = 3 -- Instalado en QA DMT
		 BEGIN
			DECLARE @inc_id numeric(10,0)

			DECLARE CURSOR_INC CURSOR FOR 
				SELECT i.inc_incidencia_id
				FROM inc_incidencia i
					INNER JOIN pa_pase_asociado pa ON pa.inc_incidencia_id = i.inc_incidencia_id
				WHERE
					pa.is_deleted = 0 AND
					pa.pa_pase_id = @pa_pase_id

			OPEN CURSOR_INC

			FETCH NEXT FROM CURSOR_INC INTO @inc_id

			WHILE @@fetch_status = 0
			 BEGIN
				-- Actualiza estado de incidencia
				UPDATE i
				SET i.inc_estado_incidencia_id = 10003 -- Instalado en QA DMT
				FROM inc_incidencia i
					INNER JOIN pa_pase_asociado pa ON pa.inc_incidencia_id = i.inc_incidencia_id
				WHERE
					pa.is_deleted = 0 AND
					i.inc_incidencia_id = @inc_id

				-- Inserta Acción Correctiva
				INSERT INTO sac_accion_correctiva
					(
					g_tipo_origen_id,
					origen_id,
					codigo_registro_origen,
					fecha_origen,
					g_tipo_accion_id,
					accion_correctiva_detalle,
					sac_estado_accion_correctiva_id,
					codigo_jira,
					fb_empleado_id_correcion,
					fb_uea_pe_id,
					created,
					created_by,
					updated,
					updated_by,
					owner_id,
					is_deleted
					)
				SELECT
					10023, -- Incidente Intrasolution
					@inc_id,
					codigo_ticket,
					fecha,
					2, -- Preventiva
					'Revisión en QA DMT - ' + titulo_incidencia,
					1, -- Pendiente
					codigo_jira,
					fb_analista_dtech_id,
					1,
					GETDATE(),
					1,
					GETDATE(),
					1,
					1,
					0
				FROM inc_incidencia
				WHERE inc_incidencia_id = @inc_id

				FETCH NEXT FROM CURSOR_INC INTO @inc_id
			 END

			CLOSE CURSOR_INC
			DEALLOCATE CURSOR_INC

			exec pr_inc_aviso_incidencia_por_revisar_qa_dmt @pa_pase_id
		 END

		IF @estado_despues = 4 -- Revisado en QA DMT
		 BEGIN
			exec pr_pa_aviso_pase_aprobado_qa_dmt @pa_pase_id
		 END
	 END

 END

GO

