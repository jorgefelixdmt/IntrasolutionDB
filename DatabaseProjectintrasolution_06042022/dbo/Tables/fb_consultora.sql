CREATE TABLE [dbo].[fb_consultora] (
    [fb_consultora_id]    NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]              VARCHAR (50)  NULL,
    [razon_social]        VARCHAR (100) NULL,
    [ruc]                 VARCHAR (50)  NULL,
    [representante_legal] VARCHAR (50)  NULL,
    [direccion]           VARCHAR (100) NULL,
    [telefono_1]          VARCHAR (50)  NULL,
    [telefono_2]          VARCHAR (50)  NULL,
    [movil]               VARCHAR (50)  NULL,
    [fax]                 VARCHAR (50)  NULL,
    [email]               VARCHAR (100) NULL,
    [url]                 VARCHAR (100) NULL,
    [fb_ubigeo_id]        NUMERIC (10)  NULL,
    [id_Carga]            NUMERIC (10)  NULL,
    [estado]              NUMERIC (1)   NULL,
    [creado]              DATETIME      NULL,
    [creado_por]          NUMERIC (10)  NULL,
    [actualizado]         DATETIME      NULL,
    [actualizado_por]     NUMERIC (10)  NULL,
    [propietario_id]      NUMERIC (10)  NULL,
    [created]             DATETIME      NULL,
    [created_by]          NUMERIC (10)  NULL,
    [updated]             DATETIME      NULL,
    [updated_by]          NUMERIC (10)  NULL,
    [owner_id]            NUMERIC (1)   NULL,
    [is_deleted]          NUMERIC (1)   NULL,
    CONSTRAINT [PK_fb_consultora] PRIMARY KEY CLUSTERED ([fb_consultora_id] ASC)
);


GO

