CREATE TABLE [dbo].[inc_rango_experiencia] (
    [inc_rango_experiencia_id] NUMERIC (10) IDENTITY (1, 1) NOT NULL,
    [codigo]                   VARCHAR (50) NULL,
    [valor_minimo]             NUMERIC (3)  NULL,
    [valor_maximo]             NUMERIC (3)  NULL,
    [codigo_gobierno]          VARCHAR (50) NULL,
    [estado]                   NUMERIC (1)  NULL,
    [created]                  DATETIME     NULL,
    [created_by]               NUMERIC (10) NULL,
    [updated]                  DATETIME     NULL,
    [updated_by]               NUMERIC (10) NULL,
    [owner_id]                 NUMERIC (10) NULL,
    [is_deleted]               NUMERIC (1)  NULL,
    [orden]                    NUMERIC (10) NULL,
    CONSTRAINT [inc_rango_experiencia_id] PRIMARY KEY CLUSTERED ([inc_rango_experiencia_id] ASC)
);


GO

