CREATE TABLE [dbo].[inc_incidencia_hh] (
    [inc_incidencia_hh_id]       NUMERIC (10)     IDENTITY (1, 1) NOT NULL,
    [inc_incidencia_id]          NUMERIC (10)     NULL,
    [codigo]                     VARCHAR (50)     NULL,
    [concepto]                   VARCHAR (MAX)    NULL,
    [numero_hh]                  NUMERIC (23, 10) NULL,
    [created]                    DATETIME         NULL,
    [created_by]                 NUMERIC (10)     NULL,
    [updated]                    DATETIME         NULL,
    [updated_by]                 NUMERIC (10)     NULL,
    [owner_id]                   NUMERIC (10)     NULL,
    [is_deleted]                 NUMERIC (10)     NULL,
    [codigo_jira]                VARCHAR (200)    NULL,
    [url_jira]                   VARCHAR (500)    NULL,
    [inc_tipo_tarea_id]          NUMERIC (10)     NULL,
    [inc_subtipo_tarea_id]       NUMERIC (10)     NULL,
    [fb_empleado_responsable_id] NUMERIC (10)     NULL,
    [observacion]                VARCHAR (MAX)    NULL,
    [fecha_hora_inicio]          DATETIME         NULL,
    [fecha_hora_fin]             DATETIME         NULL,
    [fecha_hora_inicio2]         DATETIME         NULL,
    [fecha_hora_fin2]            DATETIME         NULL,
    [pa_pase_id]                 NUMERIC (10)     NULL,
    [sac_accion_correctiva_id]   NUMERIC (10)     NULL,
    [periodo]                    VARCHAR (50)     NULL,
    CONSTRAINT [PK_inc_incidencia_hh] PRIMARY KEY CLUSTERED ([inc_incidencia_hh_id] ASC)
);


GO

