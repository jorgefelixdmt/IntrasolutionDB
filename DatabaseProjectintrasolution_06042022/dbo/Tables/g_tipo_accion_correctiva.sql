CREATE TABLE [dbo].[g_tipo_accion_correctiva] (
    [g_tipo_accion_correctiva_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [codigo]                      NVARCHAR (50)  NULL,
    [nombre]                      NVARCHAR (200) NULL,
    [created]                     DATETIME       NULL,
    [created_by]                  NUMERIC (10)   NULL,
    [updated]                     DATETIME       NULL,
    [updated_by]                  NUMERIC (10)   NULL,
    [owner_id]                    NUMERIC (10)   NULL,
    [estado]                      NUMERIC (1)    NULL,
    [is_deleted]                  NUMERIC (1)    NULL,
    [orden]                       NUMERIC (10)   NULL,
    CONSTRAINT [PK_g_tipo_accion_correctiva] PRIMARY KEY CLUSTERED ([g_tipo_accion_correctiva_id] ASC)
);


GO

