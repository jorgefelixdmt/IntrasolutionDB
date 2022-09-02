CREATE TABLE [dbo].[sac_accion_correctiva_evidencia] (
    [sac_accion_correctiva_evidencia_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [sac_accion_correctiva_id]           NUMERIC (10)   NULL,
    [fecha]                              DATETIME       NULL,
    [archivo]                            VARCHAR (100)  NULL,
    [detalle_documento]                  VARCHAR (5000) NULL,
    [created]                            DATETIME       NULL,
    [created_by]                         NUMERIC (10)   NULL,
    [updated]                            DATETIME       NULL,
    [updated_by]                         NUMERIC (10)   NULL,
    [owner_id]                           NUMERIC (10)   NULL,
    [is_deleted]                         NUMERIC (1)    NULL,
    CONSTRAINT [PK_sac_accion_correctiva_evidencia] PRIMARY KEY CLUSTERED ([sac_accion_correctiva_evidencia_id] ASC)
);


GO

