CREATE TABLE [dbo].[fb_empresa_cuenta_bancaria] (
    [fb_empresa_cuenta_bancaria_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [fb_empresa_id]                 NUMERIC (10)  NULL,
    [fb_banco_id]                   NUMERIC (10)  NULL,
    [moneda]                        VARCHAR (50)  NULL,
    [fb_tipo_cuenta_id]             NUMERIC (10)  NULL,
    [cuenta]                        VARCHAR (200) NULL,
    [cuenta_bancaria]               VARCHAR (200) NULL,
    [swift]                         VARCHAR (200) NULL,
    [archivo]                       VARCHAR (200) NULL,
    [created]                       DATETIME      NULL,
    [created_by]                    NUMERIC (10)  NULL,
    [updated]                       DATETIME      NULL,
    [updated_by]                    NUMERIC (10)  NULL,
    [owner_id]                      NUMERIC (10)  NULL,
    [is_deleted]                    NUMERIC (1)   NULL,
    CONSTRAINT [PK_fb_empresa_cuenta_bancaria] PRIMARY KEY CLUSTERED ([fb_empresa_cuenta_bancaria_id] ASC)
);


GO

