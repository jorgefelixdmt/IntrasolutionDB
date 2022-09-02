CREATE TABLE [dbo].[fb_empleado_experiencia_laboral] (
    [fb_empleado_experiencia_laboral_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [empresa]                            VARCHAR (200) NULL,
    [cargo]                              VARCHAR (200) NULL,
    [fecha_ingreso]                      DATETIME      NULL,
    [fecha_salida]                       DATETIME      NULL,
    [direccion]                          VARCHAR (200) NULL,
    [observacion]                        VARCHAR (400) NULL,
    [created]                            DATETIME      NULL,
    [created_by]                         NUMERIC (10)  NULL,
    [updated]                            DATETIME      NULL,
    [updated_by]                         NUMERIC (10)  NULL,
    [owner_id]                           NUMERIC (10)  NULL,
    [is_deleted]                         NUMERIC (1)   NULL,
    [fb_empleado_id]                     NUMERIC (10)  NULL,
    CONSTRAINT [PK_fb_experiencia_laboral] PRIMARY KEY CLUSTERED ([fb_empleado_experiencia_laboral_id] ASC)
);


GO

