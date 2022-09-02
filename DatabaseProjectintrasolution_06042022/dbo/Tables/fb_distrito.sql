CREATE TABLE [dbo].[fb_distrito] (
    [fb_distrito_id]     NUMERIC (10)   NOT NULL,
    [codigo]             NVARCHAR (20)  NULL,
    [nombre]             NVARCHAR (200) NULL,
    [estado]             NUMERIC (1)    NULL,
    [creado]             DATETIME       NULL,
    [creado_por]         NUMERIC (10)   NULL,
    [actualizado]        DATETIME       NULL,
    [actualizado_por]    NUMERIC (10)   NULL,
    [propietario_id]     NUMERIC (10)   NULL,
    [fb_provincia_id]    NUMERIC (10)   NULL,
    [fb_departamento_id] NUMERIC (10)   NULL,
    [cod_departamento]   CHAR (2)       NULL,
    [cod_provincia]      CHAR (2)       NULL,
    [ubigeo]             CHAR (6)       NULL,
    CONSTRAINT [PK_fb_distrito] PRIMARY KEY CLUSTERED ([fb_distrito_id] ASC)
);


GO

