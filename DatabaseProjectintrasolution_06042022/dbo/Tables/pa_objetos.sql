CREATE TABLE [dbo].[pa_objetos] (
    [pa_objetos_id]          NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [pa_pase_id]             NUMERIC (10)  NULL,
    [inc_incidencia_id]      NUMERIC (10)  NULL,
    [incidencia_jira_codigo] VARCHAR (200) NULL,
    [archivo]                VARCHAR (200) NULL,
    [pa_categoria_objeto_id] NUMERIC (10)  NULL,
    [pa_tipo_objeto_id]      NUMERIC (10)  NULL,
    [pa_tipo_cambio_id]      NUMERIC (10)  NULL,
    [nombre_objeto]          VARCHAR (200) NULL,
    [descripcion_objeto]     VARCHAR (MAX) NULL,
    [observaciones]          VARCHAR (MAX) NULL,
    [fb_empleado_autor_id]   NUMERIC (10)  NULL,
    [created]                DATETIME      NULL,
    [created_by]             NUMERIC (10)  NULL,
    [updated]                DATETIME      NULL,
    [updated_by]             NUMERIC (10)  NULL,
    [owner_id]               NUMERIC (10)  NULL,
    [is_deleted]             NUMERIC (1)   NULL,
    [fb_cliente_id]          NUMERIC (10)  NULL,
    [pry_proyecto_id]        NUMERIC (10)  NULL,
    [prd_producto_id]        NUMERIC (10)  NULL,
    [origen]                 VARCHAR (200) NULL,
    [codigo]                 VARCHAR (200) NULL,
    [fecha]                  DATETIME      NULL,
    [hora]                   VARCHAR (25)  NULL,
    [pa_entrega_objetos_id]  NUMERIC (10)  NULL,
    CONSTRAINT [PK_pa_objetos_id] PRIMARY KEY CLUSTERED ([pa_objetos_id] ASC)
);


GO

