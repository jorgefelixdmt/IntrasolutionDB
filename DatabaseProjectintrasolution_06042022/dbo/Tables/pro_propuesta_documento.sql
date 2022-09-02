CREATE TABLE [dbo].[pro_propuesta_documento] (
    [pro_propuesta_documento_id] NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [pro_propuesta_id]           NUMERIC (10)   NULL,
    [fecha_documento]            DATETIME       NULL,
    [pro_origen_documento_id]    NUMERIC (10)   NULL,
    [pro_tipo_documento_id]      NUMERIC (10)   NULL,
    [observaciones]              VARCHAR (4096) NULL,
    [archivo_propuesta_version]  VARCHAR (1024) NULL,
    [numero_version]             VARCHAR (20)   NULL,
    [estado_propuesta_version]   VARCHAR (50)   NULL,
    [estado]                     NUMERIC (1)    NULL,
    [created]                    DATETIME       NULL,
    [created_by]                 NUMERIC (10)   NULL,
    [updated]                    DATETIME       NULL,
    [updated_by]                 NUMERIC (10)   NULL,
    [owner_id]                   NUMERIC (10)   NULL,
    [is_deleted]                 NUMERIC (1)    NULL,
    CONSTRAINT [PK_pro_propuesta_documento] PRIMARY KEY CLUSTERED ([pro_propuesta_documento_id] ASC)
);


GO

