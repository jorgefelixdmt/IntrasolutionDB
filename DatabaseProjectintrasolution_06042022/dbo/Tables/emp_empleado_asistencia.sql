CREATE TABLE [dbo].[emp_empleado_asistencia] (
    [emp_empleado_asistencia_id] NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [fb_empleado_id]             NUMERIC (10)    NULL,
    [tipo_asistencia]            VARCHAR (50)    NULL,
    [hora_ingreso]               DATETIME        NULL,
    [hora_salida]                DATETIME        NULL,
    [cantida_horas]              NUMERIC (10, 2) NULL,
    [ip_ingreso]                 VARCHAR (50)    NULL,
    [ip_salida]                  VARCHAR (50)    NULL,
    [observacion]                VARCHAR (400)   NULL,
    [created]                    DATETIME        NULL,
    [created_by]                 NUMERIC (10)    NULL,
    [updated]                    DATETIME        NULL,
    [updated_by]                 NUMERIC (10)    NULL,
    [owner_id]                   NUMERIC (10)    NULL,
    [is_deleted]                 NUMERIC (1)     NULL,
    CONSTRAINT [PK_fb_empleado_asistencia] PRIMARY KEY CLUSTERED ([emp_empleado_asistencia_id] ASC)
);


GO

