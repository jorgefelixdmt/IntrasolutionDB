CREATE TABLE [dbo].[emp_empleado_permiso] (
    [emp_empleado_permiso_id]  NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [fb_empleado_id]           NUMERIC (10)    NULL,
    [emp_tipo_permiso_id]      NUMERIC (10)    NULL,
    [fecha_permiso]            DATETIME        NULL,
    [horas_permiso_solicitado] NUMERIC (10, 2) NULL,
    [motivo_permiso]           VARCHAR (255)   NULL,
    [archivo_permiso_sustento] VARCHAR (255)   NULL,
    [horas_permiso_real]       NUMERIC (10, 2) NULL,
    [observaciones]            VARCHAR (255)   NULL,
    [flag_aprobacion]          INT             NULL,
    [fecha_aprobacion]         DATETIME        NULL,
    [aprobado_por]             VARCHAR (255)   NULL,
    [flag_verificación]        INT             NULL,
    [fecha_verificacion]       DATETIME        NULL,
    [verificado_por]           VARCHAR (255)   NULL,
    [emp_estado_permiso_id]    NUMERIC (10)    NULL,
    [created]                  DATETIME        NULL,
    [created_by]               NUMERIC (10)    NULL,
    [updated]                  DATETIME        NULL,
    [updated_by]               NUMERIC (10)    NULL,
    [owner_id]                 NUMERIC (10)    NULL,
    [is_deleted]               NUMERIC (1)     NULL,
    CONSTRAINT [PK_emp_empleado_permiso] PRIMARY KEY CLUSTERED ([emp_empleado_permiso_id] ASC)
);


GO

