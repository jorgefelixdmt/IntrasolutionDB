CREATE TABLE [dbo].[prd_producto_version] (
    [prd_producto_version_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [prd_producto_id]         NUMERIC (10)   NULL,
    [fecha_version]           DATETIME       NULL,
    [codigo_version_war]      VARCHAR (50)   NULL,
    [codigo_version_bd]       VARCHAR (50)   NULL,
    [descripcion]             VARCHAR (2048) NULL,
    [created]                 DATETIME       NULL,
    [created_by]              NUMERIC (10)   NULL,
    [updated]                 DATETIME       NULL,
    [updated_by]              NUMERIC (10)   NULL,
    [owner_id]                NUMERIC (10)   NULL,
    [is_deleted]              NUMERIC (1)    NULL,
    CONSTRAINT [PK_prd_producto_version] PRIMARY KEY CLUSTERED ([prd_producto_version_id] ASC)
);


GO

