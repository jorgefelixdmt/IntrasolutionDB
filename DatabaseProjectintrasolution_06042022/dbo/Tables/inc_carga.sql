CREATE TABLE [dbo].[inc_carga] (
    [id_carga]      NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [descripcion]   NVARCHAR (1024) NULL,
    [fecha_hora]    DATETIME        NOT NULL,
    [fb_usuario_id] NUMERIC (10)    NULL
);


GO

