CREATE TABLE [dbo].[pry_proyecto_bitacora] (
    [pry_proyecto_bitacora_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [pry_proyecto_id]          NUMERIC (10)   NULL,
    [titulo]                   VARCHAR (512)  NULL,
    [descripcion]              VARCHAR (1024) NULL,
    [registrado_por]           VARCHAR (512)  NULL,
    [fecha]                    DATETIME       NULL,
    [g_alcance]                VARCHAR (5)    NULL,
    [estado]                   NUMERIC (1)    NULL,
    [created]                  DATETIME       NULL,
    [created_by]               NUMERIC (10)   NULL,
    [updated]                  DATETIME       NULL,
    [updated_by]               NUMERIC (10)   NULL,
    [owner_id]                 NUMERIC (10)   NULL,
    [is_deleted]               NUMERIC (1)    NULL,
    [archivo]                  VARCHAR (200)  NULL,
    [fb_registrado_por_id]     NUMERIC (10)   NULL,
    CONSTRAINT [PK_pry_proyecto_bitacora] PRIMARY KEY CLUSTERED ([pry_proyecto_bitacora_id] ASC)
);


GO

