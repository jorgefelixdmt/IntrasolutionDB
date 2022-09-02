CREATE TABLE [dbo].[exa_datos_medico] (
    [exa_datos_medico_id]         NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [fecha_examen]                DATETIME        NULL,
    [g_rol_empresa_id]            NUMERIC (10)    NULL,
    [fb_empresa_especializada_id] NUMERIC (10)    NULL,
    [codigo_tributario]           VARCHAR (50)    NULL,
    [fb_uea_pe_id]                NUMERIC (10)    NULL,
    [fb_empleado_id]              NUMERIC (10)    NULL,
    [nombre_completo]             VARCHAR (200)   NULL,
    [documento_entidad]           VARCHAR (50)    NULL,
    [fb_cargo_id]                 NUMERIC (10)    NULL,
    [cargo_nombre]                VARCHAR (200)   NULL,
    [sexo]                        VARCHAR (5)     NULL,
    [fecha_nacimiento]            DATETIME        NULL,
    [edad]                        NUMERIC (10)    NULL,
    [talla]                       NUMERIC (10, 2) NULL,
    [peso]                        NUMERIC (10, 2) NULL,
    [imc]                         NUMERIC (10, 2) NULL,
    [exa_clasificacion_imc_id]    NUMERIC (10)    NULL,
    [created]                     DATETIME        NULL,
    [created_by]                  NUMERIC (10)    NULL,
    [updated]                     DATETIME        NULL,
    [updated_by]                  NUMERIC (10)    NULL,
    [owner_id]                    NUMERIC (10)    NULL,
    [is_deleted]                  NUMERIC (1)     NULL,
    CONSTRAINT [PK_exa_datos_medico] PRIMARY KEY CLUSTERED ([exa_datos_medico_id] ASC)
);


GO

