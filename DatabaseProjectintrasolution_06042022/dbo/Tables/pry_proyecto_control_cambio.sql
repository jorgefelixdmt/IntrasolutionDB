CREATE TABLE [dbo].[pry_proyecto_control_cambio] (
    [pry_proyecto_control_cambio_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [pry_proyecto_modulo_id]         NUMERIC (10)   NULL,
    [titulo]                         VARCHAR (512)  NULL,
    [descripcion]                    VARCHAR (1024) NULL,
    [solicitante]                    VARCHAR (512)  NULL,
    [impacto_dias_hombres]           NUMERIC (10)   NULL,
    [pry_estado_control_cambio_id]   NUMERIC (10)   NULL,
    [estado]                         NUMERIC (1)    NULL,
    [created]                        DATETIME       NULL,
    [created_by]                     NUMERIC (10)   NULL,
    [updated]                        DATETIME       NULL,
    [updated_by]                     NUMERIC (10)   NULL,
    [owner_id]                       NUMERIC (10)   NULL,
    [is_deleted]                     NUMERIC (1)    NULL,
    CONSTRAINT [PK_pry_proyecto_control_cambio] PRIMARY KEY CLUSTERED ([pry_proyecto_control_cambio_id] ASC)
);


GO

