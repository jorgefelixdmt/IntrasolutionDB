CREATE TABLE [dbo].[inc_resultado] (
    [inc_resultado_id]      NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [inc_prueba_id]         NUMERIC (10)  NULL,
    [inc_incidencia_id]     NUMERIC (10)  NULL,
    [resultado_obtenido]    VARCHAR (500) NULL,
    [observaciones]         VARCHAR (500) NULL,
    [evidencia_adjunta]     VARCHAR (200) NULL,
    [fecha_ejecucion]       DATETIME      NULL,
    [fb_ejecutado_por_id]   NUMERIC (10)  NULL,
    [ejecutado_por_texto]   VARCHAR (500) NULL,
    [inc_tipo_resultado_id] NUMERIC (10)  NULL,
    [created]               DATETIME      NULL,
    [created_by]            NUMERIC (10)  NULL,
    [updated]               DATETIME      NULL,
    [updated_by]            NUMERIC (10)  NULL,
    [owner_id]              NUMERIC (10)  NULL,
    [is_deleted]            NUMERIC (1)   NULL,
    CONSTRAINT [inc_PK_resultado_id] PRIMARY KEY CLUSTERED ([inc_resultado_id] ASC)
);


GO

