CREATE TABLE [dbo].[cap_curso_asistencia] (
    [cap_curso_asistencia_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [cap_curso_id]            NUMERIC (10)  NULL,
    [fb_empleado_id]          NUMERIC (10)  NULL,
    [dni]                     VARCHAR (50)  NULL,
    [nombreCompleto]          VARCHAR (200) NULL,
    [fb_cargo_id]             NUMERIC (10)  NULL,
    [cargo_codigo]            VARCHAR (50)  NULL,
    [cargo_nombre]            VARCHAR (100) NULL,
    [fb_area_id]              NUMERIC (10)  NULL,
    [area_codigo]             VARCHAR (50)  NULL,
    [area_nombre]             VARCHAR (100) NULL,
    [cap_rol_capacitacion_id] NUMERIC (10)  NULL,
    [rol_capacitacion_codigo] VARCHAR (50)  NULL,
    [rol_capacitacion_nombre] VARCHAR (100) NULL,
    [fb_puesto_trabajo_id]    NUMERIC (10)  NULL,
    [puesto_trabajo_codigo]   VARCHAR (50)  NULL,
    [puesto_trabajo_nombre]   VARCHAR (100) NULL,
    [fecha_curso]             DATETIME      NULL,
    [archivo]                 VARCHAR (200) NULL,
    [nota]                    NUMERIC (10)  NULL,
    [cap_tipo_resultado_id]   NUMERIC (10)  NULL,
    [resultado_nombre]        VARCHAR (100) NULL,
    [resultado_flag]          NUMERIC (1)   NULL,
    [estado]                  NUMERIC (1)   NULL,
    [fb_uea_pe_id]            NUMERIC (10)  NULL,
    [created]                 DATETIME      NULL,
    [created_by]              NUMERIC (10)  NULL,
    [updated]                 DATETIME      NULL,
    [updated_by]              NUMERIC (10)  NULL,
    [owner_id]                NUMERIC (10)  NULL,
    [is_deleted]              NUMERIC (1)   NULL,
    [id_carga]                NUMERIC (10)  NULL,
    CONSTRAINT [cap_curso_asistencia_id] PRIMARY KEY CLUSTERED ([cap_curso_asistencia_id] ASC)
);


GO

