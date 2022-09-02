CREATE TABLE [dbo].[pa_categoria_objeto] (
    [pa_categoria_objeto_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                 VARCHAR (50)  NULL,
    [nombre]                 VARCHAR (200) NULL,
    [descripcion]            VARCHAR (500) NULL,
    [orden]                  NUMERIC (10)  NULL,
    [estado]                 NUMERIC (1)   NULL,
    [created]                DATETIME      NULL,
    [created_by]             NUMERIC (10)  NULL,
    [updated]                DATETIME      NULL,
    [updated_by]             NUMERIC (10)  NULL,
    [owner_id]               NUMERIC (10)  NULL,
    [is_deleted]             NUMERIC (1)   NULL,
    CONSTRAINT [PK_pa_categoria_objeto] PRIMARY KEY CLUSTERED ([pa_categoria_objeto_id] ASC)
);


GO

