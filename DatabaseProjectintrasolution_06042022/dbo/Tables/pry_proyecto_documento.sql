CREATE TABLE [dbo].[pry_proyecto_documento] (
    [pry_proyecto_documento_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [pry_proyecto_id]           NUMERIC (10)   NULL,
    [titulo]                    VARCHAR (500)  NULL,
    [descripcion]               VARCHAR (MAX)  NULL,
    [fecha_documento]           DATETIME       NULL,
    [g_alcance]                 VARCHAR (10)   NULL,
    [archivo]                   VARCHAR (1024) NULL,
    [pry_documento_tipo_id]     NUMERIC (10)   NULL,
    [created]                   DATETIME       NULL,
    [created_by]                NUMERIC (10)   NULL,
    [updated]                   DATETIME       NULL,
    [updated_by]                NUMERIC (10)   NULL,
    [owner_id]                  NUMERIC (10)   NULL,
    [is_deleted]                NUMERIC (1)    NULL,
    CONSTRAINT [PK_pry_proyecto_documento] PRIMARY KEY CLUSTERED ([pry_proyecto_documento_id] ASC)
);


GO

