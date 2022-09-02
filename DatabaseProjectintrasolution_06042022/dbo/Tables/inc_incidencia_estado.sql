CREATE TABLE [dbo].[inc_incidencia_estado] (
    [inc_incidencia_estado_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                   VARCHAR (50)  NULL,
    [nombre]                   VARCHAR (150) NULL,
    [orden]                    NUMERIC (10)  NULL,
    [estado]                   NUMERIC (1)   NULL,
    [created]                  DATETIME      NULL,
    [created_by]               NUMERIC (10)  NULL,
    [updated]                  DATETIME      NULL,
    [updated_by]               NUMERIC (10)  NULL,
    [owner_id]                 NUMERIC (10)  NULL,
    [is_deleted]               NUMERIC (10)  NULL,
    CONSTRAINT [PK_inc_incidencia_estado] PRIMARY KEY CLUSTERED ([inc_incidencia_estado_id] ASC)
);


GO

