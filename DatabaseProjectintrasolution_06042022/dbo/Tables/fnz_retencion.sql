CREATE TABLE [dbo].[fnz_retencion] (
    [fnz_retencion_id]              NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [periodo]                       VARCHAR (50)    NULL,
    [periodo_contable]              VARCHAR (50)    NULL,
    [fnz_compra_id]                 NUMERIC (10)    NULL,
    [fecha_factura]                 DATETIME        NULL,
    [numero_factura]                VARCHAR (50)    NULL,
    [pry_proyecto_id]               NUMERIC (10)    NULL,
    [fecha_tipo_cambio]             DATETIME        NULL,
    [monto_tipo_cambio]             NUMERIC (15, 2) NULL,
    [monto_soles]                   NUMERIC (15, 2) NULL,
    [fb_empresa_cuenta_bancaria_id] NUMERIC (10)    NULL,
    [fnz_movimiento_bancario_id]    NUMERIC (10)    NULL,
    [fnz_voucher_id]                NUMERIC (10)    NULL,
    [fb_empresa_id]                 NUMERIC (10)    NULL,
    [fnz_estado_retencion_id]       NUMERIC (10)    NULL,
    [created]                       DATETIME        NULL,
    [created_by]                    NUMERIC (10)    NULL,
    [updated]                       DATETIME        NULL,
    [updated_by]                    NUMERIC (10)    NULL,
    [owner_id]                      NUMERIC (10)    NULL,
    [is_deleted]                    NUMERIC (1)     NULL,
    CONSTRAINT [PK_fnz_retencion] PRIMARY KEY CLUSTERED ([fnz_retencion_id] ASC)
);


GO

