CREATE TABLE [dbo].[pro_propuesta_version] (
    [pro_propuesta_version_id]  NUMERIC (10)   IDENTITY (1, 1) NOT NULL,
    [pro_propuesta_id]          NUMERIC (10)   NULL,
    [fecha_documento]           DATETIME       NULL,
    [monto_propuesta_version]   NUMERIC (10)   NULL,
    [observaciones]             VARCHAR (4096) NULL,
    [archivo_propuesta_version] VARCHAR (1024) NULL,
    [numero_version]            VARCHAR (50)   NULL,
    [created]                   DATETIME       NULL,
    [created_by]                NUMERIC (10)   NULL,
    [updated]                   DATETIME       NULL,
    [updated_by]                NUMERIC (10)   NULL,
    [owner_id]                  NUMERIC (10)   NULL,
    [is_deleted]                NUMERIC (1)    NULL,
    CONSTRAINT [PK_pro_propuesta_version] PRIMARY KEY CLUSTERED ([pro_propuesta_version_id] ASC)
);


GO

