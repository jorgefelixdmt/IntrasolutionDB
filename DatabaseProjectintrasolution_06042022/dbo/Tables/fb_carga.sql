CREATE TABLE [dbo].[fb_carga] (
    [id_carga]      NUMERIC (10)    NOT NULL,
    [descripcion]   NVARCHAR (1024) NULL,
    [fecha_hora]    DATETIME        NOT NULL,
    [fb_usuario_id] NUMERIC (10)    NULL,
    [tipo_carga]    NUMERIC (10)    NULL,
    CONSTRAINT [PK_fb_carga] PRIMARY KEY CLUSTERED ([id_carga] ASC)
);


GO

