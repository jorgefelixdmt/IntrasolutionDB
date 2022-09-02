CREATE TABLE [dbo].[fb_empleado_curso] (
    [fb_empleado_curso_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [centro_estudios]      VARCHAR (200) NULL,
    [especialidad]         VARCHAR (200) NULL,
    [grado]                VARCHAR (200) NULL,
    [fecha_inicio]         DATETIME      NULL,
    [fecha_fin]            DATETIME      NULL,
    [ciudad]               VARCHAR (200) NULL,
    [fb_pais_id]           NUMERIC (10)  NULL,
    [created]              DATETIME      NULL,
    [created_by]           NUMERIC (10)  NULL,
    [updated]              DATETIME      NULL,
    [updated_by]           NUMERIC (10)  NULL,
    [owner_id]             NUMERIC (10)  NULL,
    [is_deleted]           NUMERIC (1)   NULL,
    [fb_empleado_id]       NUMERIC (10)  NULL,
    CONSTRAINT [PK_fb_cursos] PRIMARY KEY CLUSTERED ([fb_empleado_curso_id] ASC)
);


GO

