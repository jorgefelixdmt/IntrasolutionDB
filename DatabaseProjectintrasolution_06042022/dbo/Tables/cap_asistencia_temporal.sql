CREATE TABLE [dbo].[cap_asistencia_temporal] (
    [cap_asistencia_temporal_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [fb_uea_pe_id]               NUMERIC (10)   NULL,
    [cap_curso_id]               NUMERIC (10)   NULL,
    [ruc_empresa]                VARCHAR (50)   NULL,
    [dni_empleado]               VARCHAR (50)   NULL,
    [nombre_completo]            VARCHAR (150)  NULL,
    [nota]                       NUMERIC (10)   NULL,
    [condicion]                  VARCHAR (50)   NULL,
    [num_row]                    NUMERIC (10)   NULL,
    [id_carga]                   NUMERIC (10)   NULL,
    [flag_error]                 NUMERIC (10)   NULL,
    [descripcion_error]          VARCHAR (2000) NULL,
    [fb_usuario_id]              NUMERIC (10)   NULL,
    [tipo_carga]                 NUMERIC (10)   NULL,
    [cap_tipo_resultado_id]      NUMERIC (10)   NULL,
    [flag_aprobado]              NUMERIC (10)   NULL
);


GO

