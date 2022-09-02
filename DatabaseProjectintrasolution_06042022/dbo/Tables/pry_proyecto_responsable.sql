CREATE TABLE [dbo].[pry_proyecto_responsable] (
    [pry_proyecto_responsable_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [pry_proyecto_id]             NUMERIC (10)   NULL,
    [nombre_responable]           VARCHAR (512)  NULL,
    [descripcion]                 VARCHAR (1024) NULL,
    [email]                       VARCHAR (100)  NULL,
    [fecha_inicio]                DATETIME       NULL,
    [fecha_fin]                   DATETIME       NULL,
    [g_alcance]                   VARCHAR (50)   NULL,
    [pry_responsable_tipo_id]     NUMERIC (10)   NULL,
    [estado]                      NUMERIC (1)    NULL,
    [created]                     DATETIME       NULL,
    [created_by]                  NUMERIC (10)   NULL,
    [updated]                     DATETIME       NULL,
    [updated_by]                  NUMERIC (10)   NULL,
    [owner_id]                    NUMERIC (10)   NULL,
    [is_deleted]                  NUMERIC (1)    NULL,
    CONSTRAINT [PK_pry_proyecto_responsable] PRIMARY KEY CLUSTERED ([pry_proyecto_responsable_id] ASC)
);


GO

