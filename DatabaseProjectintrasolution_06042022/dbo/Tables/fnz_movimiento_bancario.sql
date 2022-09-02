CREATE TABLE [dbo].[fnz_movimiento_bancario] (
    [fnz_movimiento_bancario_id]        NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [fecha_documento]                   DATETIME        NULL,
    [fecha_valor]                       DATETIME        NULL,
    [hora]                              VARCHAR (50)    NULL,
    [numero_documento]                  VARCHAR (50)    NULL,
    [monto]                             NUMERIC (10, 2) NULL,
    [descripcion]                       VARCHAR (MAX)   NULL,
    [fnz_tipo_operacion_banco_id]       NUMERIC (10)    NULL,
    [fnz_compra_id]                     NUMERIC (10)    NULL,
    [fb_empresa_cuenta_bancaria_id]     NUMERIC (10)    NULL,
    [pry_proyecto_id]                   NUMERIC (10)    NULL,
    [archivo]                           VARCHAR (200)   NULL,
    [fnz_voucher_id]                    NUMERIC (10)    NULL,
    [fb_empresa_id]                     NUMERIC (10)    NULL,
    [fnz_estado_movimiento_bancario_id] NUMERIC (10)    NULL,
    [created]                           DATETIME        NULL,
    [created_by]                        NUMERIC (10)    NULL,
    [updated]                           DATETIME        NULL,
    [updated_by]                        NUMERIC (10)    NULL,
    [owner_id]                          NUMERIC (10)    NULL,
    [is_deleted]                        NUMERIC (1)     NULL,
    CONSTRAINT [PK_fnz_movimiento_bancario] PRIMARY KEY CLUSTERED ([fnz_movimiento_bancario_id] ASC)
);


GO

