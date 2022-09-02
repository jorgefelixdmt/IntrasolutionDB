CREATE TABLE [dbo].[fnz_cuenta_banco] (
    [fnz_cuenta_banco_id]         NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [fnz_banco_id]                NUMERIC (10)  NULL,
    [fb_moneda_id]                NUMERIC (10)  NULL,
    [codigo_cuenta]               VARCHAR (30)  NULL,
    [codigo_cuenta_interbancaria] VARCHAR (30)  NULL,
    [codigo]                      VARCHAR (30)  NULL,
    [nombre]                      VARCHAR (100) NULL,
    [fb_empresa_id]               NUMERIC (10)  NULL,
    [estado]                      INT           NULL,
    [created]                     DATETIME      NULL,
    [created_by]                  NUMERIC (10)  NULL,
    [updated]                     DATETIME      NULL,
    [updated_by]                  NUMERIC (10)  NULL,
    [owner_id]                    NUMERIC (10)  NULL,
    [is_deleted]                  NUMERIC (1)   NULL,
    CONSTRAINT [PK_fnz_cuenta_banco] PRIMARY KEY CLUSTERED ([fnz_cuenta_banco_id] ASC)
);


GO

