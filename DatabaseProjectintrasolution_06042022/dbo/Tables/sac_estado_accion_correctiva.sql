CREATE TABLE [dbo].[sac_estado_accion_correctiva] (
    [sac_estado_accion_correctiva_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                          VARCHAR (50)  NULL,
    [nombre]                          VARCHAR (100) NULL,
    [estado]                          NUMERIC (1)   NULL,
    [created]                         DATETIME      NULL,
    [created_by]                      NUMERIC (10)  NULL,
    [updated]                         DATETIME      NULL,
    [updated_by]                      NUMERIC (10)  NULL,
    [owner_id]                        NUMERIC (10)  NULL,
    [is_deleted]                      NUMERIC (1)   NULL,
    [orden]                           NUMERIC (10)  NULL,
    CONSTRAINT [PK_sac_estado_accion_correctiva] PRIMARY KEY CLUSTERED ([sac_estado_accion_correctiva_id] ASC)
);


GO

