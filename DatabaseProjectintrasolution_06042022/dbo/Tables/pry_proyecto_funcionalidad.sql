CREATE TABLE [dbo].[pry_proyecto_funcionalidad] (
    [pry_proyecto_funcionalidad_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [pry_proyecto_modulo_id]        NUMERIC (10)   NULL,
    [codigo]                        VARCHAR (50)   NULL,
    [nombre]                        VARCHAR (512)  NULL,
    [descripcion]                   VARCHAR (1024) NULL,
    [observaciones]                 VARCHAR (1024) NULL,
    [pry_estado_funcionalidad_id]   NUMERIC (10)   NULL,
    [estado]                        NUMERIC (1)    NULL,
    [created]                       DATETIME       NULL,
    [created_by]                    NUMERIC (10)   NULL,
    [updated]                       DATETIME       NULL,
    [updated_by]                    NUMERIC (10)   NULL,
    [owner_id]                      NUMERIC (10)   NULL,
    [is_deleted]                    NUMERIC (1)    NULL,
    CONSTRAINT [PK_pry_proyecto_funcionalidad] PRIMARY KEY CLUSTERED ([pry_proyecto_funcionalidad_id] ASC)
);


GO

