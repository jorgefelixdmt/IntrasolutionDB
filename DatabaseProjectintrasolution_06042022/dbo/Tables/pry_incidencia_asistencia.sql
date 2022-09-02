CREATE TABLE [dbo].[pry_incidencia_asistencia] (
    [pry_incidencia_asistencia_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [registrado_por]               VARCHAR (512) NULL,
    [fecha]                        DATETIME      NULL,
    [hora]                         VARCHAR (10)  NULL,
    [pry_tipo_incidencia_id]       NUMERIC (10)  NULL,
    [fb_empleado_id]               NUMERIC (10)  NULL,
    [descripcion]                  VARCHAR (512) NULL,
    [sustento]                     VARCHAR (512) NULL,
    [created]                      DATETIME      NULL,
    [created_by]                   NUMERIC (10)  NULL,
    [updated]                      DATETIME      NULL,
    [updated_by]                   NUMERIC (10)  NULL,
    [owner_id]                     NUMERIC (10)  NULL,
    [is_deleted]                   NUMERIC (1)   NULL,
    CONSTRAINT [PK_pry_incidencia_asistencia] PRIMARY KEY CLUSTERED ([pry_incidencia_asistencia_id] ASC)
);


GO

