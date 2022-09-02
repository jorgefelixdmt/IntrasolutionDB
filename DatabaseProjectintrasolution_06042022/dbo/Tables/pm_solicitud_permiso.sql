CREATE TABLE [dbo].[pm_solicitud_permiso] (
    [pm_solicitud_permiso_id]  NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [fb_empleado_id]           NUMERIC (10)  NULL,
    [pry_tipo_permiso_id]      NUMERIC (10)  NULL,
    [fecha_permiso]            DATETIME      NULL,
    [horas_permiso_solicitado] VARCHAR (50)  NULL,
    [motivo_permiso]           VARCHAR (MAX) NULL,
    [flag_aprobado]            NUMERIC (1)   NULL,
    [fecha_aprobado]           DATETIME      NULL,
    [aprobado_por]             VARCHAR (200) NULL,
    [observaciones]            VARCHAR (MAX) NULL,
    [horas_permiso_real]       VARCHAR (50)  NULL,
    [archivo_permiso_sustento] VARCHAR (200) NULL,
    [flag_revisado]            NUMERIC (1)   NULL,
    [fecha_revisado]           DATETIME      NULL,
    [revisado_por]             VARCHAR (200) NULL,
    [pry_estado_permiso_id]    NUMERIC (10)  NULL,
    [fecha_creacion]           DATETIME      NULL,
    [created]                  DATETIME      NULL,
    [created_by]               NUMERIC (10)  NULL,
    [updated]                  DATETIME      NULL,
    [updated_by]               NUMERIC (10)  NULL,
    [owner_id]                 NUMERIC (10)  NULL,
    [is_deleted]               NUMERIC (1)   NULL,
    CONSTRAINT [PK_pm_solicitud_permiso] PRIMARY KEY CLUSTERED ([pm_solicitud_permiso_id] ASC)
);


GO

