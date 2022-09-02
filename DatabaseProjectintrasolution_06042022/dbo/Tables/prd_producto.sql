CREATE TABLE [dbo].[prd_producto] (
    [prd_producto_id]             NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [codigo]                      VARCHAR (20)   NULL,
    [nombre]                      VARCHAR (100)  NULL,
    [descripcion]                 VARCHAR (2048) NULL,
    [estado]                      INT            NULL,
    [created]                     DATETIME       NULL,
    [created_by]                  NUMERIC (10)   NULL,
    [updated]                     DATETIME       NULL,
    [updated_by]                  NUMERIC (10)   NULL,
    [owner_id]                    NUMERIC (10)   NULL,
    [is_deleted]                  NUMERIC (1)    NULL,
    [fb_responsable_funcional_id] NUMERIC (10)   NULL,
    CONSTRAINT [PK_prd_producto] PRIMARY KEY CLUSTERED ([prd_producto_id] ASC)
);


GO

