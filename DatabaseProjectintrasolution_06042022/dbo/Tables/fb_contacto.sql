CREATE TABLE [dbo].[fb_contacto] (
    [fb_contacto_id]              NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [nombres]                     VARCHAR (200) NULL,
    [apellidos]                   VARCHAR (200) NULL,
    [fb_tipo_origen_id]           NUMERIC (10)  NULL,
    [fb_empresa_especializada_id] NUMERIC (10)  NULL,
    [fb_cliente_id]               NUMERIC (10)  NULL,
    [origen_id]                   NUMERIC (10)  NULL,
    [nombre_empresa]              VARCHAR (200) NULL,
    [cargo]                       VARCHAR (200) NULL,
    [telefono]                    VARCHAR (200) NULL,
    [celular]                     VARCHAR (200) NULL,
    [celular_personal]            VARCHAR (200) NULL,
    [email_empresa]               VARCHAR (200) NULL,
    [email_personal]              VARCHAR (200) NULL,
    [observaciones]               VARCHAR (MAX) NULL,
    [fb_pais_id]                  NUMERIC (10)  NULL,
    [nivel_contacto]              VARCHAR (50)  NULL,
    [fb_uea_pe_id]                NUMERIC (10)  NULL,
    [created]                     DATETIME      NULL,
    [created_by]                  NUMERIC (10)  NULL,
    [updated]                     DATETIME      NULL,
    [updated_by]                  NUMERIC (10)  NULL,
    [owner_id]                    NUMERIC (10)  NULL,
    [is_deleted]                  NUMERIC (1)   NULL,
    [fb_empresa_id]               NUMERIC (10)  NULL,
    CONSTRAINT [PK_fb_contacto] PRIMARY KEY CLUSTERED ([fb_contacto_id] ASC)
);


GO

