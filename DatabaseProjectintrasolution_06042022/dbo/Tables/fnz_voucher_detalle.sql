CREATE TABLE [dbo].[fnz_voucher_detalle] (
    [fnz_voucher_detalle_id]        NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [fnz_voucher_id]                NUMERIC (10)    NULL,
    [monto]                         NUMERIC (19, 4) NULL,
    [descripcion]                   VARCHAR (MAX)   NULL,
    [fnz_compra_id]                 NUMERIC (10)    NULL,
    [fb_empresa_cuenta_bancaria_id] NUMERIC (10)    NULL,
    [pry_proyecto_id]               NUMERIC (10)    NULL,
    [archivo]                       VARCHAR (200)   NULL,
    [created]                       DATETIME        NULL,
    [created_by]                    NUMERIC (10)    NULL,
    [updated]                       DATETIME        NULL,
    [updated_by]                    NUMERIC (10)    NULL,
    [owner_id]                      NUMERIC (10)    NULL,
    [is_deleted]                    NUMERIC (1)     NULL,
    CONSTRAINT [PK_fnz_voucher_detalle] PRIMARY KEY CLUSTERED ([fnz_voucher_detalle_id] ASC)
);


GO

