CREATE TABLE [dbo].[cap_rol_capacitacion_puesto_trabajo] (
    [cap_rol_capacitacion_puesto_trabajo_id] NUMERIC (10) IDENTITY (1, 1) NOT NULL,
    [cap_rol_capacitacion_id]                NUMERIC (10) NULL,
    [fb_puesto_trabajo_id]                   NUMERIC (10) NULL,
    [estado]                                 NUMERIC (1)  NULL,
    [created]                                DATETIME     NULL,
    [created_by]                             NUMERIC (10) NULL,
    [updated]                                DATETIME     NULL,
    [updated_by]                             NUMERIC (10) NULL,
    [owner_id]                               NUMERIC (10) NULL,
    [is_deleted]                             NUMERIC (1)  NULL,
    [id_carga]                               NUMERIC (10) NULL,
    CONSTRAINT [cap_rol_capacitacion_puesto_trabajo_id] PRIMARY KEY CLUSTERED ([cap_rol_capacitacion_puesto_trabajo_id] ASC)
);


GO

