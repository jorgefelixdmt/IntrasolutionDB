CREATE TABLE [dbo].[inc_informe_final] (
    [inc_informe_final_id]          NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [codigo]                        VARCHAR (50)    NULL,
    [fb_empresa_id]                 NUMERIC (10)    NULL,
    [fb_uea_pe_id]                  NUMERIC (10)    NULL,
    [g_tipo_origen_id]              NUMERIC (10)    NULL,
    [inc_tipo_reporte_id]           NUMERIC (10)    NULL,
    [tipo_reporte_nombre]           VARCHAR (100)   NULL,
    [otro_tipo_reporte]             VARCHAR (200)   NULL,
    [inc_potencial_perdida_id]      NUMERIC (10)    NULL,
    [potencial_perdida_nombre]      VARCHAR (100)   NULL,
    [inc_tipo_reporte_mintra_id]    NUMERIC (10)    NULL,
    [tipo_registro_nombre]          VARCHAR (100)   NULL,
    [accidente_incapacitante]       NUMERIC (1)     NULL,
    [accidente_leve]                NUMERIC (1)     NULL,
    [dano_propiedad]                NUMERIC (1)     NULL,
    [incidente]                     NUMERIC (1)     NULL,
    [perdida_proceso]               NUMERIC (1)     NULL,
    [accidente_ambiental]           NUMERIC (1)     NULL,
    [inc_segun_tipo_id]             NUMERIC (10)    NULL,
    [segun_tipo_nombre]             VARCHAR (200)   NULL,
    [fb_empleado_id]                NUMERIC (10)    NULL,
    [dni]                           VARCHAR (50)    NULL,
    [empleado_codigo]               VARCHAR (20)    NULL,
    [empleado_nombre_completo]      VARCHAR (200)   NULL,
    [area_supervisor_codigo]        VARCHAR (50)    NULL,
    [area_supervisor_nombre]        VARCHAR (200)   NULL,
    [fb_area_id]                    NUMERIC (10)    NULL,
    [area_evento_codigo]            VARCHAR (50)    NULL,
    [area_evento_nombre]            VARCHAR (50)    NULL,
    [fecha_evento]                  DATETIME        NULL,
    [hora_evento]                   VARCHAR (15)    NULL,
    [lugar_evento]                  VARCHAR (500)   NULL,
    [tiempo_para_proceso]           NUMERIC (10)    NULL,
    [costo_dano_propiedad]          NUMERIC (10)    NULL,
    [costo_probable_dano]           NUMERIC (10)    NULL,
    [testigos]                      VARCHAR (500)   NULL,
    [costo_evento]                  NUMERIC (13, 2) NULL,
    [descripcion_pre_evento]        VARCHAR (MAX)   NULL,
    [descripcion_evento]            VARCHAR (MAX)   NULL,
    [descripcion_post_evento]       VARCHAR (MAX)   NULL,
    [descripcion_dano_perdida]      VARCHAR (MAX)   NULL,
    [comentarios]                   VARCHAR (MAX)   NULL,
    [codigo_informe_preliminar]     VARCHAR (20)    NULL,
    [calidad]                       VARCHAR (20)    NULL,
    [preliminar_final]              VARCHAR (1)     NULL,
    [inc_estado_investigacion_id]   NUMERIC (10)    NULL,
    [estado_inves_nombre]           VARCHAR (100)   NULL,
    [inc_estado_info_preliminar_id] NUMERIC (10)    NULL,
    [estado_info_preliminar_nombre] VARCHAR (100)   NULL,
    [origen_acto_sub]               NUMERIC (1)     NULL,
    [origen_condicion_sub]          NUMERIC (1)     NULL,
    [inc_tipo_contacto_id]          NUMERIC (10)    NULL,
    [tipo_contacto_nombre]          VARCHAR (200)   NULL,
    [origen_concatenado]            VARCHAR (100)   NULL,
    [minuto_evento]                 VARCHAR (2)     NULL,
    [hora_formateada]               VARCHAR (25)    NULL,
    [compania]                      VARCHAR (3)     NULL,
    [localidad]                     VARCHAR (4)     NULL,
    [paraje]                        VARCHAR (250)   NULL,
    [imagen_pre_evento]             VARCHAR (200)   NULL,
    [comentario_imagen_pre_evento]  VARCHAR (1000)  NULL,
    [imagen_evento]                 VARCHAR (200)   NULL,
    [comentario_imagen_evento]      VARCHAR (1000)  NULL,
    [imagen_post_evento]            VARCHAR (200)   NULL,
    [comentario_imagen_post_evento] VARCHAR (1000)  NULL,
    [imagen_croquis]                VARCHAR (200)   NULL,
    [comentario_imagen_croquis]     VARCHAR (1000)  NULL,
    [prevision]                     VARCHAR (10)    NULL,
    [tipo_cambio]                   NUMERIC (5, 2)  NULL,
    [codigo_historico]              VARCHAR (50)    NULL,
    [fecha_envio]                   DATETIME        NULL,
    [latitud]                       NUMERIC (10)    NULL,
    [longitud]                      NUMERIC (10)    NULL,
    [created]                       DATETIME        NULL,
    [created_by]                    NUMERIC (10)    NULL,
    [updated]                       DATETIME        NULL,
    [updated_by]                    NUMERIC (10)    NULL,
    [owner_id]                      NUMERIC (10)    NULL,
    [is_deleted]                    NUMERIC (1)     NULL,
    [fecha_investigacion]           DATETIME        NULL,
    [num_trab_afectado]             NUMERIC (5)     NULL,
    [num_pobladores_potencial]      NUMERIC (5)     NULL,
    [num_trabajadores_potencial]    NUMERIC (5)     NULL,
    [atencion_primeros_aux]         VARCHAR (400)   NULL,
    [afecta_trabajador]             VARCHAR (50)    NULL,
    [hora_final]                    VARCHAR (50)    NULL,
    [minuto_final]                  VARCHAR (50)    NULL,
    [hora_minuto_final]             VARCHAR (50)    NULL,
    [fb_ubicacion_id]               NUMERIC (10)    NULL,
    [codigo_departamento]           VARCHAR (50)    NULL,
    [departamento]                  VARCHAR (50)    NULL,
    [codigo_municipio]              VARCHAR (50)    NULL,
    [municipio]                     VARCHAR (50)    NULL,
    [zona]                          VARCHAR (50)    NULL,
    CONSTRAINT [PK_inc_informe_final] PRIMARY KEY CLUSTERED ([inc_informe_final_id] ASC)
);


GO


create trigger [dbo].[tr_inc_informe_final]
on [dbo].[inc_informe_final]
after insert
as
begin
declare @codigo varchar(50)
declare @fb_uea_pe_id numeric(10,0)
declare @inc_informe_final numeric(10,0)
	
	set @fb_uea_pe_id = (select fb_uea_pe_id from inserted)
	set @inc_informe_final = (select inc_informe_final_id  from inserted)


	set @codigo = [dbo].[uf_inc_informe_final](@fb_uea_pe_id)

	update inc_informe_final set codigo = @codigo where inc_informe_final_id = @inc_informe_final
end

GO

