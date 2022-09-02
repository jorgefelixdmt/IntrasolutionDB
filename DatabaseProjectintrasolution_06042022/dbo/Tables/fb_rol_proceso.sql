CREATE TABLE [dbo].[fb_rol_proceso] (
    [fb_rol_proceso_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]            VARCHAR (200) NULL,
    [nombre]            VARCHAR (200) NULL,
    [descripcion]       VARCHAR (MAX) NULL,
    [estado]            NUMERIC (1)   NULL,
    [created]           DATETIME      NULL,
    [created_by]        NUMERIC (10)  NULL,
    [updated]           DATETIME      NULL,
    [updated_by]        NUMERIC (10)  NULL,
    [owner_id]          NUMERIC (10)  NULL,
    [is_deleted]        NUMERIC (1)   NULL
);


GO

