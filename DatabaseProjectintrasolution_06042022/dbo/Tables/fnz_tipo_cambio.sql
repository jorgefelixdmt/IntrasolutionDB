CREATE TABLE [dbo].[fnz_tipo_cambio] (
    [fnz_tipo_cambio_id]       NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [fecha_tipo_cambio]        DATETIME        NULL,
    [monto_tipo_cambio_compra] NUMERIC (19, 4) NULL,
    [monto_tipo_cambio_venta]  NUMERIC (19, 4) NULL,
    [moneda]                   VARCHAR (10)    NULL,
    [fb_pais_id]               NUMERIC (10)    NULL,
    [estado]                   INT             NULL,
    [created]                  DATETIME        NULL,
    [created_by]               NUMERIC (10)    NULL,
    [updated]                  DATETIME        NULL,
    [updated_by]               NUMERIC (10)    NULL,
    [owner_id]                 NUMERIC (10)    NULL,
    [is_deleted]               NUMERIC (1)     NULL,
    CONSTRAINT [PK_fnz_tipo_cambio] PRIMARY KEY CLUSTERED ([fnz_tipo_cambio_id] ASC)
);


GO

