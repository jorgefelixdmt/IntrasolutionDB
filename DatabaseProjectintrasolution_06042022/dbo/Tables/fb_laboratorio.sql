CREATE TABLE [dbo].[fb_laboratorio] (
    [fb_laboratorio_id]             NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [codigo]                        NVARCHAR (50)  NULL,
    [representante_legal]           NVARCHAR (100) NULL,
    [estado]                        NUMERIC (1)    NULL,
    [direccion]                     NVARCHAR (200) NULL,
    [telefono_1]                    NVARCHAR (50)  NULL,
    [telefono_2]                    NVARCHAR (50)  NULL,
    [movil]                         NVARCHAR (20)  NULL,
    [fax]                           NVARCHAR (20)  NULL,
    [email]                         NVARCHAR (100) NULL,
    [url]                           NVARCHAR (50)  NULL,
    [fb_laboratorio_tipo_id]        NUMERIC (10)   NULL,
    [fb_ubigeo_id]                  NUMERIC (10)   NULL,
    [razon_social]                  NVARCHAR (500) NULL,
    [creado]                        DATETIME       NULL,
    [creado_por]                    NUMERIC (10)   NULL,
    [actualizado]                   DATETIME       NULL,
    [actualizado_por]               NUMERIC (10)   NULL,
    [propietario_id]                NUMERIC (10)   NULL,
    [ruc]                           NVARCHAR (20)  NULL,
    [nro_resolucion]                NVARCHAR (25)  NULL,
    [fecha_inicio]                  DATETIME       NULL,
    [fecha_fin]                     DATETIME       NULL,
    [id_laboratorio_bv]             INT            NULL,
    [email_responsable_laboratorio] VARCHAR (250)  NULL,
    [id_carga]                      NUMERIC (10)   NULL,
    [created]                       DATETIME       NULL,
    [created_by]                    NUMERIC (10)   NULL,
    [updated]                       DATETIME       NULL,
    [updated_by]                    NUMERIC (10)   NULL,
    [owner_id]                      NUMERIC (1)    NULL,
    [is_deleted]                    NUMERIC (1)    NULL,
    CONSTRAINT [PK_fb_laboratorio] PRIMARY KEY CLUSTERED ([fb_laboratorio_id] ASC)
);


GO

