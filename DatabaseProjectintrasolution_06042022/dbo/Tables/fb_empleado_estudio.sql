CREATE TABLE [dbo].[fb_empleado_estudio] (
    [fb_empleado_estudio_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [centro_estudios]        VARCHAR (200) NULL,
    [especialidad]           VARCHAR (200) NULL,
    [grado]                  VARCHAR (200) NULL,
    [anno_inicio]            NUMERIC (10)  NULL,
    [anno_fin]               NUMERIC (10)  NULL,
    [ciudad]                 VARCHAR (200) NULL,
    [fb_pais_id]             NUMERIC (10)  NULL,
    [created]                DATETIME      NULL,
    [created_by]             NUMERIC (10)  NULL,
    [updated]                DATETIME      NULL,
    [updated_by]             NUMERIC (10)  NULL,
    [owner_id]               NUMERIC (10)  NULL,
    [is_deleted]             NUMERIC (1)   NULL,
    [fb_empleado_id]         NUMERIC (10)  NULL,
    CONSTRAINT [PK_fb_estudios] PRIMARY KEY CLUSTERED ([fb_empleado_estudio_id] ASC)
);


GO

