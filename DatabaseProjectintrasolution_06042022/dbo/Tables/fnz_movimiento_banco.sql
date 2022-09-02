CREATE TABLE [dbo].[fnz_movimiento_banco] (
    [fnz_movimiento_banco_id]     NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [fecha_movimiento]            DATETIME        NULL,
    [hora_movimiento]             VARCHAR (5)     NULL,
    [fecha_hora]                  VARCHAR (20)    NULL,
    [fnz_cuenta_banco_id]         NUMERIC (10)    NULL,
    [fnz_tipo_operacion_banco_id] NUMERIC (10)    NULL,
    [numero_documento]            VARCHAR (20)    NULL,
    [monto_movimiento]            NUMERIC (19, 2) NULL,
    [descripcion]                 VARCHAR (255)   NULL,
    [fb_empresa_id]               NUMERIC (10)    NULL,
    [flag_revisado]               INT             NULL,
    [revisado_por]                VARCHAR (255)   NULL,
    [estado]                      INT             NULL,
    [created]                     DATETIME        NULL,
    [created_by]                  NUMERIC (10)    NULL,
    [updated]                     DATETIME        NULL,
    [updated_by]                  NUMERIC (10)    NULL,
    [owner_id]                    NUMERIC (10)    NULL,
    [is_deleted]                  NUMERIC (1)     NULL,
    CONSTRAINT [PK_fnz_movimiento_banco] PRIMARY KEY CLUSTERED ([fnz_movimiento_banco_id] ASC)
);


GO

