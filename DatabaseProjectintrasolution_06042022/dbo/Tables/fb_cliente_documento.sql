CREATE TABLE [dbo].[fb_cliente_documento] (
    [fb_cliente_documento_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [fb_cliente_id]           NUMERIC (10)  NULL,
    [fecha]                   DATETIME      NULL,
    [titulo]                  VARCHAR (200) NULL,
    [descripcion]             VARCHAR (MAX) NULL,
    [archivo]                 VARCHAR (200) NULL,
    [created]                 DATETIME      NULL,
    [created_by]              NUMERIC (10)  NULL,
    [updated]                 DATETIME      NULL,
    [updated_by]              NUMERIC (10)  NULL,
    [owner_id]                NUMERIC (10)  NULL,
    [is_deleted]              NUMERIC (1)   NULL,
    CONSTRAINT [PK_fb_cliente_documento] PRIMARY KEY CLUSTERED ([fb_cliente_documento_id] ASC)
);


GO

