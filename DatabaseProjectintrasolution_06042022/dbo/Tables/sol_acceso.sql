CREATE TABLE [dbo].[sol_acceso] (
    [sol_acceso_id]      NUMERIC (10) IDENTITY (1, 1) NOT NULL,
    [sol_solicitud_id]   NUMERIC (10) NULL,
    [fb_cliente_id]      NUMERIC (10) NULL,
    [pry_proyecto_id]    NUMERIC (10) NULL,
    [fb_empleado_id]     NUMERIC (10) NULL,
    [sol_instalacion_id] NUMERIC (10) NULL,
    [sol_tipo_acceso_id] NUMERIC (10) NULL,
    [estado]             NUMERIC (1)  NULL,
    [created]            DATETIME     NULL,
    [created_by]         NUMERIC (10) NULL,
    [updated]            DATETIME     NULL,
    [updated_by]         NUMERIC (10) NULL,
    [owner_id]           NUMERIC (10) NULL,
    [is_deleted]         NUMERIC (1)  NULL,
    CONSTRAINT [PK_sol_acceso_id] PRIMARY KEY CLUSTERED ([sol_acceso_id] ASC)
);


GO

