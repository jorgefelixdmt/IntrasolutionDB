CREATE TABLE [dbo].[fb_departamento] (
    [fb_departamento_id] NUMERIC (10)   NOT NULL,
    [codigo]             NVARCHAR (20)  NULL,
    [nombre]             NVARCHAR (200) NULL,
    [estado]             NUMERIC (1)    NULL,
    [creado]             DATETIME       NULL,
    [creado_por]         NUMERIC (10)   NULL,
    [actualizado]        DATETIME       NULL,
    [actualizado_por]    NUMERIC (10)   NULL,
    [propietario_id]     NUMERIC (10)   NULL,
    CONSTRAINT [PK_fb_departamento] PRIMARY KEY CLUSTERED ([fb_departamento_id] ASC)
);


GO

