CREATE TABLE [dbo].[cap_tipo_capacitacion] (
    [cap_tipo_capacitacion_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                   VARCHAR (50)  NULL,
    [nombre]                   VARCHAR (100) NULL,
    [estado]                   NUMERIC (1)   NULL,
    [created]                  DATETIME      NULL,
    [created_by]               NUMERIC (10)  NULL,
    [updated]                  DATETIME      NULL,
    [updated_by]               NUMERIC (10)  NULL,
    [owner_id]                 NUMERIC (10)  NULL,
    [is_deleted]               NUMERIC (1)   NULL,
    CONSTRAINT [cap_tipo_capacitacion_id] PRIMARY KEY CLUSTERED ([cap_tipo_capacitacion_id] ASC)
);


GO

