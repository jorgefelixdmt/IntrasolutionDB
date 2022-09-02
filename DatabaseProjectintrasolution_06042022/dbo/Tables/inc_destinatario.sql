CREATE TABLE [dbo].[inc_destinatario] (
    [inc_destinatario_id]      NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                   VARCHAR (50)  NULL,
    [nombre]                   VARCHAR (100) NULL,
    [email]                    VARCHAR (200) NULL,
    [inc_tipo_reporte_id]      NUMERIC (10)  NULL,
    [inc_potencial_perdida_id] NUMERIC (10)  NULL,
    [estado]                   NUMERIC (1)   NULL,
    [created]                  DATETIME      NULL,
    [created_by]               NUMERIC (10)  NULL,
    [updated]                  DATETIME      NULL,
    [updated_by]               NUMERIC (10)  NULL,
    [owner_id]                 NUMERIC (10)  NULL,
    [is_deleted]               NUMERIC (1)   NULL,
    [orden]                    NUMERIC (10)  NULL,
    CONSTRAINT [inc_destinatario_id] PRIMARY KEY CLUSTERED ([inc_destinatario_id] ASC)
);


GO

