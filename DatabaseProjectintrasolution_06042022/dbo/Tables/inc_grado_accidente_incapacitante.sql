CREATE TABLE [dbo].[inc_grado_accidente_incapacitante] (
    [inc_grado_accidente_incapacitante_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [inc_gravedad_accidente_id]            NUMERIC (10)  NULL,
    [codigo]                               VARCHAR (50)  NULL,
    [nombre]                               VARCHAR (200) NULL,
    [estado]                               NUMERIC (1)   NULL,
    [created]                              DATETIME      NULL,
    [created_by]                           NUMERIC (10)  NULL,
    [updated]                              DATETIME      NULL,
    [updated_by]                           NUMERIC (10)  NULL,
    [owner_id]                             NUMERIC (10)  NULL,
    [is_deleted]                           NUMERIC (1)   NULL,
    CONSTRAINT [PK_inc_grado_accidente_incapacitante] PRIMARY KEY CLUSTERED ([inc_grado_accidente_incapacitante_id] ASC)
);


GO

