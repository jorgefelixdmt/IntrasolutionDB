CREATE TABLE [dbo].[fb_empleado_evaluacion] (
    [fb_empleado_evaluacion_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [fecha_evaluacion]          DATETIME      NULL,
    [titulo]                    VARCHAR (200) NULL,
    [autor]                     VARCHAR (200) NULL,
    [archivo]                   VARCHAR (200) NULL,
    [descripcion]               VARCHAR (400) NULL,
    [created]                   DATETIME      NULL,
    [created_by]                NUMERIC (10)  NULL,
    [updated]                   DATETIME      NULL,
    [updated_by]                NUMERIC (10)  NULL,
    [owner_id]                  NUMERIC (10)  NULL,
    [is_deleted]                NUMERIC (1)   NULL,
    [fb_empleado_id]            NUMERIC (10)  NULL,
    CONSTRAINT [PK_fb_evaluaciones] PRIMARY KEY CLUSTERED ([fb_empleado_evaluacion_id] ASC)
);


GO

