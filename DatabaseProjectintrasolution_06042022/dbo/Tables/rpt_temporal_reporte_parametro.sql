CREATE TABLE [dbo].[rpt_temporal_reporte_parametro] (
    [rpt_temporal_reporte_parametro_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [fb_periodo_id]                     NUMERIC (10)  NULL,
    [fb_periodo_mensual_id]             NUMERIC (10)  NULL,
    [fb_periodo_trimestral_id]          NUMERIC (10)  NULL,
    [fb_periodo_semestral_id]           NUMERIC (10)  NULL,
    [fb_periodo_anual_id]               NUMERIC (10)  NULL,
    [parametro_reporte]                 VARCHAR (50)  NULL,
    [rpt_reporte_id]                    NUMERIC (10)  NULL,
    [fb_uea_pe_id]                      NUMERIC (10)  NULL,
    [fb_empresa_id]                     NUMERIC (10)  NULL,
    [fb_empresa_especializada_id]       NUMERIC (10)  NULL,
    [nombre_empresa]                    VARCHAR (50)  NULL,
    [trimestre]                         VARCHAR (50)  NULL,
    [ano_id]                            NUMERIC (10)  NULL,
    [ano]                               VARCHAR (50)  NULL,
    [mes]                               VARCHAR (50)  NULL,
    [mes_inicio]                        VARCHAR (50)  NULL,
    [mes_fin]                           VARCHAR (50)  NULL,
    [fecha_desde]                       DATETIME      NULL,
    [fecha_hasta]                       DATETIME      NULL,
    [created]                           DATETIME      NULL,
    [created_by]                        NUMERIC (10)  NULL,
    [updated]                           DATETIME      NULL,
    [updated_by]                        NUMERIC (10)  NULL,
    [owner_id]                          NUMERIC (10)  NULL,
    [is_deleted]                        NUMERIC (1)   NULL,
    [codigo]                            VARCHAR (50)  NULL,
    [descripcion]                       VARCHAR (500) NULL,
    [categoria]                         VARCHAR (5)   NULL,
    [registro_periodo_desde]            DATETIME      NULL,
    [registro_periodo_hasta]            DATETIME      NULL,
    [documentario_periodo_desde]        DATETIME      NULL,
    [documentario_periodo_hasta]        DATETIME      NULL,
    [cap_curso_id]                      NUMERIC (10)  NULL,
    [cantidad]                          NUMERIC (10)  NULL,
    [cap_tema_id]                       NUMERIC (10)  NULL,
    [fecha_inicio]                      DATETIME      NULL,
    [fecha_final]                       DATETIME      NULL,
    [fb_cliente_id]                     NUMERIC (10)  NULL,
    [pry_proyecto_id]                   NUMERIC (10)  NULL,
    [ambito]                            VARCHAR (5)   NULL,
    [inc_estado_incidencia_id]          NUMERIC (10)  NULL,
    [incidencia_estado_cadena]          VARCHAR (50)  NULL,
    CONSTRAINT [PK_rpt_temporal_reporte_parametro] PRIMARY KEY CLUSTERED ([rpt_temporal_reporte_parametro_id] ASC)
);


GO
