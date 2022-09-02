CREATE TABLE [dbo].[fnz_voucher] (
    [fnz_voucher_id]                NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [fecha]                         DATETIME        NULL,
    [numero_documento]              VARCHAR (50)    NULL,
    [monto]                         NUMERIC (15, 2) NULL,
    [descripcion]                   VARCHAR (MAX)   NULL,
    [fnz_movimiento_bancario_id]    NUMERIC (10)    NULL,
    [fb_empresa_cuenta_bancaria_id] NUMERIC (10)    NULL,
    [archivo]                       VARCHAR (200)   NULL,
    [fb_empresa_id]                 NCHAR (10)      NULL,
    [fnz_estado_voucher_id]         NCHAR (10)      NULL,
    [created]                       DATETIME        NULL,
    [created_by]                    NUMERIC (10)    NULL,
    [updated]                       DATETIME        NULL,
    [updated_by]                    NUMERIC (10)    NULL,
    [owner_id]                      NUMERIC (10)    NULL,
    [is_deleted]                    NUMERIC (1)     NULL,
    CONSTRAINT [PK_fnz_voucher] PRIMARY KEY CLUSTERED ([fnz_voucher_id] ASC)
);


GO

