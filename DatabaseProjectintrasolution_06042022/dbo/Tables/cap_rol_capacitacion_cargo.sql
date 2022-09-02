CREATE TABLE [dbo].[cap_rol_capacitacion_cargo] (
    [cap_rol_capacitacion_cargo_id] NUMERIC (10) IDENTITY (1, 1) NOT NULL,
    [cap_rol_capacitacion_id]       NUMERIC (10) NULL,
    [fb_cargo_id]                   NUMERIC (10) NULL,
    [estado]                        NUMERIC (1)  NULL,
    [created]                       DATETIME     NULL,
    [created_by]                    NUMERIC (10) NULL,
    [updated]                       DATETIME     NULL,
    [updated_by]                    NUMERIC (10) NULL,
    [owner_id]                      NUMERIC (10) NULL,
    [is_deleted]                    NUMERIC (1)  NULL,
    [id_Carga]                      NUMERIC (10) NULL,
    CONSTRAINT [pk_cap_rol_capacitacion_cargo] PRIMARY KEY NONCLUSTERED ([cap_rol_capacitacion_cargo_id] ASC) WITH (ALLOW_PAGE_LOCKS = OFF, ALLOW_ROW_LOCKS = OFF)
);


GO

