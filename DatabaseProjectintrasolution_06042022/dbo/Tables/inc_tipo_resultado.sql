CREATE TABLE [dbo].[inc_tipo_resultado] (
    [inc_tipo_resultado_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                VARCHAR (50)  NULL,
    [nombre]                VARCHAR (100) NULL,
    [orden]                 NUMERIC (10)  NULL,
    [estado]                NUMERIC (1)   NULL,
    [created]               DATETIME      NULL,
    [created_by]            NUMERIC (10)  NULL,
    [updated]               DATETIME      NULL,
    [updated_by]            NUMERIC (10)  NULL,
    [owner_id]              NUMERIC (10)  NULL,
    [is_deleted]            NUMERIC (1)   NULL,
    CONSTRAINT [inc_tipo_resultado_id] PRIMARY KEY CLUSTERED ([inc_tipo_resultado_id] ASC)
);


GO

