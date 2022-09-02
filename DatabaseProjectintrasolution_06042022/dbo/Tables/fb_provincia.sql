CREATE TABLE [dbo].[fb_provincia] (
    [fb_provincia_id]    NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [codigo]             NVARCHAR (20)  NULL,
    [nombre]             NVARCHAR (200) NULL,
    [estado]             NUMERIC (1)    NULL,
    [creado]             DATETIME       NULL,
    [creado_por]         NUMERIC (10)   NULL,
    [actualizado]        DATETIME       NULL,
    [actualizado_por]    NUMERIC (10)   NULL,
    [propietario_id]     NUMERIC (10)   NULL,
    [cod_departamento]   CHAR (2)       NULL,
    [fb_departamento_id] NUMERIC (10)   NULL,
    CONSTRAINT [PK_fb_provincia] PRIMARY KEY CLUSTERED ([fb_provincia_id] ASC)
);


GO

