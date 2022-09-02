CREATE TABLE [dbo].[cap_curso_temporal] (
    [cap_curso_temporal_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [fb_uea_pe_id]          NUMERIC (10)   NULL,
    [codigo]                VARCHAR (50)   NULL,
    [nombre]                VARCHAR (100)  NULL,
    [institucion]           VARCHAR (100)  NULL,
    [expositor]             VARCHAR (200)  NULL,
    [fecha_inicio]          VARCHAR (10)   NULL,
    [fecha_final]           VARCHAR (10)   NULL,
    [puntaje_curso]         NUMERIC (10)   NULL,
    [puntaje_aprobatorio]   NUMERIC (10)   NULL,
    [horas_curso]           NUMERIC (10)   NULL,
    [activo]                VARCHAR (50)   NULL,
    [codigo_uea]            VARCHAR (50)   NULL,
    [estado_curso]          VARCHAR (50)   NULL,
    [tipo_curso]            VARCHAR (50)   NULL,
    [fb_uea_pe_id_curso]    NUMERIC (10)   NULL,
    [cap_curso_estado_id]   NUMERIC (10)   NULL,
    [activo_id]             NUMERIC (1)    NULL,
    [num_row]               NUMERIC (10)   NULL,
    [id_carga]              NUMERIC (10)   NULL,
    [flag_error]            NUMERIC (10)   NULL,
    [descripcion_error]     VARCHAR (2000) NULL,
    [fb_usuario_id]         NUMERIC (10)   NULL
);


GO

