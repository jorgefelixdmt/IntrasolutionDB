CREATE TABLE [dbo].[inc_frecuencia_exposicion] (
    [inc_frecuencia_exposicion_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                       VARCHAR (50)  NULL,
    [nombre]                       VARCHAR (100) NULL,
    [descripcion]                  VARCHAR (500) NULL,
    [estado]                       NUMERIC (1)   NULL,
    [created]                      DATETIME      NULL,
    [created_by]                   NUMERIC (10)  NULL,
    [updated]                      DATETIME      NULL,
    [updated_by]                   NUMERIC (10)  NULL,
    [owner_id]                     NUMERIC (10)  NULL,
    [is_deleted]                   NUMERIC (1)   NULL,
    CONSTRAINT [PK_inc_frecuencia_exposicion] PRIMARY KEY CLUSTERED ([inc_frecuencia_exposicion_id] ASC)
);


GO

