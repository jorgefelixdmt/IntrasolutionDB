CREATE TABLE [dbo].[emp_empleado_incidencia] (
    [emp_empleado_incidencia_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [fb_empleado_id]             NUMERIC (10)  NULL,
    [categoria_incidencia]       INT           NULL,
    [emp_tipo_incidencia_id]     NUMERIC (10)  NULL,
    [fecha_incidencia]           DATETIME      NULL,
    [descripción]                VARCHAR (255) NULL,
    [archivo_incidencia]         VARCHAR (255) NULL,
    [observaciones]              VARCHAR (255) NULL,
    [flag_verificación]          INT           NULL,
    [fecha_verificacion]         DATETIME      NULL,
    [verificado_por]             VARCHAR (255) NULL,
    [emp_estado_incidencia_id]   NUMERIC (10)  NULL,
    [created]                    DATETIME      NULL,
    [created_by]                 NUMERIC (10)  NULL,
    [updated]                    DATETIME      NULL,
    [updated_by]                 NUMERIC (10)  NULL,
    [owner_id]                   NUMERIC (10)  NULL,
    [is_deleted]                 NUMERIC (1)   NULL,
    CONSTRAINT [PK_emp_empleado_incidencia] PRIMARY KEY CLUSTERED ([emp_empleado_incidencia_id] ASC)
);


GO

