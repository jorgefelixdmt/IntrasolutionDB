CREATE TABLE [dbo].[fnz_venta_documento] (
    [fnz_venta_documento_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [fnz_venta_id]           NUMERIC (10)   NULL,
    [titulo]                 VARCHAR (500)  NULL,
    [descripcion]            VARCHAR (MAX)  NULL,
    [fecha_documento]        DATETIME       NULL,
    [archivo]                VARCHAR (1024) NULL,
    [created]                DATETIME       NULL,
    [created_by]             NUMERIC (10)   NULL,
    [updated]                DATETIME       NULL,
    [updated_by]             NUMERIC (10)   NULL,
    [owner_id]               NUMERIC (10)   NULL,
    [is_deleted]             NUMERIC (1)    NULL,
    CONSTRAINT [PK_fnz_venta_documento] PRIMARY KEY CLUSTERED ([fnz_venta_documento_id] ASC)
);


GO

