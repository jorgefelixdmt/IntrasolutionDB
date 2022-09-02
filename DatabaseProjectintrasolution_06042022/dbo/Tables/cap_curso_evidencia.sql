CREATE TABLE [dbo].[cap_curso_evidencia] (
    [cap_curso_evidencia_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [cap_curso_id]           NUMERIC (10)  NOT NULL,
    [fecha]                  DATETIME      NULL,
    [archivo]                VARCHAR (200) NULL,
    [detalle_documento]      VARCHAR (400) NULL,
    [created]                DATETIME      NULL,
    [created_by]             NUMERIC (10)  NULL,
    [updated]                DATETIME      NULL,
    [updated_by]             NUMERIC (10)  NULL,
    [owner_id]               NUMERIC (10)  NULL,
    [is_deleted]             NUMERIC (1)   NULL,
    CONSTRAINT [cap_curso_evidencia_id] PRIMARY KEY CLUSTERED ([cap_curso_evidencia_id] ASC)
);


GO

