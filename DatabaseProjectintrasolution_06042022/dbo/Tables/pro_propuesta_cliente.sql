CREATE TABLE [dbo].[pro_propuesta_cliente] (
    [pro_propuesta_cliente_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                   VARCHAR (50)  NULL,
    [razon_social]             VARCHAR (200) NULL,
    [ruc]                      VARCHAR (11)  NULL,
    [direccion]                VARCHAR (200) NULL,
    [telefono]                 VARCHAR (50)  NULL,
    [estado]                   NUMERIC (1)   NULL,
    [created]                  DATETIME      NULL,
    [created_by]               NUMERIC (10)  NULL,
    [updated]                  DATETIME      NULL,
    [updated_by]               NUMERIC (10)  NULL,
    [owner_id]                 NUMERIC (10)  NULL,
    [is_deleted]               NUMERIC (1)   NULL,
    CONSTRAINT [PK_pro_cliente] PRIMARY KEY CLUSTERED ([pro_propuesta_cliente_id] ASC)
);


GO

