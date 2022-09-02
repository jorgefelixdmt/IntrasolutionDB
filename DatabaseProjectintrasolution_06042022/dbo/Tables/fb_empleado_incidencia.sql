CREATE TABLE [dbo].[fb_empleado_incidencia] (
    [fb_empleado_incidencia_id]      NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [fecha]                          DATETIME      NULL,
    [hora]                           VARCHAR (50)  NULL,
    [fb_empleado_id]                 NUMERIC (10)  NULL,
    [fb_empleado_tipo_incidencia_id] NUMERIC (10)  NULL,
    [detalle]                        VARCHAR (MAX) NULL,
    [observacion_revision]           VARCHAR (MAX) NULL,
    [archivo]                        VARCHAR (200) NULL,
    [fb_empleado_revisor_id]         NUMERIC (10)  NULL,
    [created]                        DATETIME      NULL,
    [created_by]                     NUMERIC (10)  NULL,
    [updated]                        DATETIME      NULL,
    [updated_by]                     NUMERIC (10)  NULL,
    [owner_id]                       NUMERIC (10)  NULL,
    [is_deleted]                     NUMERIC (1)   NULL,
    CONSTRAINT [PK_fb_empleado_asistencia_1] PRIMARY KEY CLUSTERED ([fb_empleado_incidencia_id] ASC)
);


GO

