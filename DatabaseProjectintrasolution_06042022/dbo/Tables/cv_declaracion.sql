CREATE TABLE [dbo].[cv_declaracion] (
    [cv_declaracion_id]           NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [g_rol_empresa_id]            NUMERIC (10)  NULL,
    [fb_empresa_especializada_id] NUMERIC (10)  NULL,
    [codigo_tributario]           VARCHAR (50)  NULL,
    [fb_uea_pe_id]                NUMERIC (10)  NULL,
    [fb_empleado_id]              NUMERIC (10)  NULL,
    [nombre_completo]             VARCHAR (200) NULL,
    [tipo_documento]              VARCHAR (50)  NULL,
    [documento_entidad]           VARCHAR (50)  NULL,
    [nacionalidad]                VARCHAR (50)  NULL,
    [email]                       VARCHAR (50)  NULL,
    [celular]                     VARCHAR (50)  NULL,
    [persona_contacto]            VARCHAR (50)  NULL,
    [celular_contacto]            VARCHAR (50)  NULL,
    [domicilio]                   VARCHAR (50)  NULL,
    [fb_ubigeo_id]                NUMERIC (10)  NULL,
    [sexo]                        VARCHAR (5)   NULL,
    [edad]                        NUMERIC (10)  NULL,
    [fecha_registro]              DATETIME      NULL,
    [created]                     DATETIME      NULL,
    [created_by]                  NUMERIC (10)  NULL,
    [updated]                     DATETIME      NULL,
    [updated_by]                  NUMERIC (10)  NULL,
    [owner_id]                    NUMERIC (10)  NULL,
    [is_deleted]                  NUMERIC (1)   NULL,
    [fb_pais_id]                  NUMERIC (10)  NULL,
    [cv_entorno_id]               NUMERIC (10)  NULL,
    [contacto_persona_covid]      VARCHAR (10)  NULL,
    [viajado_fuera_pais]          VARCHAR (10)  NULL,
    [fecha_retorno_viaje]         DATETIME      NULL,
    CONSTRAINT [PK_cv_declaracion] PRIMARY KEY CLUSTERED ([cv_declaracion_id] ASC)
);


GO

