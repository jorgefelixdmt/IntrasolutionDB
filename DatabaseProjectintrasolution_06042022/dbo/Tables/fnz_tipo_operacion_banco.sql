CREATE TABLE [dbo].[fnz_tipo_operacion_banco] (
    [fnz_tipo_operacion_banco_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [codigo]                      VARCHAR (50)   NULL,
    [nombre]                      VARCHAR (200)  NULL,
    [observaciones]               VARCHAR (1024) NULL,
    [signo]                       NUMERIC (10)   NULL,
    [flag_itf]                    NUMERIC (10)   NULL,
    [estado]                      NUMERIC (1)    NULL,
    [fb_empresa_id]               NUMERIC (10)   NULL,
    [created]                     DATETIME       NULL,
    [created_by]                  NUMERIC (10)   NULL,
    [updated]                     DATETIME       NULL,
    [updated_by]                  NUMERIC (10)   NULL,
    [owner_id]                    NUMERIC (10)   NULL,
    [is_deleted]                  NUMERIC (1)    NULL,
    CONSTRAINT [PK_fnz_tipo_operacion_banco] PRIMARY KEY CLUSTERED ([fnz_tipo_operacion_banco_id] ASC)
);


GO

