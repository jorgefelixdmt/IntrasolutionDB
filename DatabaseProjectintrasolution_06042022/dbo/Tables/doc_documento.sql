CREATE TABLE [dbo].[doc_documento] (
    [doc_documento_id]        NUMERIC (10)  IDENTITY (1, 1) NOT NULL,
    [codigo]                  VARCHAR (50)  NULL,
    [titulo]                  VARCHAR (300) NULL,
    [descripcion]             VARCHAR (MAX) NULL,
    [palabras_clave]          VARCHAR (500) NULL,
    [version]                 VARCHAR (10)  NULL,
    [motivo_version]          VARCHAR (500) NULL,
    [archivo]                 VARCHAR (500) NULL,
    [tamano]                  NUMERIC (10)  NULL,
    [flag_version]            CHAR (1)      NULL,
    [doc_folder_id]           NUMERIC (10)  NULL,
    [doc_documento_origen_id] NUMERIC (10)  NULL,
    [numero_revision]         NUMERIC (10)  NULL,
    [estado_revision]         VARCHAR (50)  NULL,
    [folder_categoria]        VARCHAR (50)  NULL,
    [fecha_documento]         DATETIME      NULL,
    [fecha_revision]          DATETIME      NULL,
    [anno]                    NUMERIC (10)  NULL,
    [fb_empleado_autor_id]    NUMERIC (10)  NULL,
    [fb_uea_pe_id]            NUMERIC (10)  NULL,
    [created]                 DATETIME      NULL,
    [created_by]              NUMERIC (10)  NULL,
    [updated]                 DATETIME      NULL,
    [updated_by]              NUMERIC (10)  NULL,
    [owner_id]                NUMERIC (10)  NULL,
    [is_deleted]              NUMERIC (1)   NULL,
    CONSTRAINT [PK_doc_documento] PRIMARY KEY CLUSTERED ([doc_documento_id] ASC)
);


GO

