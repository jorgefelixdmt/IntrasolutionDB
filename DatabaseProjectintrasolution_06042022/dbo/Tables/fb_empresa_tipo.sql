CREATE TABLE [dbo].[fb_empresa_tipo] (
    [fb_empresa_tipo_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [codigo]             NVARCHAR (50)  NULL,
    [descripcion]        NVARCHAR (200) NULL,
    [created]            DATETIME       NULL,
    [created_by]         NUMERIC (10)   NULL,
    [updated]            DATETIME       NULL,
    [updated_by]         NUMERIC (10)   NULL,
    [owner_id]           NUMERIC (10)   NULL,
    [is_deleted]         NUMERIC (1)    NULL,
    CONSTRAINT [PK_fb_empresa_tipo] PRIMARY KEY CLUSTERED ([fb_empresa_tipo_id] ASC)
);


GO

