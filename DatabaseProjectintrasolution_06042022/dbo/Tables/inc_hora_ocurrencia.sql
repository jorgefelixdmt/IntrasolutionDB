CREATE TABLE [dbo].[inc_hora_ocurrencia] (
    [inc_hora_ocurrencia_id] NUMERIC (10) IDENTITY (1, 1) NOT NULL,
    [codigo]                 VARCHAR (50) NULL,
    [valor]                  NUMERIC (2)  NULL,
    [codigo_gobierno]        VARCHAR (50) NULL,
    [estado]                 NUMERIC (1)  NULL,
    [created]                DATETIME     NULL,
    [created_by]             NUMERIC (10) NULL,
    [updated]                DATETIME     NULL,
    [updated_by]             NUMERIC (10) NULL,
    [owner_id]               NUMERIC (10) NULL,
    [is_deleted]             NUMERIC (1)  NULL,
    [orden]                  NUMERIC (10) NULL,
    CONSTRAINT [inc_hora_ocurrencia_id] PRIMARY KEY CLUSTERED ([inc_hora_ocurrencia_id] ASC)
);


GO

