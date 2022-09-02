CREATE TABLE [dbo].[fb_uea_pe] (
    [fb_uea_pe_id]                   NUMERIC (10)    IDENTITY (1, 1) NOT NULL,
    [fb_uea_pe_tipo_id]              NUMERIC (10)    NULL,
    [codigo]                         NVARCHAR (50)   NULL,
    [nombre]                         NVARCHAR (100)  NULL,
    [fb_ubigeo_id]                   NUMERIC (10)    NULL,
    [estado]                         NUMERIC (1)     NULL,
    [utm_norte]                      NUMERIC (20, 3) NULL,
    [utm_este]                       NUMERIC (20, 3) NULL,
    [utm_altitud]                    NUMERIC (20, 2) NULL,
    [utm_zona]                       NUMERIC (20, 2) NULL,
    [utm_datum]                      NVARCHAR (100)  NULL,
    [latitud]                        NUMERIC (20, 5) NULL,
    [longitud]                       NUMERIC (20, 5) NULL,
    [created]                        DATETIME        NULL,
    [created_by]                     NUMERIC (10)    NULL,
    [updated]                        DATETIME        NULL,
    [updated_by]                     NUMERIC (10)    NULL,
    [owner_id]                       NUMERIC (10)    NULL,
    [fb_actividad_id]                NUMERIC (10)    NULL,
    [fb_empresa_id]                  NUMERIC (10)    NULL,
    [compania]                       NVARCHAR (2)    NULL,
    [centro_costo]                   NVARCHAR (10)   NULL,
    [localidad]                      NVARCHAR (4)    NULL,
    [agi]                            VARCHAR (8)     NULL,
    [is_deleted]                     NUMERIC (1)     NULL,
    [email_gerente_ma]               VARCHAR (250)   NULL,
    [email_superintendente]          VARCHAR (250)   NULL,
    [email_gerente_sg]               VARCHAR (250)   NULL,
    [email_gerente_ca]               VARCHAR (250)   NULL,
    [humedo]                         NUMERIC (2)     NULL,
    [seco]                           NUMERIC (2)     NULL,
    [codigo_gobierno]                NVARCHAR (50)   NULL,
    [fb_tipo_explotacion_id]         NUMERIC (10)    NULL,
    [id_Carga]                       NUMERIC (10)    NULL,
    [domicilio]                      VARCHAR (200)   NULL,
    [email_responsable_salud]        VARCHAR (200)   NULL,
    [email_responsable_seguridad]    VARCHAR (200)   NULL,
    [fb_empleado_salud_id]           NUMERIC (10)    NULL,
    [fb_empleado_seguridad_id]       NUMERIC (10)    NULL,
    [fb_empleado_superintendente_id] NUMERIC (10)    NULL,
    CONSTRAINT [PK_fb_uea_pe] PRIMARY KEY CLUSTERED ([fb_uea_pe_id] ASC),
    CONSTRAINT [FK_UEA_EMPRESA] FOREIGN KEY ([fb_empresa_id]) REFERENCES [dbo].[fb_empresa] ([fb_empresa_id])
);


GO

