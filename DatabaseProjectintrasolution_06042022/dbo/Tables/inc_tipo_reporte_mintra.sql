CREATE TABLE [dbo].[inc_tipo_reporte_mintra] (
    [inc_tipo_reporte_mintra_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [inc_tipo_reporte_id]        NUMERIC (10)  NULL,
    [tipo_reporte_nombre]        VARCHAR (100) NULL,
    [inc_potencial_perdida_id]   NUMERIC (10)  NULL,
    [potencial_perdida_nombre]   VARCHAR (100) NULL,
    [inc_tipo_registro_id]       NUMERIC (10)  NULL,
    [tipo_registro_nombre]       VARCHAR (100) NULL,
    [estado]                     NUMERIC (1)   NULL,
    [created]                    DATETIME      NULL,
    [created_by]                 NUMERIC (10)  NULL,
    [updated]                    DATETIME      NULL,
    [updated_by]                 NUMERIC (10)  NULL,
    [owner_id]                   NUMERIC (10)  NULL,
    [is_deleted]                 NUMERIC (10)  NULL
);


GO

