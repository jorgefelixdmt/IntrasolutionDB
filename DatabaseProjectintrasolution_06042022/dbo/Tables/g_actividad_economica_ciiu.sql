CREATE TABLE [dbo].[g_actividad_economica_ciiu] (
    [g_actividad_economica_ciiu_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [clase_CIIU]                    NVARCHAR (50)  NULL,
    [descripcion_CIIU]              NVARCHAR (400) NULL,
    [g_ciiu_seccion_id]             NUMERIC (10)   NULL,
    [g_ciiu_division_id]            NUMERIC (10)   NULL,
    [g_ciiu_grupo_id]               NUMERIC (10)   NULL,
    [estado]                        NUMERIC (1)    NULL,
    [owner_id]                      NUMERIC (10)   NULL,
    [created]                       DATETIME       NULL,
    [created_by]                    NUMERIC (10)   NULL,
    [updated]                       DATETIME       NULL,
    [updated_by]                    NUMERIC (10)   NULL,
    [is_deleted]                    NUMERIC (1)    NULL,
    CONSTRAINT [PK_g_actividad_economica_ciiu] PRIMARY KEY CLUSTERED ([g_actividad_economica_ciiu_id] ASC)
);


GO

