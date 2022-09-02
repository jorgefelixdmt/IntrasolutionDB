CREATE TABLE [dbo].[inc_incidencia_comentario] (
    [inc_incidencia_comentario_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [inc_incidencia_id]            NUMERIC (10)  NULL,
    [titulo]                       VARCHAR (50)  NULL,
    [comentario]                   VARCHAR (MAX) NULL,
    [archivo]                      VARCHAR (200) NULL,
    [created]                      DATETIME      NULL,
    [created_by]                   NUMERIC (10)  NULL,
    [updated]                      DATETIME      NULL,
    [updated_by]                   NUMERIC (10)  NULL,
    [owner_id]                     NUMERIC (10)  NULL,
    [is_deleted]                   NUMERIC (10)  NULL,
    [flag]                         NUMERIC (1)   NULL,
    CONSTRAINT [PK_inc_incidencia_comentario] PRIMARY KEY CLUSTERED ([inc_incidencia_comentario_id] ASC)
);


GO

