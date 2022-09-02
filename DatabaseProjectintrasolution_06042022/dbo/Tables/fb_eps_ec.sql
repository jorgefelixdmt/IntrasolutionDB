CREATE TABLE [dbo].[fb_eps_ec] (
    [fb_eps_ec_id]             NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [codigo]                   NVARCHAR (50)  NULL,
    [n_registro]               NVARCHAR (100) NULL,
    [fecha_vencimiento]        DATETIME       NULL,
    [autorizacion_municipal]   NVARCHAR (50)  NULL,
    [fb_ubigeo_id]             NUMERIC (10)   NULL,
    [urbanizacion]             NVARCHAR (100) NULL,
    [detalle]                  NVARCHAR (100) NULL,
    [numero_casa]              NVARCHAR (100) NULL,
    [ley_creacion]             NVARCHAR (50)  NULL,
    [creado]                   DATETIME       NULL,
    [creado_por]               NUMERIC (10)   NULL,
    [actualizado]              DATETIME       NULL,
    [actualizado_por]          NUMERIC (10)   NULL,
    [propietario_id]           NUMERIC (10)   NULL,
    [tipo]                     VARCHAR (5)    NULL,
    [razon_social]             NVARCHAR (400) NULL,
    [ruc]                      NVARCHAR (50)  NULL,
    [email_responsable_eps_ec] VARCHAR (250)  NULL,
    [id_carga]                 NUMERIC (10)   NULL,
    [created]                  DATETIME       NULL,
    [created_by]               NUMERIC (10)   NULL,
    [updated]                  DATETIME       NULL,
    [updated_by]               NUMERIC (10)   NULL,
    [owner_id]                 NUMERIC (1)    NULL,
    [is_deleted]               NUMERIC (1)    NULL,
    [estado]                   NUMERIC (1)    NULL,
    CONSTRAINT [PK_fb_eps_ec] PRIMARY KEY CLUSTERED ([fb_eps_ec_id] ASC)
);


GO

