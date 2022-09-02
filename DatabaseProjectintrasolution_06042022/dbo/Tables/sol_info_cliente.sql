CREATE TABLE [dbo].[sol_info_cliente] (
    [sol_info_cliente_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [sol_solicitud_id]    NUMERIC (10)  NULL,
    [fb_cliente_id]       NUMERIC (10)  NULL,
    [pry_proyecto_id]     NUMERIC (10)  NULL,
    [fb_responsable_id]   NUMERIC (10)  NULL,
    [descripcion_info]    VARCHAR (MAX) NULL,
    [fecha_recepcion]     DATETIME      NULL,
    [fecha_devolucion]    DATETIME      NULL,
    [fecha_destruccion]   DATETIME      NULL,
    [evidencia]           VARCHAR (200) NULL,
    [estado]              NUMERIC (1)   NULL,
    [created]             DATETIME      NULL,
    [created_by]          NUMERIC (10)  NULL,
    [updated]             DATETIME      NULL,
    [updated_by]          NUMERIC (10)  NULL,
    [owner_id]            NUMERIC (10)  NULL,
    [is_deleted]          NUMERIC (1)   NULL,
    CONSTRAINT [sol_info_cliente_id] PRIMARY KEY CLUSTERED ([sol_info_cliente_id] ASC)
);


GO

