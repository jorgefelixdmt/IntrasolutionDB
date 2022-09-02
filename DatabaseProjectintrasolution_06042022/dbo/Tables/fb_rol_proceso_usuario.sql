CREATE TABLE [dbo].[fb_rol_proceso_usuario] (
    [fb_rol_proceso_usuario_id] NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [fb_rol_proceso_id]         NUMERIC (10)  NULL,
    [descripcion]               VARCHAR (MAX) NULL,
    [fb_empleado_id_titular]    NUMERIC (10)  NULL,
    [fb_empleado_id_alterno]    NUMERIC (10)  NULL,
    [cadena_email]              VARCHAR (MAX) NULL,
    [created]                   DATETIME      NULL,
    [created_by]                NUMERIC (10)  NULL,
    [updated]                   DATETIME      NULL,
    [updated_by]                NUMERIC (10)  NULL,
    [owner_id]                  NUMERIC (10)  NULL,
    [is_deleted]                NUMERIC (1)   NULL
);


GO

