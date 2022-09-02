CREATE TABLE [dbo].[inc_informe_final_equipo] (
    [inc_informe_final_equipo_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [inc_informe_final_id]        NUMERIC (10)  NULL,
    [g_rol_empresa_id]            NUMERIC (10)  NULL,
    [tipo_empresa]                VARCHAR (1)   NULL,
    [fb_empleado_id]              NUMERIC (10)  NULL,
    [numero_documento]            VARCHAR (50)  NULL,
    [nombre_apellido]             VARCHAR (200) NULL,
    [fb_cargo_id]                 NUMERIC (10)  NULL,
    [cargo_nombre]                VARCHAR (100) NULL,
    [inc_equipo_rol_id]           NUMERIC (10)  NULL,
    [rol_nombre]                  VARCHAR (100) NULL,
    [fb_empresa_id]               NUMERIC (10)  NULL,
    [created]                     DATETIME      NULL,
    [created_by]                  NUMERIC (10)  NULL,
    [updated]                     DATETIME      NULL,
    [updated_by]                  NUMERIC (10)  NULL,
    [owner_id]                    NUMERIC (10)  NULL,
    [is_deleted]                  NUMERIC (1)   NULL,
    CONSTRAINT [PK_inc_informe_final_equipo] PRIMARY KEY CLUSTERED ([inc_informe_final_equipo_id] ASC)
);


GO

