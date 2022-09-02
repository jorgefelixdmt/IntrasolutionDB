CREATE TABLE [dbo].[pry_registro_ingreso_salida] (
    [pry_registro_ingreso_salida_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [fecha]                          DATETIME      NULL,
    [dia_semana]                     VARCHAR (50)  NULL,
    [hora_ingreso]                   VARCHAR (50)  NULL,
    [hora_salida]                    VARCHAR (50)  NULL,
    [numero_horas]                   NUMERIC (10)  NULL,
    [ip_ingreso]                     VARCHAR (50)  NULL,
    [ip_salida]                      VARCHAR (50)  NULL,
    [revisado]                       VARCHAR (200) NULL,
    [revisado_por]                   VARCHAR (200) NULL,
    [created]                        DATETIME      NULL,
    [created_by]                     NUMERIC (10)  NULL,
    [updated]                        DATETIME      NULL,
    [updated_by]                     NUMERIC (10)  NULL,
    [owner_id]                       NUMERIC (10)  NULL,
    [is_deleted]                     NUMERIC (1)   NULL,
    [hora_inicio_refrigerio]         VARCHAR (10)  NULL,
    [hora_fin_refrigerio]            VARCHAR (10)  NULL,
    [flag_revision]                  NUMERIC (1)   NULL,
    [fecha_revision]                 DATETIME      NULL,
    [fb_empleado_id]                 NUMERIC (10)  NULL,
    [ubicacion]                      VARCHAR (400) NULL,
    [observacion]                    VARCHAR (MAX) NULL,
    CONSTRAINT [PK_pry_registro_ingreso_salida] PRIMARY KEY CLUSTERED ([pry_registro_ingreso_salida_id] ASC)
);


GO

