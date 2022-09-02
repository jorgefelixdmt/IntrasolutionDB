CREATE TABLE [dbo].[cap_curso_tema] (
    [cap_curso_tema_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [cap_curso_id]      NUMERIC (10)  NULL,
    [cap_tema_id]       NUMERIC (10)  NOT NULL,
    [expositor]         VARCHAR (200) NULL,
    [duracion_hora]     NUMERIC (10)  NULL,
    [estado]            NUMERIC (1)   NULL,
    [created]           DATETIME      NULL,
    [created_by]        NUMERIC (10)  NULL,
    [updated]           DATETIME      NULL,
    [updated_by]        NUMERIC (10)  NULL,
    [owner_id]          NUMERIC (10)  NULL,
    [is_deleted]        NUMERIC (1)   NULL,
    [id_Carga]          NUMERIC (10)  NULL,
    CONSTRAINT [cap_curso_tema_id] PRIMARY KEY CLUSTERED ([cap_curso_tema_id] ASC)
);


GO

